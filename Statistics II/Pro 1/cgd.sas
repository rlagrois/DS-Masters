data cgd;
infile '\\Client\D$\SMU DS\Stats II\Pro 1\pharynx.csv' firstobs = 2 dlm = ',';
input ID $ ent_date $ inf_date $ treatment inherit age ht wt steroid antibio sex region time t2 cens seq;



data cgd2;
set cgd;
d_treat = treatment - 1;
d_inherit = inherit - 1;
d_steroid = steroid - 1;
d_sex = sex - 1; 
d_anti = antibio - 1;
l_time = log(time);
s_i = d_sex * d_inherit;
t_sa = d_treat * d_steroid;
t_a = d_treat * d_anti;
l_treat = log(d_treat);
l_steroid = log(d_steroid);
l_anti = log(d_anti);
t_w = d_treat * wt;
run;

proc print data=cgd2;
run;


/*final model?*/
proc glm data=cgd2 PLOTS=(DIAGNOSTICS RESIDUALS);
	class d_treat;
	model time = d_treat / solution ss3;
run;

proc reg data=cgd2 plots = cooksd(LABEL);
var  d_treat;
model time = d_treat wt t_w / CLB;
run;

proc means data=cgd2 n mean max min range std;
var time;
run;

proc sgscatter data=cgd2;
matrix d_treat time;
run;

proc glm data=cgd2 PLOTS=(DIAGNOSTICS RESIDUALS);
	class d_anti d_steroid;
	model time = d_anti d_steroid / solution ss3;
run;

proc ttest data=cgd2;
class d_treat;
var time;
run;

proc corr data=cgd2;
var age ht wt;
with time;
run;


proc sgplot data=cgd2;
histogram time;
run;



