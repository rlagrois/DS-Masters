data edu_income;
infile '\\client\c$\Users\rem\Desktop\SMU DS\Stats 1\Unit 5\ex0525.csv' firstobs = 2 dlm = ",";
input ID $ Edu $ Income;
run;

proc glm data=edu_income;
class Edu;
model income = Edu;
means Edu / Tukey dunnett;
run;

