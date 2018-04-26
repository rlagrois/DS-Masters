data chem_decay;
input time conc;
datalines;
1 2.57
1 2.84
1 3.10
3 1.07
3 1.15
3 1.22
5 0.49
5 0.53
5 0.58
7 0.16
7 0.17
7 0.21
9 0.07
9 0.08
9 0.09
;

proc reg data = chem_decay;
model conc = time / lackfit;
run;


proc anova data = chem_decay;
class time;
model conc = time;
run;
