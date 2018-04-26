void polygon() {
  //adding '- radius' makes x and y reach collision targets (x - radius, y - radius)
  //before the shape itself is there
  //if that is done then replace '0' with radius and remove '* 2' (doesn't work for all shapes)
  rect(x, y, radius * 2, radius * 2);
}

void polygon2() {
  //float x = width / 2; (commented out so draw x/y not overridden)
  //float y = width / 2;
  //set angle of rotation (rad)
  float theta = 0;
  //locally delcared radius overides global for this function
  float radius = 23;
  int sides = 5;
  strokeWeight(3);
  beginShape();
  //for loop replaces repreated lines of code
  //plot vertex -> incrememnt theta, repeat until 5 sides are made
  for(int i = 0; i < sides; i += 1){
  float x2 = x + cos(theta) * radius;
  float y2 = y + sin(theta) * radius;
  vertex(x2, y2);
  theta += TWO_PI/sides;
  }
  endShape(CLOSE);
}