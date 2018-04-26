data edu_income;
infile '\\client\c$\Users\rem\Desktop\SMU DS\Stats 1\Unit 5\ex0525.csv' firstobs = 2 dlm = ",";
input ID $ Edu $ Income;
run;
proc sort data=edu_income; by edu; run;
proc anova data=edu_income;
class Edu;
model income = edu;
run;

proc univariate data=edu_income;
histogram;
class edu;
var income;
run;
