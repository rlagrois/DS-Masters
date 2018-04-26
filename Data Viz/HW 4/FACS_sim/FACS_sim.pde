//global variables
PFont f;
int i;
int box = 0;
float red, green, yellow, events = 0;
float sortLim;
float posiY;
float checkPos;
float greenFrac, yellowFrac, redFrac;

//setup and dividing lines
void setup(){
  size(1000, 900);
  background(0);
  f = createFont("Arial", 30, true);
}

//run the sim
void draw(){
  waste(6);
  positives(2000);
  lines();
  fill(0);
  rect(width * .666, 0, width * .444, height);
  sortCount();
  
}

//generate negative particles
void waste(int pRate){
  fill(255, 255, 255, 90);
  noStroke();
  float negX = width * 0.666;
  float negY = height * 0.55;
  float negPosX, negPosY;
  //adds negatives to inner box at faster rate and outer at slower using box var
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
void positives(int sortProb){
 checkPos = random(sortProb);
 float negX = width * 0.666;
 float negY = height * 0.55;
 float posiX = random(negX * .4, negX * .6);
 noStroke();
 //checks random number to assign event, adds to counter
 if(checkPos >= 0 && checkPos < 10){
  fill(0, 255, 0);
  posiY = random(negY / 11, negY / 6);
  ellipse(posiX, posiY, 2, 2);
  sortCheck(posiY);
 }
 if(checkPos >= 10 && checkPos < 100){
  fill(255, 230, 3);
  posiY = random(negY / 3.25,  negY / 2.1);
  ellipse(posiX, posiY, 2, 2);
  sortCheck(posiY);
 }
  if(checkPos >= 100 && checkPos < 275){
  fill(255, 0, 0);
  posiY = random(negY / 1.8,  negY / 1.1);
  ellipse(posiX, posiY, 2, 2);
  sortCheck(posiY);
 }
}

//creates gate, restarts when gate is changed 
void mouseDragged(){
  float negX = width * 0.666;
  float negY = height * 0.55;
  sortLim = mouseY - 50;
  pushStyle();
  background(0);
  fill(0);
  stroke(0, 0, 255);
  rect(negX * 0.35, negY / 12, negX * 0.30, sortLim);
  popStyle();
  lines();
  green = 0;
  yellow = 0;
  red = 0;
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