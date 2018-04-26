                                                                                                                                                                                                                           
data creativity;                                                                                                                                                                                                             
input Score Treatment;                                                                                                                                                                                                       
datalines;                                                                                                                                                                                                                   
156	1
109	1
137	1
115	1
152	1
140	1
154	1
178	1
111	1
123	1
126	1
126	1
137	1
165	1
129	1
200	1
150	1
118	2
140	2
114	2
180	2
115	2
126	2
92	2
169	2
139	2
121	2
132	2
75	2
88	2
113	2
151	2
70	2
115	2
187	2
114	2



;                                                                                                                                                                                                                            
                                                                                                                                                                                                                             
                                                                                                                                                                                                                             
* To get the observed difference;                                                                                                                                                                                            
proc ttest data=creativity;  * You will need to change the dataset name here.;                                                                                                                                               
                                                                                                                                                                                                                             
   class treatment;    *and change the class variable to match yours here;                                                                                                                                                   
                                                                                                                                                                                                                             
   var score;          * and change the var name here.;                                                                                                                                                                      
                                                                                                                                                                                                                             
run;                                                                                                                                                                                                                         

*borrowed code from internet ... randomizes observations and creates a matrix ... one row per randomization ;                                                                                                                
proc iml;                                                                                                                                                                                                                    
use Creativity;                        * change data set name here;                                                                                                                                                          
read all var{treatment score} into x;   *change varibale names here;                                                                                                                                                         
p = t(ranperm(x[,2],300));                                                                                                                                                                                                  
paf = x[,1]||p;                                                                                                                                                                                                              
create newds from paf;                                                                                                                                                                                                       
append from paf;                                                                                                                                                                                                             
quit;                                                                                                                                                                                                                        
                                                                                                                                                                                                                             
*calculates differences and creates a histogram;                                                                                                                                                                             
ods output conflimits=diff;                                                                                                                                                                                                  
proc ttest data=newds plots=none;                                                                                                                                                                                            
  class col1;                                                                                                                                                                                                                
  var col2 - col301;                                                                                                                                                                                                        
run;                                                                                                                                                                                                                         
proc univariate data=diff;                                                                                                                                                                                                   
  where method = "Pooled";                                                                                                                                                                                                   
  var mean;                                                                                                                                                                                                                  
  histogram mean;                                                                                                                                                                                                            
run;                                                                                                                                                                                                                         
                                                                                                                                                                                                                             
*calculates the number of randomly generated differences that are as extreme or more extreme thant the one observed (divide this number by 1000 you have the pvalue);                                                        
*check the log to see how many observations are in the data set.... divide this by 1000 and that is the (one sided)p-value;                                                                                                  
data numdiffs;                                                                                                                                                                                                               
set diff;                                                                                                                                                                                                                    
where method = "Pooled";                                                                                                                                                                                                     
if abs(mean) >= 17.4892;   *you will need to put the observed difference you got from t test above here.;                                                                                                                       
run;                                                                                                                                                                                                                         
* just a visual of the rows produced ... you can get the number of obersvations from the last data step and the Log window.;                                                                                                 
proc print data = numdiffs;                                                                                                                                                                                                  
where method = "Pooled";                                                                                                                                                                                                     
run;                                                                                                                                                                                                                         
                                                                                                                                                                                                                             
                                                                                                                                                                                                                             
proc print data = diff;                                                                                                                                                                                                      
run; 
                   
