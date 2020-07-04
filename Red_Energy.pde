

void setup() {

  //Initialization
  fullScreen();
  background(0);
  frameRate(60);
  textFont1 = createFont("Arrakis-3.ttf", 32);
  textFont2 = createFont("SourceSansPro-Regular.ttf", 32);
  image = loadImage("red energy logo.png");

  //Arduino Communication
  myPort  = new Serial (this, Serial.list()[13], 9600); // Set the com port and the baud rate according to the Arduino IDE
  myPort.bufferUntil ('\n');   // Receiving the data from the Arduino IDE

  //Text Display
  textString[0] = "Are you ready?";
  textString[1] = "Raise your weapons and fight against your ANGER now!!!";
  textString[2] = "Smash!";
  textString[3] = "Smash harder!";
  textString[4] = "HARDER!";
  textString[5] = "You are almost there!";
  textString[6] = "Hello?";
  textString[7] = "Still Here?";
  textString[8] = "Are you sleeping?";
  textString[9] = "Host, next one, please.";
  textString[10] = "GOOD JOB!! Congratulations!!!";

  for (int x = 0; x < textNum; x++) {
    textDisplay[x] = " ";
  }
}


void draw() { 

  background(0);


  //Start
  if (userWindow == 0) {

    tint(255, graduDisappear);
    image(image, 0, 180, 5*width/6, 2*height/3);

    textFont(textFont1);
    if (clickChange == 1) {
      fill(0, graduDisappear);
    } else {
      fill(#ee3f4d, graduDisappear);
    }
    if (clickChange == 1) {
      stroke(#ee3f4d);
    } else {
      stroke(#ee3f4d, graduDisappear);
    }
    strokeWeight(10);
    rectMode(CENTER);
    rect(width/2+300, height/2-100, 350, 120);

    if (clickChange == 1) {
      fill(#ee3f4d, graduDisappear);
    } else {
      fill(255, graduDisappear);
    }
    textSize(100);
    textAlign(CENTER, CENTER);
    text("Start", width/2+300, height/2-110);

    //fill(#ec2d7a, graduDisappear);
    //textSize(200);
    //text("RED", width/2-220, height/2-250);
    //text("ENERGY", width/2+60, height/2-100);

    if (graduStatus == 1) {
      i++;
      if (i > 0) {
        graduDisappear = graduDisappear - j * j;
        i = 0;
        j++;
      }
      if (graduDisappear < 0) {
        userWindow = userWindow + 1;
        graduDisappear = 255;
        graduStatus = 0;
        i = 0;
        j = 1;
      }
    }
  }


  //Loading
  if (userWindow == 1) {

    rectMode(CORNER);
    noStroke();
    //if (a1 < 4 * width/6) {
    //  stroke(#ec2d7a);
    //}
    if (a1 >= 4 * width/6) {
      //stroke(255, graduDisappear);
      fill(255, graduDisappear);
      frame++;
      if (frame == 20) {
        graduStatus = 1;
      }
      if (graduStatus == 1) {
        i++;
        if (i > 2) {
          graduDisappear = graduDisappear - j * j;
          i = 0;
          j++;
        }
        if (graduDisappear < 0) {
          userWindow = userWindow + 1;
          graduDisappear = 0;
          clickChange = 1;
          //graduStatus = 0;
          i = 0;
          j = 1;
          frame = 0;
        }
      }
    }
    if (a1 < 4 * width/6) {
      fill(255);
      //stroke(#ec2d7a);
      a1 = a1+10;
    }
    rect(width/6, height/2, a1, 40, 15);
    noFill();
    stroke(#ee3f4d, graduDisappear);
    strokeWeight(5);
    rect(width/6, height/2, 4 * width/6, 40, 15);
  }


  //Battery & Display
  if (userWindow == 2) { 

    //divider
    if (graduStatus == 1) {
      i++;
      if (i > 2) {
        graduDisappear = graduDisappear + j * j;
        i = 0;
        j++;
      }
      if (graduDisappear > 255) {
        //userWindow = userWindow + 1;
        graduDisappear = 255;
        graduStatus = 0;
        i = 0;
        j = 1;
      }
    }
    fill(255, graduDisappear);
    noStroke();
    rectMode(CORNER);
    rect(2 * width/3, 0, 20, 2 * height);

    //Battery Interface
    stroke(255, graduDisappear);
    strokeWeight(15);
    noFill();
    rect(9 * width/12, height / 2 - 300, 2 * width/12, 600, 20);
    fill(255, graduDisappear);
    rect(10 * width/12 - width / 24, height / 2 -300, 2 * width/24, -40, 5);
    //Rate
    textFont(textFont1);
    textSize(120);
    fill(255);
    textAlign(RIGHT, CENTER);
    text(batteryNumber + " %", 10 * width/12 + width/11, height / 2 + 400);

    //Input 1

    //Input 2: Hammer with Arduino
    serialFrame++;
    if (serialFrame > 360 ) {
      serialEvent(myPort);
      serialFrame = 300;
    }

    if (serialStatus) {

      //keyCounter++;
      if (sensorReading != null) {
        if (int(float(sensorReading)) > serialInter) {
          keyCounter ++;
        }
        serialInter = int(float(sensorReading));
      }
    }


    //Input 3: Keyboard
    if (keyPressed) {
      keyCounter ++;
      println(keyCounter);
    }


    //Energy Generateing / Losing...
    frame++;
    if (keyCounter <= 0) {
      keyCounter = 0;
    }
    if (keyInter <= 0) {
      keyInter = 0;
    }
    if (keyCounter >= 11*t) {
      keyCounter = 11*t;
    }
    if (keyInter >= 11*t) {
      keyInter = 11*t;
    }
    if (frame > 60) {
      println("keyCounter is " + keyCounter);
      println("keyInter is " + keyInter);

      if (keyCounter > keyInter) {
        keyBoolean = 1;
      } else {
        keyBoolean = 0;
      }

      frame = 0;
      keyInter = keyCounter;
      if (autoDecrease) {
        keyCounter--;
      }
    }

    textFont(textFont1);
    if (keyBoolean == 1) {
      textSize(80);
      fill(#248067, graduDisappear);
      textAlign(LEFT, CENTER);
      text("ENERGY IS Generateing", width/12, height / 2 + 400);
      generatingCounter++;
      losingCounter = 0;
    } else if (keyBoolean == 0 && autoDecrease) {
      textSize(80);
      fill(#c21f30, graduDisappear);
      textAlign(LEFT, CENTER);
      text("ENERGY IS Losing", width/12, height / 2 + 400);
      losingCounter++;
      generatingCounter = 0;
    } else if (keyBoolean == 0 && !autoDecrease) {
      textSize(80);
      fill(255, graduDisappear);
      textAlign(LEFT, CENTER);
      text("ENERGY IS .............................", width/12, height / 2 + 400);
    }

    if (losingCounter <= 0) {
      losingCounter = 0;
    }
    if (losingCounter >= 1800) {
      losingCounter = 1800;
    }
    if (generatingCounter <= 0) {
      generatingCounter = 0;
    }
    if (generatingCounter >= 1800) {
      generatingCounter = 1800;
    }



    //Battery Display
    fill(255);
    noStroke();
    if (keyCounter < t) {
      batteryNumber = 0;
    }
    if (keyCounter > t) {
      fill(#c21f30);
      rect(9 * width/12+13, height / 2 + 300-50-7.5-8.75, 2 * width/12-26, 50, 5);
      batteryNumber = 10;
    }
    if (keyCounter > 2*t) {
      fill(#d11a2d);
      rect(9 * width/12+13, height / 2 + 300-50*2-7.5*2-8.75, 2 * width/12-26, 50, 5);
      batteryNumber = 20;
    }
    if (keyCounter > 3*t) {
      fill(#a4cab6);
      rect(9 * width/12+13, height / 2 + 300-50*3-7.5*3-8.75, 2 * width/12-26, 50, 5);
      batteryNumber = 30;
    }
    if (keyCounter > 4*t) {
      fill(#9abeaf);
      rect(9 * width/12+13, height / 2 + 300-50*4-7.5*4-8.75, 2 * width/12-26, 50, 5);
      batteryNumber = 40;
    }
    if (keyCounter > 5*t) {
      fill(#45b787);
      rect(9 * width/12+13, height / 2 + 300-50*5-7.5*5-8.75, 2 * width/12-26, 50, 5);
      batteryNumber = 50;
    }
    if (keyCounter > 6*t) {
      fill(#2bae85);
      rect(9 * width/12+13, height / 2 + 300-50*6-7.5*6-8.75, 2 * width/12-26, 50, 5);
      batteryNumber = 60;
    }
    if (keyCounter > 7*t) {
      fill(#2c9678);
      rect(9 * width/12+13, height / 2 + 300-50*7-7.5*7-8.75, 2 * width/12-26, 50, 5);
      batteryNumber = 70;
    }
    if (keyCounter > 8*t) {
      fill(#2c9678);
      rect(9 * width/12+13, height / 2 + 300-50*8-7.5*8-8.75, 2 * width/12-26, 50, 5);
      batteryNumber = 80;
    }
    if (keyCounter > 9*t) {
      fill(#248067);
      rect(9 * width/12+13, height / 2 + 300-50*9-7.5*9-8.75, 2 * width/12-26, 50, 5);
      batteryNumber = 90;
    }
    if (keyCounter > 10*t) {
      fill(#248067);
      rect(9 * width/12+13, height / 2 + 300-50*10-7.5*10-8.75, 2 * width/12-26, 50, 5);
      batteryNumber = 100;
    }


    //Text Feedbacks
    textFont(textFont2);
    textSize(40);
    fill(255, graduDisappear);
    textAlign(LEFT, CENTER);

    text("Hi, I'm your smart AI helper!", width/12, 2*height / 25);
    //text("Here I will give YOU some encouragements", width/12, 2*height / 25);
    //text("And remind the HOST to continue this game.", width/12, 3*height / 25);

    text(textDisplay[0], width/12, 3*height / 18);
    text(textDisplay[1], width/12, 4*height / 18);
    text(textDisplay[2], width/12, 5*height / 18);
    text(textDisplay[3], width/12, 6*height / 18);
    text(textDisplay[4], width/12, 7*height / 18);
    text(textDisplay[5], width/12, 8*height / 18);
    text(textDisplay[6], width/12, 9*height / 18);
    text(textDisplay[7], width/12, 10*height / 18);
    text(textDisplay[8], width/12, 11*height / 18);
    text(textDisplay[9], width/12, 12*height / 18);
    text(textDisplay[10], width/12, 13*height / 18);


    textFrame++;


    if (textFrame > 60) {
      if (textpointer == 11) {
        textpointer = 0;
        textDisplay[textpointer] = textDisplay[10];
        for (int x = 1; x < textNum; x++) {
          textDisplay[x] = " ";
        }
      }


      if (generatingCounter == 0) {
        textDisplay[textpointer] = textString[0];
        //textpointer++;
      } 
      if (losingCounter > 300 && losingCounter < 1200 ) {
        randomeNum = int(random(6, 9));
        textDisplay[textpointer] = textString[randomeNum];
        //textpointer++;
      } 
      if (generatingCounter != 0) {
        randomeNum = int(random(2, 5));
        textDisplay[textpointer] = textString[randomeNum];
        //textpointer++;
      }
      if (batteryNumber == 80 || batteryNumber == 90) {
        textDisplay[textpointer] = textString[5];
        //textpointer++;
      }

      if (losingCounter >= 1500 && generatingCounter == 0) {
        textDisplay[textpointer] = textString[9];
      } 
      if (batteryNumber == 100) {
        textDisplay[textpointer] = textString[10];
      } 

      textpointer++;
      textFrame = 0;
    }


    //Reset
    textFont(textFont1);
    if (clickChange == 1) {
      fill(0, graduDisappear);
    } else {
      fill(255, graduDisappear);
    }
    if (clickChange == 1) {
      stroke(255);
    } else {
      stroke(#ee3f4d, graduDisappear);
    }
    strokeWeight(10);
    rectMode(CENTER);
    rect(2*width/3+280, height/3-270, 250, 80);

    if (clickChange == 1) {
      fill(255, graduDisappear);
    } else {
      fill(#ee3f4d, graduDisappear);
    }
    textSize(70);
    textAlign(CENTER, CENTER);
    text("Reset", 2*width/3+280, height/3-276);

    if (graduStatus == 2) {
      i++;
      if (i > 0) {
        graduDisappear = graduDisappear - j * j;
        i = 0;
        j++;
      }
      if (graduDisappear < 0) {
        userWindow = 0;
        graduDisappear = 255;
        graduStatus = 0;
        i = 0;
        j = 1;

        userWindow = 0;
        frame = 0; //For circulation

        graduStatus = 0;
        graduDisappear = 255; //Controlling the transparency, make trasition animation  


        clickChange = 1; //Used in userWindow 0 to change color of text and rect by moving mouse over them
        a1 = 0; //Used in userWindow 1 to control the length of loading bar

        batteryNumber = 0;
        losingCounter = 0;
        generatingCounter = 0;

        textNum = 11;
        textpointer = 0;
        randomeNum = 0;
        textFrame = 0;

        keyBoolean = 0;
        keyCounter = 0;
        keyInter = 0;
        autoDecrease = false;

        for (int x = 0; x < textNum; x++) {
          textDisplay[x] = " ";
        }
      }
    }
    
    println(generatingCounter + " " + losingCounter);
  }
}
