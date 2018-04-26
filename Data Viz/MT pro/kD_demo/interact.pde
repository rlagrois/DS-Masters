PImage exp;

class interact {
 
  interact(){
  }
  
  //bar for slider
  void bar(){
    stroke(255);
    strokeWeight(4);
    line(437, height * .97, 650, height * .97);
    stroke(255, 0, 0);
    line(650, height * .97, 800, height * .97);
    line(908, height * .97, 1111, height * .97);
    stroke(0, 255, 0);
    line(800, height * .97, 908, height * .97);
  }
  
  //actual slider
  void slider(){
    noStroke();
    fill(255, 0, 0);
    ellipse(slidePOS, height * .97, 20, 20);
  }
  
  void expl(){
    exp = loadImage("exp.png");
    image(exp, width * .12, height * .63);
  }
  
}