import sh
import json


def i3_command(command, *args, **kwargs):
    try:
        return json.loads(sh.i3_msg(command, *args, **kwargs).stdout)
    except:
        return []


def get_workspaces():
    return i3_command("-t", "get_workspaces")

def get_output():
    return i3_command("-t", "get_outputs")

def test():
    pass

print(get_workspaces())
print(get_output())
