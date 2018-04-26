class features { 
  
  features(){
  }
  
  //#CE0003
  void reds(color rCol){
    noStroke();
    fill(rCol);
    rect(width *.222, height * .28, 500, 52);
    rect(width * .222, height * .4, 500, 52);
    rect(width * .38, height * .4, 50, 320);
    rect(width * .57, height * .4, 50, 320);
  }
  
  void blacks(color bCol){
    noStroke();
    fill(bCol);
    rect(width * .222, height * .33, 500, 65);
    rect(width * .43, height * .401, 127, 320);
  }
  
  //#CEBA00
  void yellows(color yCol){
   noStroke();
   fill(yCol);
   rect(width * .57, height * .20, 20, 50);
   rect(width * .61, height * .20, 20, 50);
   rect(width * .65, height * .20, 20, 50);
   rect(width * .69, height * .20, 20, 50);
  }
  
  //#898886
  void ant(color aCol){
    noStroke();
    fill(aCol);
    rect(width * .2, height * .0878, 20, 600);
    rect(width * .133, height * .07, 80, 30);
  }
  
}