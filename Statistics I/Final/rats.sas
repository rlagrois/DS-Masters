data rats;
input Treatment $ Consumed;
datalines;
Ctrl	5.4
Ctrl	6.2
Ctrl	3.1
Ctrl	3.8
Ctrl	6.5
Ctrl	5.8
Ctrl	6.4
Ctrl	4.5
Ctrl	4.9
Ctrl	4
Exp	8.8
Exp	9.5
Exp	10.6
Exp	9.6
Exp	7.5
Exp	6.9
Exp	7.4
Exp	6.5
Exp	10.5
Exp	8.3
;

proc ttest data=rats;
class treatment;
var consumed;
run;
