public class SecondApplet extends PApplet {

  public void settings() {
    size(1000, 900);
  }
  
  public void draw() {
    waste(6);
    positives(2000);
    lines();
    fill(0);
    rect(width * .666, 0, width * .444, height);
    sortCount();
  }
  
  
  void waste(int pRate){
    fill(255, 255, 255, 90);
    noStroke();
    float negX = width * 0.666;
    float negY = height * 0.55;
    float negPosX, negPosY;
    //adds negatives to inner box at faster rate and outer at slower 
    //using box var
    for(i = 0; i < pRate + 1; i++){
      if(box % 10 == 0){
        negPosX = random(negX * .15, negX * .85);
        negPosY = random(negY * 1.01, negY * 1.8);
        ellipse(negPosX, negPosY, 2, 2);
      }
      if(box % 5 == 0){
        negPosX = random(negX * .25, negX * .75);
        negPosY = random(negY * 1.05, negY * 1.6);
        ellipse(negPosX, negPosY, 2, 2);
    }
      else{
        negPosX = random(negX * .4, negX * .6);
        negPosY = random(negY * 1.08, negY * 1.4);
        ellipse(negPosX, negPosY, 2, 2); 
      }
      events++;
    }
    box++; 
  }

  //creates positive events
  //higher sortProb reduces chances of positives
  void positives(int sortProb){
    checkPos = random(sortProb);
    float negX = width * 0.666;
    float negY = height * 0.55;
    float posiX = random(negX * .4, negX * .6);
    noStroke();
    //sets positive population based on slider
    if(slidePOS >= 800 && slidePOS < 908){
      placePos(negY / 11, negY / 6, negY / 3.25, negY / 2.1, negY / 1.8, negY / 1.1, posiX);
    }
    if(slidePOS >= 908){
      placePos(negY / 11, negY / 6, negY / 10.75, negY / 5.5, negY / 10.7, negY / 5, posiX);
    }
    if(slidePOS >= 600 && slidePOS < 800){
      placePos(negY / 1.55, negY / 1.2, negY / 1.5, negY / 1.1, negY / 1.3, negY / 1.1, posiX);
    }
    if(slidePOS == 600){
      reset();
    }

  }

//creates gate, restarts count when gate is changed
//lines and sort count called to stay visible
  void mouseDragged(){
    sortLim = mouseY;
    reset();
    green = 0;
    yellow = 0;
    red = 0;
    events = 0;
    sortCount();
  }

//creates dividing lines
  void lines(){
    float negX = width * 0.666;
    float negY = height * 0.55;
    stroke(234, 132, 28);
    line(0,  negY, negX, negY);
    stroke(255);
    line(negX, 0, negX, height);
  }


  //checks if event is inside sort gate
  //increments each count
  void sortCheck(float check){
    if(checkPos >= 0 && checkPos < 10 && check < sortLim){
      green++;
      events++;
    }
    if(checkPos >= 10 && checkPos < 100 && check < sortLim){
      yellow++;
      events++;
    }
    if(checkPos >= 100 && checkPos < 500 && check < sortLim){
      red++;
      events++;
    } 
  }


  //displays the # and % of each sorted event
  //nf converts to string and limits significant digits
  void sortCount(){
    f = createFont("Arial", 30, true);
    textFont(f);
    String greenFrac = nf(100*(green/events), 1, 3);
    String yellowFrac = nf(100*(yellow/events), 1, 3);
    String redFrac = nf(100*(red/events), 1, 3);
    fill(0, 255, 0);
    text("High:   " + green + " (" + greenFrac + ")%", width * .666, height / 11);
    fill(255, 230, 3);
    text("Medium:   " + yellow + " (" + yellowFrac + ")%", width * .666, height / 5);
    fill(255, 0, 0);
    text("Low:   " + red + " (" + redFrac + ")%", width * .666, height / 3.3);
    fill(255, 255, 255, 90);
    text("Total events:   " + events, width * .666, height / 2);
  }
  
  void reset(){
    float negX = width * 0.666;
    float negY = height * 0.55;
    pushStyle();
    background(0);
    fill(0);
    stroke(0, 0, 255);
    rect(negX * 0.35, negY / 12, negX * 0.30, (sortLim - negY / 12));
    popStyle();
    lines();
  }
  
  void placePos(float greenHi, float greenLo, float yellHi, float yellLo, float redHi, float redLo, float xPos){
    if(checkPos >= 0 && checkPos < 10){
         fill(0, 255, 0);
         posiY = random(greenHi, greenLo);
         ellipse(xPos, posiY, 2, 2);
         sortCheck(posiY);
        }
    if(checkPos >= 10 && checkPos < 100){
         fill(255, 230, 3);
         posiY = random(yellHi,  yellLo);
         ellipse(xPos, posiY, 2, 2);
         sortCheck(posiY);
        }
    if(checkPos >= 100 && checkPos < 275){
         fill(255, 0, 0);
         posiY = random(redHi,  redLo);
         ellipse(xPos, posiY, 2, 2);
         sortCheck(posiY);
        }
  }
  
}