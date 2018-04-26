data bball;
input team $ salary;
datalines;
Sea	1.4
Sea	2.25
Sea	13.4
Sea	2.3
Sea	18
Sea	2.05
Sea	2
Sea	7.66
NYY	20.6
NYY	6
NYY	33
NYY	21.6
NYY	6.55
NYY	13
NYY	13
NYY	13.1
;

proc npar1way data=bball Wilcoxon;
class team;
var salary;
run;

proc sgplot data=bball;
hbox salary / category=team;
run;
