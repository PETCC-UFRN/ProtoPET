// Código Arduino
// ==============================================================
// #include <Arduino.h>

// const int PIEZO_PIN = A0; 
// const int THRESHOLD = 80; 

// void setup() {
//     Serial.begin(9600);
//     Serial.println("--- Teste Piezo no Arduino Inicializado ---");
// }

// void loop() {
//     int sensorValue = analogRead(PIEZO_PIN);

//     if (sensorValue > THRESHOLD) {
//         Serial.print("Vibracao detectada! Valor: ");
//         Serial.println(sensorValue);
        
//         delay(100); // Debounce básico
//     }
// }
// ==============================================================

// Código ESP32(Não funcional ainda)
// ==============================================================
// #include <Arduino.h>

// const int piezoPin = 1; 
// const int threshold = 0; // Ajuste a sensibilidade aqui

// void setup() {
//     Serial.begin(115200);
//     Serial.println("\n--- ESP32 Piezo Hello World ---");
// }

// void loop() {
//     int rawValue = analogRead(piezoPin);

//     if (rawValue > threshold) {
//         Serial.println(rawValue);
//         delay(100);
//     }
// }
// ==============================================================