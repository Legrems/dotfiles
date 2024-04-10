import libtmux
import configparser
import time
import sys
import os


from pathlib import Path
from pyfzf.pyfzf import FzfPrompt


BASE_PATH = Path("~/.ssh-tmux/").expanduser()

configs = {}
sections = {}
for subconffile in os.listdir(BASE_PATH):
    config = configparser.ConfigParser()
    config.read(BASE_PATH / subconffile)

    configs[subconffile] = config

    for section in config.sections():
        sections[section] = subconffile


fzf = FzfPrompt()
selected_group = fzf.prompt(sections.keys(), "--cycle")[0]

config = configs[sections[selected_group]]

servers = config[selected_group]["servers"].split("\n")

extra_commands = []
if "commands" in config[selected_group].keys():
    extra_commands = config[selected_group]["commands"].split("\n")

if not servers:
    sys.exit(1)

srv = libtmux.Server()
active_sessions = srv.sessions.filter(session_attached='1')

if active_sessions:
    active_session = active_sessions[0]

else:
    raw_try = srv.cmd("display", "-p", "#{session_name}").stdout
    if raw_try:
        active_session = srv.sessions.filter(name=raw_try[0])[0]

    else:
        active_session = srv.sessions[0]

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

for command in extra_commands:
    pane.send_keys(command)

window.set_window_option("synchronize-panes", "off")

window.select()
srv.cmd("select-layout", "tiled")
