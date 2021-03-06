//define a particle
float x, y;
float speedX = 5.23, speedY = 2.56;
float radius = 30;

//initialize with starting position
void setup(){
  size(800, 700);
  x = width / 2;
  y = height / 2;
}

//animate particle
void draw(){
  background(255);
  polygon();
  //speedY = speedY + 1;
  x = x + speedX; //can make curved by incrementing speedX
  y = y + speedY;
  checkCol();
}

void checkCol(){
  //subtracting 2*radius brings collision point out the length of the square
  if (x > width -  2 * radius){
    speedX = -1 * speedX;
  }
  if (x < 0){
    speedX = -1 * speedX;
  }
  if (y > height - 2 * radius){
    speedY = -1 * speedY;
  }
  if (y < 0){
    speedY = -1 * speedY;
  }
}