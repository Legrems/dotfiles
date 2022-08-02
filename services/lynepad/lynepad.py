from pynput import keyboard
import signal
import datetime


def handler(signum, frame):
    if input("Ctrl-c was pressed. Do you really want to exit? y/N") != "n":
        exit(1)


signal.signal(signal.SIGINT, handler)

FROM_LYNEPAD = False
THE_LYNEPAD_KEY_VK = 269025200
def on_press(key):
    global FROM_LYNEPAD

    if hasattr(key, "vk"):
        print(key, FROM_LYNEPAD)
        if key.vk == THE_LYNEPAD_KEY_VK:
            FROM_LYNEPAD = True

        elif FROM_LYNEPAD:
            with open("keys.logs", "a") as file:
                file.write(f"{datetime.datetime.now().isoformat()}:{key.vk}:{key.char}\n")


def on_release(key):
    global FROM_LYNEPAD

    if hasattr(key, "vk"):
        if key.vk == THE_LYNEPAD_KEY_VK:
            FROM_LYNEPAD = False
            print("released")

listener = keyboard.Listener(on_press=on_press, on_release=on_release)
listener.start()
listener.join()
