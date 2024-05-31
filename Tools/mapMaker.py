from pynput import keyboard

table = []
def on_press(key):
    try:
        pass
        #print('alphanumeric key {0} pressed'.format(key.char))
    except AttributeError:
        pass
        #print('special key {0} pressed'.format( key))
    if(key.char == "d"):
        table.append("00111111")
    if(key.char == "f"):
        table.append("11001111")
    if(key.char == "j"):
        table.append("11110011")
    if(key.char == "k"):
        table.append("11111100")
    if(key.char == "n"):    
        table.append("11111111")
    if(key.char == "i"):
        table.pop()
    print("TABLE:")
    for i in table:
        print(" DB "+i+"B")
        
def on_release(key):
    print('{0} released'.format(
        key))
    if key == keyboard.Key.esc:
        # Stop listener
        return False

# Collect events until released
with keyboard.Listener(
        on_press=on_press,
        on_release=on_release) as listener:
    listener.join()

# ...or, in a non-blocking fashion:
listener = keyboard.Listener(
    on_press=on_press,
    on_release=on_release)
listener.start()

