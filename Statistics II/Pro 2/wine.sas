data wine;
infile '\\Client\D$\SMU DS\Stats II\Pro 2\winequality-red.csv' firstobs = 2 dlm = ';';
input fix_acid vol_acid citric sugar chloride free_SuO2 tot_SuO2 density pH sulphate alc qual;

proc means data=wine n mean min max std var;
run;
 
title 'histogram and scatter';
proc sgscatter data=wine;
matrix fix_acid vol_acid citric sugar chloride free_SuO2 tot_SuO2 density pH sulphate alc qual / diagonal=(histogram) group=qual;
run;

data wine2;
set wine;
qual_10 = 10 * qual;
run;

title 'full PCA with 10 qual';
proc princomp data=wine2 out=wineP2;
var qual_10 fix_acid vol_acid citric sugar chloride free_SuO2 tot_SuO2 density pH sulphate alc;
run;

title 'PCR with cross 10qual';
proc pls data=wine2 method=PCR cv=one cvtest (stat=PRESS);
model qual_10 = fix_acid vol_acid citric sugar chloride free_SuO2 tot_SuO2 density pH sulphate alc;
run; 

title 'PCR with 3';
proc pls data=wine2 method=PCR nfac=3;
model qual_10 = fix_acid vol_acid citric sugar chloride free_SuO2 tot_SuO2 density pH sulphate alc;
run;

title "Reg 3 Prin CI";
proc reg data=wineP2;
model qual_10 = Prin1 Prin2 Prin3 / CLB;
run;

title "correlations";
proc corr data=wine2;
var qual_10 fix_acid vol_acid citric sugar chloride free_SuO2 tot_SuO2 density pH sulphate alc;
run;

