data Melanoma;                                                                                                                                                                          
infile '\\Client\D$\SMU DS\Stats II\Unit 4 HW\Melanomatimeseries.csv' dlm=',' firstobs=2;                                                                                                        
input Year Melanoma Sunspot;                                                                                                                                                            
run;                                                                                                                                                                                    
                                                                                                                                                                                        
                                                                                                                                                                                        
proc autoreg data=Melanoma plots(unpack);      /* Using proc autoreg to fit a model */                                                                                                                                         
model Melanoma=Sunspot / dwprob;                        /*as if observation were independent. */                                                                                                                                         
run;                                                                                                                                                                                    
quit;                                                                                                                                                                                   
                                                                                                                                                                                        
                                                                                                                                                                                        
proc reg data=Melanoma plots(unpack);       /* Using proc reg to fit the same model */                                                                                                                                                                                                                                                                                     
model Melanoma=Sunspot;                     /*as if observation were independent. */                                                                                                                                            
run;                                                                                                                                                                                    
quit;                                                                                                                                                                                   

proc autoreg data=Melanoma plots(unpack);        /*Using auto reg to fit model adding ‘year’ */                                                                                                                                  
model Melanoma=Sunspot Year / dwprob;                    /*still assuming independent observations */                                                                                                                           
run;                                                                                                                                                                                    
quit;                                                                                                                                                                                   
                                                                                                                                                                                        
                                                                                                                                                                                                                                                                                                                                                                              
proc autoreg data=Melanoma plots(unpack) ;     /*Using auto reg to fit model with AR(1)*/                                                                                                                                          
model Melanoma=Sunspot Year / nlag = 1 dwprob;
title 'AR1'; 
run;                                                                                                                                                                                    
quit;                                                                                                                                                                                   
                                                                                                                                                                                        
                                                                                                                                                                                        
proc autoreg data=Melanoma plots(unpack);     /*Using auto reg to fit model with AR(2)*/                                                                                                                                          
model Melanoma=Sunspot Year  / nlag = 2; 
title 'AR2'; 
run;                                                                                                                                                                                    
quit;                                                                                                                                                                                   
                                                                                                                                                                                        
                                                                                                                                                                                        
proc autoreg data=Melanoma plots(unpack);    /*Using auto reg to fit model with AR(3)*/                                                                                                                                                                                                                                                                                     
model Melanoma=Sunspot Year  / nlag = 3; 
title 'AR3'; 
run;                                                                                                                                                                                    
quit;                                                                                                                                                                                   
                                                                                                                                                                                         
