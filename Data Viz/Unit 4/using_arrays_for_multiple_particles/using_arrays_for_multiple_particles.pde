int particleCnt = 10;
float[] x = new float[particleCnt];
float[] y = new float[particleCnt];
float[] radius = new float[particleCnt];
float[] speedX = new float[particleCnt];
float[] speedY = new float[particleCnt];
float[] gravity = new float[particleCnt];
//causes speed to drop after hitting wall
float[] damping = new float[particleCnt];
float[] friction = new float[particleCnt];

void setup(){
  size(1000, 800);
  for(int i = 0; i< particleCnt; i += 1){
  x[i] = random(100, width-100);
  y[i] = random(10, 30);
  speedX[i] = random(0.1, 2.5);
  speedY[i] = random(0.1, 2.5);
  radius[i] = random(1, 50);
  gravity[i] = .03;
  damping[i] = .77;
  friction[i] = .77;
  }
}

void draw(){
  background(0);
  for(int i = 0; i< particleCnt; i += 1){
  polygon(x[i], y[i], radius[i], 8, 2, color(255,0,0));
  x[i] += speedX[i];
  y[i] += speedY[i];
  speedY[i] += gravity[i];
  checkCol(i);
  }
}
  
void checkCol(int i){
  //subtracting radius brings collision point out the length of the square
  //setting x and y in if prevents shape from going past screen
  if (x[i] > width - radius[i]){
    x[i] = width - radius[i];
    speedX[i] = -1 * speedX[i];
  }
  if (x[i] < radius[i]){
    x[i] = radius[i];
    speedX[i] = -1 * speedX[i];
  }
  if (y[i] >= height - radius[i]){
    y[i] = height - radius[i];
    speedY[i] = -1 * speedY[i];
    speedY[i] *= damping[i];
    speedX[i] *= friction[i];
  }
  if (y[i] < radius[i]){
    y[i] = radius[i];
    speedY[i] = -1 * speedY[i];
  }
}