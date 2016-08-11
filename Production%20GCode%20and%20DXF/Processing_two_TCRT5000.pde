import processing.serial.*;

Serial myPort;
PImage bg,red,green,blue,off;
boolean redState, greenState, blueState;
//int recredState, recgreenState, recblueState;
String tcrt5001; float Valtcrt5001;
String tcrt5002; float Valtcrt5002;
String photores; float Valphotores;

void setup(){
 size(640,450);

 smooth();
 bg = loadImage("bg.png");
 background(bg);
 cursor(HAND);
 
 myPort = new Serial(this, "COM20", 9600);
 myPort.bufferUntil('\n');
}

void serialEvent (Serial myPort){
  tcrt5001 = myPort.readStringUntil('\t');
  Valtcrt5001 = float(tcrt5001);
  tcrt5002 = myPort.readStringUntil('\t');
  Valtcrt5002 = float(tcrt5002);
  photores = myPort.readStringUntil('\t');
  Valphotores = float(photores);
  print(int(Valtcrt5001),int(Valtcrt5002),int(Valphotores));
  println('\t');
  myPort.clear();
}
void draw(){
   //clear();
  while (myPort.available() > 0) {
    
    float sensorValRight = Valtcrt5001;
    float barHeightRight=map(sensorValRight,0,2000,0,195);
    float sensorValLeft = Valtcrt5002;
    float barHeightLeft=map(sensorValLeft,0,2000,0,195);
    
    clear();
    bg = loadImage("bg.png");
    background(bg);
    
    red = loadImage("redON.png");
    green = loadImage("greenON.png");
    blue = loadImage("blueON.png");
    off = loadImage("OFF.png");
    
    //===================== WORKING WITH TCRT5000 EYEs ========================//
    //Bar sensor left or left eys value
    noStroke();
    fill(236,222,30);
    rect(51,377,39,-barHeightLeft);
  
    textSize(12);
    fill(255);
    textAlign(CENTER);
    text(int(sensorValLeft),70,395);
  
    //Bar sensor right or right eys value
    noStroke();
    fill(236,222,30);
    rect(width-89,377,39,-barHeightRight);
    
    textSize(12);
    fill(255);
    textAlign(CENTER);
    text(int(sensorValRight),width - 70,395);
    
    //===================== WORKING WITH LDR ========================//
    //LDR bar and text
    float ldrRange=map(Valphotores,0,1100,0,131);
    fill(236,222,30);
    rect(width/2-175,height/2+110,351,-ldrRange);
    
    textSize(100);
    fill(255);
    textAlign(CENTER);
    text(int(Valphotores),width/2,height/2+80);



    //===================== WORKING WITH LED SWITCH ========================//
    //Red button  
    //redState = recredState;
    if(redState){
      image(red,224,height-81);
    }else{
      image(off,224,height-81);
    }
    //rect(224,height-81,50,30);
    if(mousePressed && mouseX>224 && mouseX<224+25 && mouseY>370 && mouseY<400){
        image(off,224,height-81);
        redState = false;
    }
    else if(mousePressed && mouseX>224 && mouseX<224+50 && mouseY>370 && mouseY<400){
        image(red,224,height-81);
        redState = true;
    } 
    
    //Green button  
    //greenState = recgreenState;
    if(greenState){
      image(green,296,height-81);
    }else{
      image(off,296,height-81);
    }
    //rect(296,height-81,50,30);
    if(mousePressed && mouseX>296 && mouseX<(296+25) && mouseY>370 && mouseY<400){
        image(off,296,height-81);
        greenState = false;
    }else if(mousePressed && mouseX>296 && mouseX<(296+50) && mouseY>370 && mouseY<400){
        image(green,296,height-81);
        greenState = true;
    }
    
    //Blue button  
    //blueState = recblueState;
    if(blueState){
      image(blue,368,height-81);
    }else{
      image(off,368,height-81);
    }
    //rect(368,370,50,30);
    if(mousePressed && mouseX>368 && mouseX<(368+25) && mouseY>370 && mouseY<400){
        image(off,368,height-81);
        blueState = false;
    }else if(mousePressed && mouseX>368 && mouseX<(368+50) && mouseY>370 && mouseY<400){
        image(blue,368,height-81);
        blueState = true;
    } 
    
    //redState, greenState, blueState;
    if((redState==true)&&(greenState==true)&&(blueState==true)){
       myPort.write("RGB"); 
       //myPort.write('\n');
    }else if((redState == true) && (greenState==true)){
       myPort.write("RG");
       //myPort.write('\n');
    }else if((redState==true)&&(blueState==true)){
       myPort.write("RB"); 
       //myPort.write('\n');
    }else if((greenState==true)&&(blueState==true)){
       myPort.write("GB"); 
       //myPort.write('\n');
    }else if(redState == true){
       myPort.write("R");
       //myPort.write('\n');
    }else if(greenState == true){
       myPort.write("G"); 
       //myPort.write('\n');
    }else if(blueState == true){
       myPort.write("B");
       //myPort.write('\n');
    }else{
       myPort.write("off"); 
       //myPort.write('\n');
    }
  }
}