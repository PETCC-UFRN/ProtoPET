#include <Arduino.h>

struct DrumPad {
    int pin;
    int threshold;
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
        100,
        0
    },

    {
        4,
        100,
        0
    },

};

const int scanTime = 12;         // ms procurando pico
const int retriggerDelay = 120;  // ms

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
            value > pads[i].threshold &&
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

            // envia:
            // indice:valor
            // exemplo:
            // // 0:3200
            // Serial.print(i);
            // Serial.print(":");
            // Serial.println(peak);

            Packet packet;
            packet.header = 0xAA;
            packet.pad = i;
            packet.value = peak;
            packet.timestamp = micros();

            

            Serial.write(
                (uint8_t*)&packet,
                sizeof(Packet)
            );

        }
    }
}