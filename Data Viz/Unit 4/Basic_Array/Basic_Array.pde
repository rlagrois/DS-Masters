void setup(){
  //arrays have defined length and can only contain one data type
  
  //declare array 'vals'
  int[] vals;
  //set length
  vals = new int[45000];
  
  //set random value 0-1000 in each spot in array
  for(int i=0; i< vals.length; i += 1){
    vals[i] = int(random(1000));
}