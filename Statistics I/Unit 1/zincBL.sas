data creativity;
informat group $4.;
label Score='Zinc Conc (mg/mL)';
input group @;
do i=1 to 19;
	input Score @;
	output;
end;
drop i;
datalines;
+Cal 1.31 1.45 1.12 1.16 1.50 1.20 1.22 1.42 1.14 1.23 1.59 1.11 1.10 1.53 1.52 1.17 1.49 1.62 1.29
-Cal 1.13 1.71 1.39 1.15 1.33 1.00 1.03 1.68 1.76 1.55 1.34 1.47 1.74 1.74 1.19 1.15 1.20 1.59 1.47
;
ods graphics off;
title "Remy's Blood Zinc Boxplot";
proc boxplot data=creativity;
	plot score*group;
proc means data=creativity;
run;
