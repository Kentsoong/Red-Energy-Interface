
void serialEvent  (Serial myPort) {

  sensorReading = myPort.readStringUntil('\n');

  if (sensorInter == sensorReading) {
    serialStatus = false;
  } else {
    serialStatus = true;
  }
  sensorInter = sensorReading;

  print(sensorReading);
  //println("     " + myPort.readStringUntil('\n'));
}



void mouseMoved() {

  if (userWindow == 0) {
    if (mouseX < width/2+475+10 && mouseX > width/2+125-10 && mouseY < height/2-40+10 && mouseY > height/2-160-10) {
      clickChange = 0;
    } else {
      clickChange = 1;
    }
  }

  if (userWindow == 2) {
    if (mouseX < 2*width/3+405+6 && mouseX > 2*width/3+155-6 && mouseY < height/3-230+6 && mouseY > height/3-310-6) {
      clickChange = 0;
    } else {
      clickChange = 1;
    }
  }
}



void mousePressed() {

  if (userWindow == 0) {
    if (mouseX < width/2+475+10 && mouseX > width/2+125-10 && mouseY < height/2-40+10 && mouseY > height/2-160-10) {
      graduStatus = 1;
    } else {
      graduStatus = 0;
    }
  }

  if (userWindow == 2) {
    if (mouseX < 2*width/3+405+6 && mouseX > 2*width/3+155-6 && mouseY < height/3-230+6 && mouseY > height/3-310-6) {
      graduStatus = 2;
    } else {
      graduStatus = 0;
    }
  }
}



void keyPressed() {

  if (userWindow == 2) {
    switch(key) {
    case 'o': 
      autoDecrease = true;
      break;
    case 'f': 
      autoDecrease = false;
      int losingCounter = 0;
      int generatingCounter = 0;
      break;
    }
  }
}
