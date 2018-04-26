data low_birth;
infile '\\client\c$\SMU DS\Stats 1\MiniPro\lowbwt.csv' firstobs = 2 dlm = ',';
input ID $ is_low age mom_wt race smoke pre_hist h_bp UI doc brt_wt;

proc print data=low_birth;
run;

data lb2;
set low_birth;
smk_age = smoke * age;
mw_age = mom_wt * age;
l_mw = log(mom_wt);

proc reg data=lb2 plots = cooksd(LABEL);
model brt_wt = age mom_wt smoke h_bp UI smk_age / CLI CLM CLB;
run;

proc glm data=lb2;
model brt_wt = age mom_wt smoke h_bp UI smk_age / solution CLI;
run;

proc glm data=lb2;
class smoke;
model brt_wt = age mom_wt smoke h_bp UI smk_age / solution;
run;

proc sgscatter data=lb2;
matrix brt_wt mom_wt age;
run;

proc gplot data=lb2;
plot mom_wt*smk_age = brt_wt;
run;
