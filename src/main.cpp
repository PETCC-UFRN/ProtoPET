#include <Arduino.h>

const int sensorPin = A0;
const int ledPin = 13;
const int threshold = 50;

// Função mágica que fala a língua do ttymidi e do Hydrogen
void midiNoteOn(byte channel, byte pitch, byte velocity) {
  Serial.write(0x90 + channel); // Comando MIDI para "Nota Ligada"
  Serial.write(pitch);          // Qual instrumento tocar (ex: 36 = Bumbo)
  Serial.write(velocity);       // Força da batida (0 a 127)
}

void midiNoteOff(byte channel, byte pitch, byte velocity) {
  Serial.write(0x80 + channel); // Comando MIDI para "Nota Desligada"
  Serial.write(pitch);
  Serial.write(velocity);
}

void setup() {
  pinMode(ledPin, OUTPUT);
  // Velocidade super rápida para não ter latência na bateria!
  Serial.begin(115200); 
}

void loop() {
  int leitura = analogRead(sensorPin);
  
  if(leitura > threshold){
    digitalWrite(ledPin, HIGH);

    // Converte a força da batida do Arduino (threshold até ~800) 
    // para o padrão de força do MIDI (1 a 127)
    int forcaMidi = map(leitura, threshold, 800, 50, 127);
    forcaMidi = constrain(forcaMidi, 1, 127); // Garante que não passe de 127

    // Envia a Nota 36 (Que é o som do Kick/Bumbo no Hydrogen)
    midiNoteOn(0, 36, forcaMidi);

    // Espera o som rolar e evita ler o tremor do mesmo toque (debounce)
    delay(40); 
    
    // Desliga a nota
    midiNoteOff(0, 36, 0);
  } else {
    digitalWrite(ledPin, LOW);
  }

  delay(5); // Pequeno respiro para o processador
}