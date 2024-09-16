#include <Wire.h>
#include <Keyboard.h>
//const int MPU = 0x68;
int16_t AcX, AcY, AcZ, Tmp, GyX, GyY, GyZ;

void setup() {
  Wire.begin();
  Wire.beginTransmission(0x68);
  Wire.write(0x6B);
  Wire.write(0);
  Wire.endTransmission(true);
  Serial.begin(9600);
  Keyboard.begin();
}
void loop() {
  Wire.beginTransmission(0x68);
  Wire.write(0x3B);
  Wire.endTransmission(false);
  Wire.requestFrom(0x68, 12, true);
  //AcX=Wire.read()<<8|Wire.read();
  //AcY=Wire.read()<<8|Wire.read();
  //AcZ=Wire.read()<<8|Wire.read();
  //GyX = Wire.read() << 8 | Wire.read();
  GyY = Wire.read() << 8 | Wire.read();
  //GyZ = Wire.read() << 8 | Wire.read();

  //Serial.print("Accelerometer: ");
  //Serial.print("X = "); Serial.print(AcX);
  //Serial.print(" | Y = "); Serial.print(AcY);
  //Serial.print(" | Z = ");  Serial.println(AcZ);

  Serial.print("Gyroscope: ");
  //Serial.print("X  = "); Serial.print(GyX);
  Serial.print(" | Y = "); Serial.print(GyY);
  int keyPress = GyY;
  //Serial.print(" | Z = "); Serial.println(GyZ);
  if (keyPress > 10000) {
    Serial.print(" Leaning Hard Left : D");
    Keyboard.write('d');
    }
  else if (1000 < keyPress and keyPress < 10000) {
    Serial.print(" Leaning Left : F");
    Keyboard.write('f');
  }
  else if (-1000 < keyPress and keyPress < 1000) {
    Serial.print(" Not Leaning : G");
    
    //Keyboard.write('m');
  }
  else if (-10000 < keyPress and keyPress < -1000) {
    Serial.print(" Leaning Right : H");
    Keyboard.write('h');
  }
  else if (keyPress < -10000) {
    Serial.print(" Leaning Hard Right : J");
    Keyboard.write('j');}
  Serial.println(" ");
  delay(5);
}