
import processing.serial.*;
Serial myPort; 
String sensorReading = ""; 
String sensorInter = "";
int serialInter = 0;
int serialFrame = 0;
Boolean serialStatus = false;

PImage image;
PFont textFont1;
PFont textFont2;
        
int userWindow = 0;
int frame = 0; //For circulation

//Trasition animation
int graduStatus = 0;
int graduDisappear = 255; //Controlling the transparency, make trasition animation  
int j = 1; //A parameter within trasition animation
int i = 0; //For circulation within trasition animation

int clickChange = 1; //Used in userWindow 0 to change color of text and rect by moving mouse over them
int a1 = 0; //Used in userWindow 1 to control the length of loading bar

int batteryNumber = 0;
int losingCounter = 0;
int generatingCounter = 0;

//Text Display
int textNum = 11;
String[] textString = new String[11];
String[] textDisplay = new String[textNum];
int textpointer = 0;
int randomeNum = 0;
int textFrame = 0;

//Key Example
int keyBoolean = 0;
int keyCounter = 0;
int keyInter = 0;
int t = 5; //Capacity of battery

Boolean autoDecrease = false;
