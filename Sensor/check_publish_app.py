from typing import OrderedDict

import RPi.GPIO as GPIO
import time
import paho.mqtt.client as mqtt
import datetime as dt
import uuid
import json

s2 = 23 # Raspberry Pi Pin 23
s3 = 24 # Raspberry Pi Pin 24 
out = 25 # sensing pin 25

dev_id = 'DEV_JYJ01'
dev_uid = uuid.uuid3(uuid.NAMESPACE_OID, dev_id) 
broker_address = '210.119.12.78'
  
# NUM_CYCLES = 10

def read_value(a0, a1):
    GPIO.output(s2, a0)
    GPIO.output(s3, a1)
    # 센서를 조정할 시간을 준다

    time.sleep(0.1)
    # 전체주기 웨이팅(전체주기로 계산됨)

    GPIO.wait_for_edge(out, GPIO.FALLING)
    GPIO.wait_for_edge(out, GPIO.RISING)

    start = time.time()

    GPIO.wait_for_edge(out, GPIO.FALLING)

    return (time.time() - start) * 1000000

def setup():
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(out,GPIO.IN, pull_up_down=GPIO.PUD_UP)
    GPIO.setup(s2,GPIO.OUT)
    GPIO.setup(s3,GPIO.OUT)    

# 데이터를 MQTT로 보내는 메서드
def send_data(result, r, g, b):
    send_msg = ''
    if result == 'GREEN':
        send_msg = 'OK'
    elif result == 'RED':
        send_msg = 'FAIL'
    elif result == 'CONN':
        send_msg = 'CONN'
    else:
        send_msg = 'ERR'

    currtime = dt.datetime.now().strftime('%Y-%m-%d %H:%M:%S.%f')

    # groupdata generate
    raw_data = OrderedDict()
    raw_data['dev_id'] = dev_id
    raw_data['prc_time'] = currtime
    raw_data['prc_msg'] = send_msg
    raw_data['param'] = result
    raw_data['red'] = r
    raw_data['green'] = g
    raw_data['blue'] = b

    pub_data = json.dumps(raw_data, ensure_ascii=False, indent='\t')
    #mqtt_publish

    print(pub_data)
    client2.publish('factory1/machine1/data/', pub_data)

def loop():
    result = ""

    while True:
        r = read_value(GPIO.LOW, GPIO.LOW)
        time.sleep(0.1)

        g = read_value(GPIO.HIGH, GPIO.HIGH)
        time.sleep(0.1)

        b = read_value(GPIO.LOW, GPIO.HIGH)

        print('red = {0}, green = {1}, blue = {2}'.format(r, g, b))

        if r > 200000 and g > 200000 and b > 180000:
            result = "BLACK"
        else:
            if (b < g) and (b < r):
                result = "BLUE"
            elif (g < b) and (g < r):
                result = "GREEN"
            elif (r < g) and (r < b):
                result = "RED"

        #print(result)

        send_data(result, r, g, b)
        time.sleep(1)


print('MQTT Client')

client2 = mqtt.Client('FactMachine')
client2.connect(broker_address, 1883)

print('MQTT Connected')

if __name__=='__main__':
    setup()
    send_data('CONN', None, None, None)

    try:
        loop()
    except KeyboardInterrupt:
        GPIO.cleanup()