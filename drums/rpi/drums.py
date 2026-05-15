import serial
import mido

# UART
ser = serial.Serial(
    '/dev/serial0',
    115200,
    timeout=1
)

# MIDI virtual
midi_out = mido.open_output('Virtual Raw MIDI 1-0')

while True:

    line = ser.readline().decode().strip()

    if not line:
        continue

    try:
        value = int(line)

    except:
        continue

    # ADC -> MIDI velocity
    velocity = int(value / 4095 * 127)

    velocity = max(1, min(127, velocity))

    print(value, velocity)

    midi_out.send(
        mido.Message(
            'note_on',
            note=38,
            velocity=velocity
        )
    )

    midi_out.send(
        mido.Message(
            'note_off',
            note=38,
            velocity=0
        )
    )
