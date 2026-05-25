import serial

ser = serial.Serial(
    '/dev/serial0',
    115200,
    timeout=1
)

while True:

    data = ser.read(1)

    print(data)
