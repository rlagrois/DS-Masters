data creativity;
informat group $3;
label Score='Judged Score';
input group @;
do i=1 to 24;
	input Score @;
	output;
end;
drop i;
datalines;
Int 12.0 12.0 12.9 13.6 16.6 17.2 17.5 18.2 19.1 19.3 19.8 20.3 20.5 20.6 21.3 21.6 22.1 22.2
    22.6 23.1 24.0 24.3 26.7 29.7
Ext 5.0 5.4 6.1 10.9 11.8 12.0 12.3 14.8 15.0 16.8 17.2 17.2 17.4 17.5 18.5 18.7 18.7 19.2
    19.5 20.7 21.2 22.1 24.0 .
;
ods graphics off;
title "Remy's Creativity Study Plot";
proc boxplot data=creativity;
	plot score*group;
run;
