void polygon(){
  //adding '- radius' makes x and y reach collision targets (x - radius, y - radius)
  //before the shape itself is there
  //if that is done then replace '0' with radius and remove '* 2'
  rect(x, y, radius * 2, radius * 2);
}