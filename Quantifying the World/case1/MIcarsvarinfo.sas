data cars;
infile '\\Client\D$\SMU\qtw\case1\carmpgdata_2_2_2.txt' dsd dlm='09'x firstobs=2;
input Auto $ MPG Cylinders Size HP Weight Accel Eng_type;

proc print data=cars;
run;

proc means data=cars NMISS N;
run;

ods listing gpath="\\Client\D$\SMU\qtw\case1\graphics";

title 'Regression with Listwise Deletion';
proc reg data=cars;
	model mpg = Cylinders Size HP Weight Accel Eng_type;
run;

title 'Missing Data Pattern';
ods select misspattern;
proc mi data=cars nimpute=0;
var MPG Cylinders Size HP Weight Accel Eng_type;
run;
/* seems non-monotone */

title 'Creating 5 Imputations';
proc mi data=cars out= MIcars  nimpute=5 seed=3935;
	var MPG Cylinders Size HP Weight Accel Eng_type;
run;

title 'Regression Using Imputations';
proc reg data= MIcars outest= carReg covout;
	model MPG = Cylinders Size HP Weight Accel Eng_type;
	by _Imputation_;
run;

ods listing close;
ods listing gpath="\\Client\D$\SMU\qtw\case1\graphics\";
ods graphics on;

title 'Combinging the Analyses';
ods select VarianceInfo;
proc mianalyze data=carReg;
	modeleffects Cylinders Size HP Weight Accel Eng_type Intercept;
run;

ods listing close;
ods listing;
