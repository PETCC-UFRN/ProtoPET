#include <Arduino.h>

const int piezoPin = 4;

const int threshold = 150;

const int scanTime = 12;         // ms procurando pico
const int retriggerDelay = 120;  // ms

unsigned long lastHit = 0;

void setup() {
    Serial.begin(115200);
}

void loop() {

    int value = analogRead(piezoPin);

    // detecta início da pancada
    if (
        value > threshold &&
        millis() - lastHit > retriggerDelay
    ) {

        int peak = value;

        unsigned long start = millis();

        // procura maior valor
        while(millis() - start < scanTime) {

            value = analogRead(piezoPin);

            if(value > peak) {
                peak = value;
            }
        }

        lastHit = millis();

        Serial.println(peak);
    }
}
