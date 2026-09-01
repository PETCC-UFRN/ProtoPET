import serial 
import struct 
import threading
from pynput.keyboard import Controller


PACKET_FORMAT = '<BBBI'
PACKET_SIZE = struct.calcsize(PACKET_FORMAT)

keyboard = Controller()
ser = serial.Serial('/dev/ttyACM0', 115200, timeout=1)
ser.reset_input_buffer()

PAD_NOTES = {
<<<<<<< HEAD
    0: ['a', 'q'],
    1: ['s', 'w'],
    2: ['j', 'u'],
    3: ['i', 'k'],
=======
    0: 'l',
    1: 's',
    2: 'a',
    3: 'l',
>>>>>>> da69d6b (Feat: 4 tambores)
}


def free_key(pad):
    if pad in PAD_NOTES:
        for key in PAD_NOTES[pad]:
            keyboard.release(key)

while True:
    # lê pacote binário
    byte = ser.read(1)
    if byte == b'\xAA':
        resto = ser.read(PACKET_SIZE - 1)
        if len(resto) == PACKET_SIZE - 1:
            header, pad, value, timestamp = struct.unpack(PACKET_FORMAT, byte + resto)
            if pad in PAD_NOTES:
                for key in PAD_NOTES[pad]:
                    keyboard.press(key)

            threading.Timer(0.02, free_key, args=[pad]).start()

<<<<<<< HEAD

=======
>>>>>>> da69d6b (Feat: 4 tambores)
