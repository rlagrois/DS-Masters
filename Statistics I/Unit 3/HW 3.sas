data education;
infile "\\Client\C$\Users\rem\Desktop\SMU DS\Stats 1\Unit 3\EducationData.csv" DLM=','firstobs=2;
input ID $ Edu $ Income;
log_i = log(income);


            


proc ttest data=education;
Class Edu;
Var log_i;
run;
