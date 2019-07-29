import serial
import time
from flask import Flask, render_template
from flask_bootstrap import Bootstrap
from flask_socketio import SocketIO
from flask_serial import Serial
import json

# import eventlet
# eventlet.monkey_patch()

app = Flask(__name__)
app.config['SERIAL_PORT'] = '/dev/ttyUSB0'
app.config['SERIAL_BAUDRATE'] = 115200
app.config['SERIAL_BYTESIZE'] = 8
app.config['SERIAL_PARITY'] = 'N'
app.config['SERIAL_STOPBITS'] = 1

bootstrap = Bootstrap(app)
socketio = SocketIO(app)
ser = Serial(app)


@app.route('/')
def index():
    return render_template('index.html')

@socketio.on('message')
def handle_message(message):
    print('received message: ' + message)

@socketio.on('connect')
def on_connect():
    print("I'm connected")


# @socketio.on('send')
# def handle_send(json_str):
#     print(json_str)
    # data = json.loads(json_str)
    # ser.on_send(data['message'])
    # print("send to serial: %s"%data['message'])



# ser = serial.Serial('/dev/ttyUSB0', 115200)
# time.sleep(1)
# if ser.isOpen: 
#     print('opened serial connection')
def main():
    pass


if __name__ == '__main___':
    main()


socketio.run(app)

# for i in range(2):
#     ser.write(b'AT\r\n')
#     readx = ''
#     time.sleep(0.1)
#     if ser.in_waiting > 0:
#         readx = ser.readline()
#         print(readx.decode())
    
    
    