class Cat {
 //properties/attributes (fields)
 float wt;
 String breed;
 boolean isLongHaired;
 int age;
 
 //constructors (initialize class)
 //default constructor below
 Cat(){
 }
 //construcors for setting attributes
 Cat(float wt, String breed){
   //this. keeps varible wt local within constructor
   this.wt = wt;
   this.breed = breed;
   //this constructor hasn't been invoked so this won't print
   println("not called");
 }
 
 Cat( float wt, String breed, boolean _isLongHaired, int age){
   this.wt = wt;
   this.breed = breed;
   // adding _ bypasses needing this. to keep variable local
   isLongHaired = _isLongHaired;
   this.age = age;
   //this will print since c3 invoked this constructor
   println("in cstr");
 }
  
}