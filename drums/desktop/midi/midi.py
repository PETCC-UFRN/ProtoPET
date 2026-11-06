import serial
import struct
import mido

PACKET_FORMAT = '>BBBI'
PACKET_SIZE = struct.calcsize(PACKET_FORMAT)
# UART
ser = serial.Serial(
    '/dev/ttyACM0',
    115200,
    timeout=1
)

# encontra porta do Hydrogen
outputs = mido.get_output_names()

hydrogen_port = next(
    p for p in outputs
    if 'Hydrogen' in p
)

print("Conectado em:", hydrogen_port)

midi_out = mido.open_output(hydrogen_port)

# mapeamento:
# pad -> nota MIDI
PAD_NOTES = {
    0: 45,  # tom-esquerdo
    1: 38,  # caixa
    2: 36,  # bumbo
}

ser.reset_input_buffer()

while True:

    # lê pacote binário
    data = ser.read(PACKET_SIZE)
    if len(data) == PACKET_SIZE:
        header, pad, value, timestamp = struct.unpack(PACKET_FORMAT, data)
        if header == 0xAA:
            print(f"{pad}: {value}")
            nota_midi = PAD_NOTES.get(pad, 38)
            
            midi_out.send(
                mido.Message(
                    'note_on',
                    channel=9,
                    note=nota_midi,
                    velocity=value
                )
            )
