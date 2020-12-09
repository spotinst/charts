#!/usr/bin/env python3

import threading
import time
import os

def leave():
   print("leaving soon")
   time.sleep(5)
   print("os._exit(0)")
   os._exit(0)

t1 = threading.Thread(target = leave)
t1.start()

while True:
   print("ok")
   time.sleep(1)


