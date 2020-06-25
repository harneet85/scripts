"""
Written by K-DawG007
My SO profile: http://stackoverflow.com/users/2425215/k-dawg
"""

import tkinter as Tk
import sys
import threading
"""
root = Tk.Tk()
text = Tk.Text(root)
text.pack()
"""
exit_thread= False
exit_success = False

class Std_redirector(object):
    def __init__(self,widget):
        self.widget = widget

    def write(self,string):
        if not exit_thread:
            self.widget.insert(Tk.END,string)
            self.widget.see(Tk.END)

def stop_thread():
    global exit_thread
    exit_thread = True
    if exit_success:
        root.destroy()

def gen():
    x = 0
    while not exit_thread:
        yield x
        x+= 1
    exit_success = True

def call_gen():
    for i in gen():
        print(i)

"""
exit_button = Tk.Button(root,text='Exit',command=stop_thread)
exit_button.pack()

sys.stdout = Std_redirector(text)

print(2)

thread1 = threading.Thread(target=call_gen)
thread1.start()

#root.mainloop()
"""