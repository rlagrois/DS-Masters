Cat c1, c2;
void setup(){
  
  c1 = new Cat();
  c1.wt = 27.5;
  
  //if it were just 'println(wt)' it wouldnt work
  println(c1.wt);
  
  //c1 and c2 are not linked
  c2 = new Cat();
  c2.wt = 14.5;
}