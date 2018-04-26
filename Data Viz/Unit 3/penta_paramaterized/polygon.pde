void polygon() {
  //adding '- radius' makes x and y reach collision targets (x - radius, y - radius)
  //before the shape itself is there
  //if that is done then replace '0' with radius and remove '* 2' (doesn't work for all shapes)
  rect(x, y, radius * 2, radius * 2);
}

void polygon2(float radius, int sides, float strkWt, color fillCol) {
  //float x = width / 2; (commented out so draw x/y not overridden)
  //float y = width / 2;
  //set angle of rotation (rad)
  float theta = 0;
  int side = sides;
  //rotations makes code more compact since TWO_Pi / 5 is constant
  float rotations = TWO_PI / side;
  //Declaring x2/y2 outside for loop is better for memory
  float x2 = 0, y2 = 0;
  fill(fillCol);
  strokeWeight(strkWt);
  beginShape();
  //for loop replaces repreated lines of code
  //plot vertex -> incrememnt theta, repeat until 5 vertices are made
  for (int i = 0; i < sides; i += 1) {
    x2 = x + cos(theta) * radius*2;
    y2 = y + sin(theta) * radius*2;
    vertex(x2, y2);
    theta += rotations;
  }
  endShape(CLOSE);
}