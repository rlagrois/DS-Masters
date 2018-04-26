Table table;
float[] yPos = new float[8035];
float[] xPos = new float[8035];
float[] zPos = new float[8035];
float[] sec = new float[8035];
int i = 0;

import peasy.*;

PeasyCam camera;

void setup(){
  size(1000, 1000, P3D);
  //lights();
  table = loadTable("eveDONE.csv", "header");
  camera = new PeasyCam(this, width/2, height/2, 0, 1000);
  println(table.getRowCount() + " total rows in table"); 
  stars();

}

void draw(){
  background(0);
  putStars();

}


void stars(){
  for (TableRow row : table.rows()) {
    float y = row.getFloat("z");
    float x = row.getFloat("x");
    float z = row.getFloat("y");
    float stat = row.getFloat("security");
   

    yPos[i] = (y * -1) + 500;
    xPos[i] = x + 500;
    zPos[i] = z;
    sec[i] = stat;
    
    i++;
    

  }
}

void putStars(){
  for(i = 0; i < 8035; i++){
    if(sec[i] >= 0.5){
      stroke(0, 0, 255);
      fill(0, 0, 255);
    }
    if (sec[i] >= 0.1 && sec[i] < 0.5){
      stroke(240, 94, 2);
      fill(240, 94, 2);
    }
    if(sec[i] < 0.1) {
      stroke(255, 0, 0);
      fill(255, 0, 0);
    }
  
    pushMatrix();
    translate(xPos[i], yPos[i], zPos[i]);
    sphereDetail(2);
    sphere(1);
    popMatrix();
  
  }
}