import serial
import struct
from pynput.keyboard import Controller


PACKET_FORMAT = '<BBBI'
PACKET_SIZE = struct.calcsize(PACKET_FORMAT)

PAD_NOTES = {
    0: 'd',  # chimbau
    1: 'f',  # prato esquerda
    2: 's',  # caixa
    3: 'j',  # tom esquerda
    4: 'k',  # tom direita
    5: 'm',  # prato direito
    6: 'a',  # surdo
}

keyboard = Controller()

ser = serial.Serial(
    '/dev/ttyACM0',
    115200,
    timeout=1
)

ser.reset_input_buffer()


while True:
    byte = ser.read(1)

    # Procura o início de um pacote
    if byte != b'\xAA':
        continue

    # Já lemos o header, então faltam 6 bytes
    resto = ser.read(PACKET_SIZE - 1)

    if len(resto) != PACKET_SIZE - 1:
        continue

    header, pad, value, timestamp = struct.unpack(
        PACKET_FORMAT,
        byte + resto
    )

    key = PAD_NOTES.get(pad)

    if key is None:
        continue

    keyboard.press(key)
    keyboard.release(key)
