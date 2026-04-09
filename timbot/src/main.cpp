#include <Arduino.h>
#include <ESP32Servo.h>

#define TRIG 5
#define ECHO 18
#define SERVO_PIN 13

Servo servo;

float readDistance(){
  digitalWrite(TRIG, LOW);
  delayMicroseconds(2);

  digitalWrite(TRIG, HIGH);
  delayMicroseconds(10);

  float duration = pulseIn(ECHO, HIGH);
  float distance = duration * 0.034 / 2;

  return distance;
}

float getWallsDistance(int angle){
  servo.write(angle);
  delay(150);

  return readDistance();
}


void setup() {
  Serial.begin(115200);

  pinMode(TRIG, OUTPUT);
  pinMode(ECHO, INPUT);

  servo.attach(SERVO_PIN);
}

void loop() {
  float left = getWallsDistance(150);
  float front = getWallsDistance(90);
  float right = getWallsDistance(0);

  Serial.print("L: "); Serial.print(left);
  Serial.print(" F: "); Serial.print(front);
  Serial.print(" R: "); Serial.println(right);

  delay(100);
}
