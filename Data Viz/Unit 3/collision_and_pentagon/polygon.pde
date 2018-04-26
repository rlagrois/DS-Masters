void polygon() {
  //adding '- radius' makes x and y reach collision targets (x - radius, y - radius)
  //before the shape itself is there
  //if that is done then replace '0' with radius and remove '* 2' (doesn't work for all shapes)
  rect(x, y, radius * 2, radius * 2);
}

void polygon2() {
  //float x = width / 2;
  //float y = width / 2;
  //set angle of rotation (rad)
  float theta = 0;
  //locally delcared radius overides global for this function
  float radius = 23;
  int sides = 5;
  
  strokeWeight(3);
  beginShape();
  //having 'x/y +' accounts for inital point in the center
  float x2 = x + cos(theta) * radius;
  float y2 = y + sin(theta) * radius;
  vertex(x2, y2);
  //'TWO_PI / 5' moves the point one fifth around the unit cycle
  //multiplying that moves it an additional fifth
  x2 = x + cos(theta + (TWO_PI/5)) * radius;
  y2 = y + sin(theta + (TWO_PI/5)) * radius;
  vertex(x2, y2);
  x2 = x + cos(theta + (TWO_PI/5)*2) * radius;
  y2 = y + sin(theta + (TWO_PI/5)*2) * radius;
  vertex(x2, y2);
  x2 = x + cos(theta + (TWO_PI/5)*3) * radius;
  y2 = y + sin(theta + (TWO_PI/5)*3) * radius;
  vertex(x2, y2);
  x2 = x + cos(theta + (TWO_PI/5)*4) * radius;
  y2 = y + sin(theta + (TWO_PI/5)*4) * radius;
  vertex(x2, y2);
  endShape(CLOSE);
}