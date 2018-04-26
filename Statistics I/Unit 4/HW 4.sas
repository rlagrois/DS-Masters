data metab;
input pat_type $ meta_rate;
datalines;
Trauma	38.5
Trauma	25.8
Trauma	22
Trauma	37.6
Trauma	30
Trauma	24.5
Non	20
Non	20.1
Non	22.9
Non	18.8
Non	20.9
Non	20.9
Non	22.7
Non	21.4
;

proc anova data = metab;
class pat_type;
model meta_rate = pat_type;
means welch;
run;
