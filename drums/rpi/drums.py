# drums.py

import serial
import mido

# UART
ser = serial.Serial(
    '/dev/serial0',
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

while True:

    line = ser.readline().decode().strip()

    if not line:
        continue

    try:
        value = int(line)

    except:
        continue

    # converte 0-4095 -> 0-127
    velocity = int(value / 4095 * 127)

    velocity = max(1, min(127, velocity))

    print(value, velocity)

    # caixa
    midi_out.send(
        mido.Message(
            'note_on',
            channel=9,
            note=38,
            velocity=velocity
        )
    )
    midi_out.send(
        mido.Message(
            'note_off',
            channel=9,
            note=38
        )
    )
