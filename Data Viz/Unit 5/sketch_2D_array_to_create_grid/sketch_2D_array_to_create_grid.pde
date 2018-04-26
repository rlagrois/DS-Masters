int cols = 20;
int rows = 20;

//2D array, like a table
int[][] vals2D = new int[cols][rows];
void setup(){
  size(400, 400);
  background(0, 200, 200);
  
  int colSpan = width / cols;
  int rowSpan = height / rows;
  
//use nested for loop to fill
//goes to first col then down the rows then next col etc
  for(int i = 0; i < vals2D.length; i++){
    for(int j = 0; j < vals2D[i].length; j++){
       rect(colSpan * i, rowSpan * j, colSpan, rowSpan);
   }
  }
}