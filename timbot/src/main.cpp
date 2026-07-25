#include <Arduino.h>
#include "robot.h"

void setup() {
  Serial.begin(115200);
  robot_init();
  Serial.println("--- timBot iniciado! ---");
}

void loop() {
  navegacao_executar();
}