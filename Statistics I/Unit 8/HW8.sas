data scat;
infile '\\Client\C$\Users\rem\Desktop\SMU DS\Stats 1\Unit 8\baseball_data2.csv' firstobs=2 DLM=",";
input team $ payroll wins;

proc sgplot data=scat;
	scatter x=payroll y=wins;
run;


proc corr data=scat;
var payroll wins;
run;
