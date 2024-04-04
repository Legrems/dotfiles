import libtmux
import configparser
import time
import sys


from pathlib import Path
from pyfzf.pyfzf import FzfPrompt

CONF_KEYS = []


config = configparser.ConfigParser()
config.read(Path("~/.ssh-tmux-groups.ini").expanduser())

fzf = FzfPrompt()
group = fzf.prompt(config.sections(), "--cycle")[0]

servers = []
for key, enabled in config[group].items():
    if key in CONF_KEYS:
        continue

    if enabled == "true":
        servers.append(key)

if not servers:
    sys.exit(1)

srv = libtmux.Server()
active_session = srv.sessions.filter(session_attached='1')[0]
window = active_session.new_window(f"ssh-multig {','.join(servers)}", window_shell=f"ssh {servers[0]}")

for server in servers[1:]:
    window.select_layout("tiled")
    pane = window.split(shell=f"ssh {server}")

# Wait until tmux finished working
time.sleep(0.1)

# Confirm connection on asking panes
confirmation_needed_text = "Are you sure you want to continue connecting (yes/no/[fingerprint])?"
for pane in window.panes:
    pane_content = pane.capture_pane()
    if pane_content and confirmation_needed_text == pane_content[-1]:
        pane.send_keys("yes")

window.set_window_option("synchronize-panes", "on")
pane = window.panes[0]
pane.send_keys("sudo su -")
window.set_window_option("synchronize-panes", "off")

window.select()
srv.cmd("select-layout", "tiled")
