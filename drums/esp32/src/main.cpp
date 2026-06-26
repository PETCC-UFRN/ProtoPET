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
    uint16_t value;
    uint32_t timestamp;
};

const int n = 2;

DrumPad pads[n] = {

    {
        2,
        500,
        900,
        0
    },

    {
        4,
        500,
        900,
        0
    },

};

const int scanTime = 12;         // ms procurando pico
const int retriggerDelay = 120;  // ms

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

            int value = clampMIDI(pads[i].min, pads[i].max, peak);

            Packet packet;
            packet.header = 0xAA;
            packet.pad = i;
            packet.value = value;
            packet.timestamp = micros();

            Serial.write(
                (uint8_t*)&packet,
                sizeof(Packet)
            );

        }
    }
}
