PImage curve;
PImage abs;
float adj;

class FL1 {
  
  FL1(){
  
  }
  
  //chart for Fmax curve
  void FLcurve(){
    curve = loadImage("FLcurve2.png");
    image(curve, width * .1, height * .1);
  }
  
  //chart for displayed intensity
  void FLabs(){
    abs = loadImage("FLabs2.png");
    image(abs, width * .60, height * .09);
  
  }
  
  void blueL(float blueX){
    blueX = slidePOS / 2;
    stroke(0, 0, 255);
    line(blueX, 114, blueX, 399); 
  }
  
  void greenL(float greenX){
    adj = slidePOS - 437;
    greenX = 815 + adj / 2;
    if(slidePOS > 911){
      greenX = 860.4 + adj / 2.5;
    }
    if(greenX > 1085){
      greenX = 1085;
    }
    stroke(0, 255, 0);
    line(greenX, 194, greenX, 306);
  }
  
  void redL(float redX){
    adj = slidePOS - 437;
    redX = 815 + adj / 2.5;
    if(slidePOS > 911){
      redX = 725.2 + adj / 1.7;
    }
    if(redX > 1075){
      redX = 1075;
    }
    stroke(255, 0, 0);
    line(redX, 194, redX, 306);
  }
  
    void yellowL(float yellowX){
    adj = slidePOS - 437;
    yellowX = 815 + adj / 2.25;
    if(slidePOS > 908){
      yellowX = 755.9 + adj / 1.75;
    }
    if(yellowX > 1080){
      yellowX = 1080;
    }
    stroke(255, 127, 39);
    line(yellowX, 194, yellowX, 306);
  }
  
}