import serial
import struct
import mido

PACKET_SIZE = 8
PACKET_FORMAT = '>BBHL'
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
    0: 38,  # snare
    1: 36,  # kick
    #2: 42   # hihat
}

ser.reset_input_buffer()

while True:

    # lê pacote binário
    data = ser.read(PACKET_SIZE)
    if len(data) == PACKET_SIZE:
        header, pad, value, timestamp = struct.unpack(PACKET_FORMAT, data)
        if header == 0xAA:

            # converte ADC -> velocity MIDI
            velocity = int((value / 4095) * 127)

            velocity = max(1, min(127, velocity))
        
            print(f"{pad}: {value} {velocity}")
            nota_midi = PAD_NOTES.get(pad, 38)
            
            midi_out.send(
                mido.Message(
                    'note_on',
                    channel=9,
                    note=nota_midi,
                    velocity=velocity
                )
            )

            midi_out.send(
                mido.Message(
                    'note_off',
                    channel=9,
                    note=nota_midi
                )
            )
