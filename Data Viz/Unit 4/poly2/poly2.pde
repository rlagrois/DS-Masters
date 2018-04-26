float x, y;
float speedX, speedY;
float gravity = 0.03;

void setup(){
  size(1000, 800);
  x = width/2;
  y = height/2;
  speedX = 1.2;
  speedY = 2.1;
}

void draw(){
  background(0);
  polygon(x, y, 5, 8, 2, color(255,0,0));
  x += speedX;
  y += speedY;
  speedY += gravity;
}
  