void setup(){
  noStroke();
  size(1200, 800);
  int border = 300;
    for(int i=0; i < 200; i++){
      fill(random(255), random(255), random(255));
      rect(random(border, width - border), random(border, height - border), 50, 50);
    }
    
  loadPixels();
  pixels[0] = color(200, 100, 50);
  updatePixels();
  
}