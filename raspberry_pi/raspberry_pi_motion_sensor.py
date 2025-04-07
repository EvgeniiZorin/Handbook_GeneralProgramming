from machine import Pin
import time

pir = Pin(0, Pin.IN, Pin.PULL_DOWN)
led = Pin(2, Pin.OUT)
pir_state = False
# timestamp of the last motion detected
last_motion_time = 0
# debounce period in seconds
debounce_time = 3

print("PIR Module Initialised")
time.sleep(1)
print("Ready")

while True:
    val = pir.value() # read input value from PIR sensor
    current_time = time.time()
    print(val)
    if val == 1: # motion detected
        if not pir_state and (current_time - last_motion_time > debounce_time):
            print("Motion detected!")
            pir_state = True
            led.on() # turn on LED
            last_motion_time = current_time
    elif val == 0: # no motion detected
        if pir_state and (current_time - last_motion_time >= debounce_time):
            pir_state = False
            led.off()
            last_motion_time = current_time
    time.sleep(1) # small delay to prevent spamming
