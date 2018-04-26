float x, y, radius;
float speedX, speedY;
float gravity = 0.5;
//causes speed to drop after hitting wall
float damping = .97;
float friction= .5;

void setup(){
  size(1000, 800);
  x = width/2;
  y = height/2;
  speedX = 1.2;
  speedY = 2.1;
  radius = 50;
}

void draw(){
  background(0);
  polygon(x, y, radius, 8, 2, color(255,0,0));
  x += speedX;
  y += speedY;
  speedY += gravity;
  checkCol();
}
  
void checkCol(){
  //subtracting radius brings collision point out the length of the square
  //setting x and y in if prevents shape from going past screen
  if (x > width - radius){
    x = width - radius;
    speedX = -1 * speedX;
  }
  if (x < radius){
    x = radius;
    speedX = -1 * speedX;
  }
  if (y >= height - radius){
    y = height - radius;
    speedY = -1 * speedY;
    speedY *= damping;
    speedX *= friction;
  }
  if (y < radius){
    y = radius;
    speedY = -1 * speedY;
  }
}