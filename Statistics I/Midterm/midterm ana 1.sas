data red40;
input Life Dose $;
log_l = log(Life);
datalines;
70	Control
77	Control
83	Control
87	Control
92	Control
93	Control
100	Control
102	Control
102	Control
103	Control
96	Control
49	Low
60	Low
63	Low
67	Low
70	Low
74	Low
77	Low
80	Low
89	Low
30	Medium
37	Medium
56	Medium
65	Medium
76	Medium
83	Medium
87	Medium
90	Medium
94	Medium
97	Medium
34	High
36	High
48	High
48	High
65	High
91	High
98	High
102	High
;


proc univariate data=red40;
class dose;
var log_l;
histogram;
qqplot;
run;

proc npar1way data=red40;
class dose;
var life;
exact median; 
run;

proc glm data=red40;
class dose;
model life=dose;
lsmeans dose / dunnett('Control');
run;

proc glm data=red40;
class dose;
model life=dose;
contrast 'Control vs low'
	dose -1 0 1 0
	/ E;
run;
