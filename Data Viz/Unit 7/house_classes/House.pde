class House {
  //fields (attributes)
  Door door;
  Door[] doors;
  Staircase stairs;
  Window[] windows;
  
  //contructors
  //first constructor sets default for door, second allows user to enter
  House(){
    door = new Door();
    stairs = new Staircase();
    windows = new Window[];
  }
  
  House(Door[] doors, Staircase stairs, Window[] windows){
    this.doors = doors;
    this.stairs = stairs;
    this.windows = windows;
  }
 
  //methods
  void construct(){
    //in  loop
    doors[i].construct();
    stairs.construct();
    //construct methods would be in door/staircase as well
  }
  
}