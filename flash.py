from time import time, sleep
import RPi.GPIO as GPIO

GPIO.setmode(GPIO.BOARD)

# trigger pin is activ on low for safety
trigger_pin = 11 # BCM 17 
power_pin = 12 # BCM 18

def set_pin(pin, state, setOutputMode=False):
    if setOutputMode:
        GPIO.setup(pin, GPIO.OUT)
    if state:
        GPIO.output(pin, GPIO.HIGH)
    else:
        GPIO.output(pin, GPIO.LOW)

def charge(duration=40):
    set_pin(trigger_pin, True, setOutputMode=True)
    set_pin(power_pin, False, setOutputMode=True)
    # pwm = GPIO.PWM(power_pin, 100)
    # pwm.start(40)
    set_pin(power_pin, True)
    sleep(duration)
    # pwm.stop()
    set_pin(power_pin, False)

def trigger(delay=False):
    set_pin(trigger_pin, False)
    if delay:
        sleep(1/100)

def cleanup():
    GPIO.cleanup()
    
if __name__ == '__main__':
    try:
        charge()
        print("Flash!")
        trigger(delay=True)

    finally:
        cleanup() 
