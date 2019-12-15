// This demo triggers a text display with each new message
// Works with DTW
// Set number of DTW gestures and their namesBelow

//Necessary for OSC communication with Wekinator:
import oscP5.*;
import netP5.*;
import ddf.minim.*;
import ddf.minim.ugens.*;
OscP5 oscP5;
NetAddress dest;

String[] messageNames = {"/output_1", "/output_2", "/output_3","/output_4","/output_5" }; //message names for each DTW gesture type

//No need to edit:
PFont myFont, myBigFont;
final int myHeight = 400;
final int myWidth = 400;
int frameNum = 0;
int[] hues;
int[] textHues;
int numClasses;
int currentHue = 100;
int currentTextHue = 255;
String currentMessage = "Waiting...";
float amp = 0.0;
int k=0;

Minim       minim;
AudioOutput out;
Oscil       wave;

void setup() {
    size(640,360, P3D);
     noStroke();
  fill(204);
 
  colorMode(HSB);
  smooth();
  numClasses = messageNames.length;
  hues = new int[numClasses];
  textHues = new int[numClasses];
  for (int i = 0; i < numClasses; i++) {
     hues[i] = (int)generateColor(i); 
     textHues[i] = (int)generateColor(i+1);
  }
  
  minim = new Minim(this);
  out = minim.getLineOut();
  wave = new Oscil( 440, 0.5f, Waves.SQUARE );
  wave.setAmplitude(0);
  // patch the Oscil to the output
  wave.patch( out );
  
  //Initialize OSC communication
  oscP5 = new OscP5(this,12000); //listen for OSC messages on port 12000 (Wekinator default)
  dest = new NetAddress("127.0.0.1",6448); //send messages back to Wekinator on port 6448, localhost (this machine) (default)
  
  
  String typeTag = "f";
  for (int i = 1; i < numClasses; i++) {
    typeTag += "f";
  }
  //myFont = loadFont("SansSerif-14.vlw");
  myFont = createFont("Arial", 14);
  myBigFont = createFont("Arial", 60);
}

void draw() {
  frameRate(30);
  background(0, 150);
  drawText();
    translate(width/1.3, height/1.6, 0);

    lights();
    ambientLight(0,0,255);
       pointLight(255, 0, 0, width/2, height/2, 400);
    shape(k);
    
  if (amp > 0.001) {
    amp = .5 * amp;
  } else {
    amp = 0;
  }
  wave.setAmplitude( amp );
}


//This is called automatically when OSC message is received
void oscEvent(OscMessage theOscMessage) {
 //println("received message");
 for (int i = 0; i < numClasses; i++) {
    if (theOscMessage.checkAddrPattern(messageNames[i]) == true) {
    

     // println("received1");
      showMessage(i);
      k=i+1;
    shape(k);
    
    }
      
}

}
void showMessage(int i) {
    currentHue = hues[i];
    currentTextHue = textHues[i];
    currentMessage = messageNames[i];
    
   
    wave.setFrequency((float)(261 * Math.pow(1.059, i*2)));
     amp = 1;
}



//Write instructions to screen.
void drawText() {
    stroke(0);
    textFont(myFont);
    textAlign(LEFT, TOP); 
    fill(currentTextHue, 255, 255);

    text("Receives DTW messages from wekinator", 10, 10);
    text("Listening for " + numClasses + " DTW triggers:", 10, 30);
    for (int i= 0; i < messageNames.length; i++) {
       text("     " + messageNames[i], 10, 47+17*i); 
    }
    textFont(myBigFont);
    text(currentMessage, 20, 180);
}


float generateColor(int which) {
  float f = 100; 
  int i = which;
  if (i <= 0) {
     return 100;
  } 
  else {
     return (generateColor(which-1) + 1.61*255) %255; 
  }
}



void shape( int k){
    switch(k){
      case 1:
      sphere(100);
      break;
      case 2:
      box(120);
      break;
      case 3:

      rotateX(PI/2);
      rotateZ(-PI);
      stroke(100, 50, 100);


beginShape();
vertex(-100, -50, -100);
vertex( 100, -100, -100);
vertex(   0,    0,  100);

vertex( 100, -100, -100);
vertex( 100,  100, -100);
vertex(   0,    0,  100);

vertex( 100, 100, -100);
vertex(-100, 100, -100);
vertex(   0,   0,  100);

vertex(-100,  100, -100);
vertex(-100, -100, -100);
vertex(   0,    0,  100);
endShape();
//fill(153, 102, 0);

stroke(100, 50, 100);
break;

case 4:
stroke(100, 50, 100);

line(30, 20, 130, 110);
break;
    }
   }
  