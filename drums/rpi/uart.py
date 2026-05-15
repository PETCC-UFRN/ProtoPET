import serial

ser = serial.Serial('/dev/serial0', 115200)

while True:
    linha = ser.readline().decode().strip()
    print(linha)
