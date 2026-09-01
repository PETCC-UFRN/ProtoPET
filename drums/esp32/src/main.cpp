#include <Arduino.h>

struct DrumPad {
    int pin;
    int min;
    int max;
    unsigned long lastHit;
};

struct __attribute__((packed)) Packet {
    uint8_t header;
    uint8_t pad;
    uint8_t value;
    uint32_t timestamp;
};

const int n = 4;

// altere os valores a depender de quantos pads você está utilizando
DrumPad pads[n] = {
    {
        2,
<<<<<<< HEAD
        100,
=======
        400,
>>>>>>> da69d6b (Feat: 4 tambores)
        900,
        0
    },
    {
<<<<<<< HEAD
        4,
        100,
=======
        27,
        400,
>>>>>>> da69d6b (Feat: 4 tambores)
        900,
        0
    },
    {
<<<<<<< HEAD
        15,
        100,
        850,
=======
        12,
        400,
        900,
        0
    },
    {
        32,
        400,
        900,
>>>>>>> da69d6b (Feat: 4 tambores)
        0
    },
};

const int scanTime = 4;         // ms procurando pico
const int retriggerDelay = 35;  // ms

void printPad(int pad, int value) {
    Serial.print("[");
    Serial.print(pad);
    Serial.print("]: ");
    Serial.print(value);
    Serial.println();
}

uint8_t clampMIDI(int min, int max, int value) {

    value = constrain(value, min, max);

    return map(value, min, max, 1, 127);
}

void setup() {
    Serial.begin(115200);
    // Serial.println(sizeof(Packet));
}

void loop() {

    for(int i = 0; i < n; i++) {

        int value = analogRead(
            pads[i].pin
        );

        // detecta início da pancada
        if (
            value > pads[i].min &&
            millis() - pads[i].lastHit > retriggerDelay
        ) {

            int peak = value;

            unsigned long start = millis();

            // procura maior valor
            while(millis() - start < scanTime) {

                value = analogRead(
                    pads[i].pin
                );

                if(value > peak) {
                    peak = value;
                }
            }
            
            pads[i].lastHit = millis();

            Packet packet;
            packet.header = 0xAA;
            packet.pad = i;
            packet.value = clampMIDI(pads[i].min, pads[i].max, peak);
            packet.timestamp = micros();

            // printPad(i, packet.value);

            Serial.write(
                (uint8_t*)&packet,
                sizeof(Packet)
            );

        }
    }
}
