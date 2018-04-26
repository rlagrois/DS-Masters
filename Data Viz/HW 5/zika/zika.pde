PImage WM;
PFont yF;
PFont info;
int slide = 0;
int disYear = 1947;
float upX = width * .62;
float upY = height * .09;
int i;
int slow = 0;
String s1Text = "Zika is first discovered in equatorial Africa but remains quiet and obscure for nearly 70 years";
String s2Text = "Zika spreads to French Polynesia, infecting an estimated 30,000 people.";
String s2Text2 = "There is a noted rise in neurological syndroms.";
String s3Text = "A disease begins to appear in the north east of Brazil during spring.";
String s3Text2 = "It is soon discovered to be Zika and is believed to have entered the country during the 2014 World Cup";
String s4Text = "In November the Brazilian government declares a state of emergency as Zika explodes through the country";
String s4Text2 = "There is also a sharp increase in the number of babies born with microcephaly, thought to be linked with Zika";




//sets BG, loads images and fonts
void setup(){
  size(1024, 768);
  WM = loadImage("pacWM.png");
  yF = createFont("Arial", 32, true);
  info = createFont("Arial", 20, true);
}

void draw(){
 background(190, 232, 229);
 image(WM, 0, 0);
 yearBox(disYear);
 present();
 textFont(info);
 text(mouseX + ", " +mouseY, height /2, width/2);
 slow += 1;
}

//detects click to change slide
void mouseClicked(){
  if(mouseX > ((width * .49) + (width * .09)) && mouseX < (width *.62) && mouseY > 0 && mouseY < (height*.09)){
    slide += 1;
  } 
}


//the slides
void slide1() {
  noFill();
  float elX = width * .11;
  float elY = height * .52;
      fill(255, 0, 0);
      ellipse(elX + 60, elY + 25, 4, 4);
      ellipse(elX + 23, elY + 40, 4, 4);
      ellipse(elX + 4, elY + 15, 4, 4);
      ellipse(elX + 35, elY + 5, 4, 4);
      ellipse(elX + 48, elY + 30, 4, 4);
}

void slide2(){
 fill(255, 0, 0);
 ellipse(width * .7, height * .65, 50, 50);
}

void slide3(){
  fill(255, 0, 0);
  ellipse(929, 457, 4, 4);
  ellipse(946, 463, 4, 4);
  ellipse(911, 461, 4, 4);
  ellipse(941, 492, 4, 4);
}

void slide4(){
  fill(255, 0, 0);
  for(i = 0; i < 3; i++){
    float xPos1 = random(914, 949);
    float yPos1 = random(458, 483);
    ellipse(xPos1, yPos1, 4, 4);
    float xPos2 = random(949,983);
    float yPos2 = random(466, 515);
    ellipse(xPos2, yPos2, 4, 4);
  }
}

//creates box and year at top of map
//also creates control arrows
void yearBox(int year){
  float triTop = (width * .49) + (width * .09);
  fill(0);
  rect(width * 0.49, 0, width * .09, height * .09);
  textFont(yF);
  fill(255);
  text(year, width * .5, height *.06);
  fill(255, 0, 0);
  triangle(width * .49, 0, width * .49, height * .09, width *.45, height * .045);
  fill(0, 255, 0);
  triangle(triTop, 0, triTop, height * .09, width * .62, height * .045);
}

void present(){
  textFont(info);
  if(slide == 0){
    slide1();
    fill(0);
    text(s1Text,  width * .11, height * .15); 
  }
  if(slide == 1){
    disYear = 2014;
    slide2();
    fill(0);
    text(s2Text, width * .11, height * .15);
    text(s2Text2, width * .11, height * .175);
  }
  if(slide == 2){
    disYear = 2015;
    slide3();
    fill(0);
    text(s3Text, width * .11, height * .15);
    text(s3Text2, width * .11, height * .175); 
  }
  if(slide == 3){
    slide4();
    text(s4Text, width * .11, height * .15);
    text(s4Text2, width * .11, height * .175); 
}
}