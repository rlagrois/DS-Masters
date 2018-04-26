void setup() {
  size(800, 800);
  background(255);
  float qtrWid = width / 4;
  float hlfWid = width / 2;
  float qtrHght = height / 4;
  float hlfHght = height / 2;
  
  //bg
  noStroke();
  fill(0, 252, 27);
  triangle(0, 0, 0, height, width, 0);
  fill(0, 216, 222);
  triangle(width, height, 0, height, width, 0);
  

  //hair bottom
  noStroke();
  fill(118, 89, 8);
  rect(qtrWid, hlfHght, hlfWid, qtrHght, 10, 10, 50, 50);

  //head
  float hdWid = width / 2;
  float hdHght = height * 0.66;
  strokeWeight(1);
  stroke(0);
  fill(234, 171, 102);
  ellipse(width/2, height/2, hdWid, hdHght);
 
  
  //eyes
  strokeWeight(1);
  stroke(0);
  fill(255);
  ellipse(width * 0.625, height * 0.375, qtrWid / 3.25, qtrWid / 5);
  ellipse(width * 0.375, height * 0.375, qtrWid / 3.25, qtrWid / 5);
  fill(57, 29, 1);
  strokeWeight(3);
  ellipse(width * 0.625, height * 0.375, qtrWid / 5, qtrWid / 5);
  ellipse(width * 0.375, height * 0.375, qtrWid / 5, qtrWid / 5);
  fill(0);
  ellipse(width * 0.625, height * 0.375, qtrWid / 12, qtrWid / 12);
  ellipse(width * 0.375, height * 0.375, qtrWid / 12, qtrWid / 12);
  
   //hair top
  noStroke();
  fill(118, 89, 8);
  beginShape();
    curveVertex(qtrWid/2, qtrHght * 3);
    curveVertex(qtrWid * 0.9, hlfHght);
    curveVertex(qtrWid * 1.30, qtrHght * 0.9);
    curveVertex(hlfWid, qtrHght * 0.6);
    curveVertex(qtrWid * 2.80, qtrHght * 0.9);
    curveVertex(qtrWid * 3.1, hlfHght);
    curveVertex(hlfWid, qtrHght * .8);
    curveVertex(qtrWid * 3.5, qtrHght * 3);
  endShape(CLOSE);

  //nose
  stroke(0);
  strokeWeight(7);
  noFill();
  beginShape();
    curveVertex(width * 0.625, height * 0.05);
    curveVertex(hlfWid, qtrHght * 1.5);
    curveVertex(qtrWid * 1.75, hlfHght);
    curveVertex(hlfWid, hlfHght * 1.1);
    curveVertex(hlfWid * 1.25, qtrHght * 1.5);
  endShape();

  //mouth
  stroke(201, 24, 36);
  strokeWeight(7);
  fill(0);
  beginShape();
    curveVertex(qtrWid, qtrHght * 3.5);
    curveVertex(qtrWid * 1.5, hlfHght * 1.40);
    curveVertex(hlfWid, hlfHght * 1.2);
    curveVertex(qtrWid * 2.5, hlfHght * 1.40);
    curveVertex(qtrWid * 3, qtrHght *3.5);
  endShape(CLOSE);


  //horizontal grid lines
  stroke(0);
  strokeWeight(1);
  //line(0, height/2, width, height/2);
  //line(0, height*0.75, width, height*0.75);
  //line(0, height*0.25, width, height*0.25);
  //vertical gridlines
  //line(width/2, 0, width/2, height);
  //line(width*0.75, 0, width*0.75, height);
  //line(width*0.25, 0, width*0.25, height);
}