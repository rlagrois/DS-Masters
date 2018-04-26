PImage US;
PFont keys;
float totalW, totalCent, totalE;
float westT, westCl, westCr, westR, westS;
float centT, centCl, centCr, centR, centS;
float eastT, eastCl, eastCr, eastR, eastS;
float west, cent, east;
int update = 0;

void setup(){
 size(1366, 900);
 US = loadImage("USblank.png");
 keys = createFont("Arial", 40, true);
 textFont(keys);
 strokeWeight(7);
 
west = width / 6;
cent = width / 2;
east = width * .8333;
 
 westT = 70;
 westCl = 60;
 westCr = 20;
 westR = 10;
 westS = 100;
 totalW = westT + westCl + westCr + westR + westS;
 
 centT = 85;
 centCl = 45;
 centCr = 65; 
 centR = 70;
 centS = 10;
 totalCent = centT + centCl + centCr + centR + centS;
 
 eastT = 60;
 eastCl = 95;
 eastCr = 45;
 eastR = 25;
 eastS = 85;
 totalE = eastT + eastCl + eastCr + eastR + eastS;
 
}


void draw(){
background(255, 246, 201);
image(US, 100, 50);
trump();
cruz();
rubio();
sanders();
clinton();
rerollW();
rerollC();
rerollE();
update += 1;
}

void trump(){
 stroke(255, 0, 0);
 fill(255, 0, 0);
 text("Trump", width * .05, height * .08);
 noFill();
 beginShape();
 curveVertex(0, height);
 curveVertex(0, height);
 curveVertex(west, (1 - (westT / totalW)) * height);
 curveVertex(width / 3, height * .9);
 curveVertex(cent, (1-(centT / totalCent)) * height);
 curveVertex(width * 0.666, height * .9);
 curveVertex(east, (1-(eastT / totalE)) * height);
 curveVertex(width, height);
 curveVertex(width, height);
 endShape();
}

void cruz(){
 stroke(255, 88, 88);
 fill(255, 88, 88);
 text("Cruz", width * .19, height * .08);
 noFill();
 beginShape();
 curveVertex(0, height);
 curveVertex(0, height);
 curveVertex(west, (1-(westCr / totalW)) * height);
 curveVertex(width / 3, height * .9);
 curveVertex(cent, (1-(centCr / totalCent)) * height);
 curveVertex(width * 0.666, height * .9);
 curveVertex(east, (1-(eastCr / totalE)) * height);
 curveVertex(width, height);
 curveVertex(width, height);
 endShape();
}


void rubio(){
 stroke(229, 65, 0);
 fill(229, 65, 0);
 text("Rubio", width * .3, height * .08);
 noFill();
 beginShape();
 curveVertex(0, height);
 curveVertex(0, height);
 curveVertex(west, (1 - (westR / totalW)) * height);
 curveVertex(width / 3, height * .9);
 curveVertex(cent, (1-(centR / totalCent)) * height);
 curveVertex(width * 0.666, height * .9);
 curveVertex(east, (1-(eastR / totalE)) * height);
 curveVertex(width, height);
 curveVertex(width, height);
 endShape();
}

void sanders(){
 stroke(10, 104, 250);
 fill(10, 104, 250);
 text("Sanders", width * .19, height * .15);
 noFill();
 beginShape();
 curveVertex(0, height);
 curveVertex(0, height);
 curveVertex(west, (1 - (westS / totalW)) * height);
 curveVertex(width / 3, height * .9);
 curveVertex(cent, (1-(centS / totalCent)) * height);
 curveVertex(width * 0.666, height * .9);
 curveVertex(east, (1-(eastS / totalE)) * height);
 curveVertex(width, height);
 curveVertex(width, height);
 endShape();
}


void clinton(){
 stroke(0, 0, 250);
 fill(0, 0, 255);
 text("Clinton", width * .05, height * .15);
 noFill();
 beginShape();
 curveVertex(0, height);
 curveVertex(0, height);
 curveVertex(west, (1 - (westCl / totalW)) * height);
 curveVertex(width / 3, height * .9);
 curveVertex(cent, (1-(centCl / totalCent)) * height);
 curveVertex(width * 0.666, height * .9);
 curveVertex(east, (1-(eastCl / totalE)) * height);
 curveVertex(width, height);
 curveVertex(width, height);
 endShape();
}

void rerollW(){
  if(update % 60 == 0){
  float p1 = random(0, 2);
  float p2 = random(0, 2);
  float p3 = random(0, 2);
  float p4 = random(0, 2);
  float m1 = random(0, 2);
  float m2 = random(0, 2);
  float m3 = random(0, 2);
  float m4 = random(0, 2);
 westT += p1;
 westCl += p4;
 westCr += p3;
 westR += p4;
 westS += p2;
 westT -= m2;
 westCl -= m4;
 westCr -= m1;
 westR -= m3;
 westS -= m1;
  }
}
 
 
void rerollC(){
  if(update % 60 == 0){
  float p1 = random(0, 1.25);
  float p2 = random(0, 1.25);
  float p3 = random(0, 1.25);
  float p4 = random(0, 1.25);
  float m1 = random(0, 1.25);
  float m2 = random(0, 1.25);
  float m3 = random(0, 1.25);
  float m4 = random(0, 1.25);
 centT += p1;
 centCl += p4;
 centCr += p3;
 centR += p4;
 centS += p2;
 centT -= m2;
 centCl -= m4;
 centCr -= m1;
 centR -= m3;
 centS -= m1;
  }
}
 
 
void rerollE(){
  if(update % 60 == 0){
  float p1 = random(0, 2.25);
  float p2 = random(0, 2.25);
  float p3 = random(0, 2.25);
  float p4 = random(0, 2.25);
  float m1 = random(0, 2.25);
  float m2 = random(0, 2.25);
  float m3 = random(0, 2.25);
  float m4 = random(0, 2.25);
 eastT += p1;
 eastCl += p4;
 eastCr += p3;
 eastR += p4;
 eastS += p2;
 eastT -= m2;
 eastCl -= m4;
 eastCr -= m1;
 eastR -= m3;
 eastS -= m1;
  }
}