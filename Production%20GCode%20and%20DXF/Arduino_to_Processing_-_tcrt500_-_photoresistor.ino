int pinPhotores = A4;
int pinTcrt5000 = A0;
int pinTcrt5001 = A1;
int pinR = 10;
int pinG = 11; 
int pinB = 12;
int colRed, colGreen, colBlue;
  
void setup() {
  Serial.begin(9600);
  pinMode(pinTcrt5000, INPUT);
  pinMode(pinTcrt5001, INPUT);
  pinMode(pinPhotores, INPUT);
  pinMode(pinR,OUTPUT);
  pinMode(pinG,OUTPUT);
  pinMode(pinB,OUTPUT);
}

void setColor(int red, int green, int blue)
{
  analogWrite(pinR, red);
  analogWrite(pinG, green);
  analogWrite(pinB, blue);
}

void loop() {
  int tcrt5000 = analogRead(pinTcrt5000);
  int tcrt5001 = analogRead(pinTcrt5001);
  int photores = analogRead(pinPhotores);

  Serial.print(tcrt5000); Serial.print("\t");
  Serial.print(tcrt5001); Serial.print("\t");
  Serial.print(photores); Serial.println("\t");

  
  if (Serial.available()) 
   { // If data is available to read,
     String data = Serial.readString(); // read it and store it in val
     Serial.print(data);
     if(data=="off"){
          setColor(0,0,0);
     }else if(data=="R"){
          setColor(255,0,0);
     }else if(data=="G"){
          setColor(0,255,0);
     }else if(data=="B"){
          setColor(0,0,255);
     }else if(data=="RGB"){
          setColor(255,255,255);
     }else if(data=="RG"){
          setColor(255,255,0);
     }else if(data=="RB"){
          setColor(255,0,255);
     }else if(data=="GB"){
          setColor(0,255,255);
    }
  }
delay(10);
}


