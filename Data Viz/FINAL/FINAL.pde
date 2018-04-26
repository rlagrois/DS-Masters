Table table;
float yPos;
float xPos;
float yAdj;
float xAdj;
void setup(){
  size(1000, 1000, P3D);
  lights();
  table = loadTable("eveDONE.csv", "header");

  println(table.getRowCount() + " total rows in table"); 

}

void draw(){
  background(255);
  camera(mouseX, mouseY, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
  stars();

}


void stars(){
  for (TableRow row : table.rows()) {
    float y = row.getFloat("z");
    float x = row.getFloat("x");
    float z = row.getFloat("y");
    float sec = row.getFloat("security");
   

    yPos = (y * -1) + 500;
    xPos = x + 500;
 
    
  if(sec >= 0.5){
    stroke(0, 0, 255);
    fill(0, 0, 255);
  }
  if (sec >= 0.1 && sec < 0.5){
    stroke(240, 94, 2);
    fill(240, 94, 2);
  }
  if(sec < 0.1) {
    stroke(255, 0, 0);
    fill(255, 0, 0);
  }
  
  pushMatrix();
  translate(xPos, yPos, z);
  sphere(1);
  popMatrix();
  }
}