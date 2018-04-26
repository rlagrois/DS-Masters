PFont boba;
PImage empire;

class wallpaper {
  
  wallpaper(){
    background(255);
  }
  
  void wall(String title, float xP, float yP, color tColor){
     boba = createFont("star", 100, true);
     empire = loadImage("empire.jpg");
     image(empire, -60, -45);
     filter(INVERT);
     textFont(boba);
     fill(tColor);
     text(title, xP, yP);
  }
  
}