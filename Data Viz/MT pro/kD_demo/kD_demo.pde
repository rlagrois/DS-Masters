float slidePOS;
PFont f;
int i;
int box = 0;
float red, green, yellow, events = 0;
float sortLim;
float posiY;
float checkPos;
float redX;
float yellowX;
float greenX;
float blueX;

FL1 fl;
interact inter;


void setup(){
  slidePOS = 600;
  blueX = width * .289;
  
  fl = new FL1();
  inter = new interact();
  
  String[] args = {"sort"};
  SecondApplet sa = new SecondApplet();
  PApplet.runSketch(args, sa);
  
  
}

//using settings for the sort window causes this one to be default size
//define size here instead of setup
void settings(){
  size(1300, 900);
}

void draw(){
  background(0);
  fl.FLcurve();
  fl.FLabs();
  fl.blueL(blueX);
  fl.greenL(greenX);
  fl.redL(redX);
  fl.yellowL(yellowX);
  inter.bar();
  inter.slider();
  inter.expl();
  
  
  fill(0, 255, 0);
  textFont(f);
  //text(mouseX + ", " +mouseY, height /2, width/2);
  
}

//sets slider Y position
//limits slider to the bar
void mouseDragged(){
  slidePOS = mouseX;
  if(mouseX > width * .855){
    slidePOS = width * .855;
  }
  if(mouseX < width * .336){
    slidePOS = width * .336;
  }
}