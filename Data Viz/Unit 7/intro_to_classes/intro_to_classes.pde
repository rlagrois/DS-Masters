A obj1;
A obj2;

void setup(){
  size(400, 400);
  background(255);
  
  obj1 = new A();
  println(obj1);
  
  obj2 = new A();
  println(obj2);
  
  //this just gives them the same memory class, not the same contents
  obj1 = obj2;
  println(obj1);
  println(obj2);
}