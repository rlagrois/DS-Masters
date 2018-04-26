data sales;
input age @@;
datalines;
43	26	30	27	40
35	48	36	47	41
34	45	30	38	33
35	44	24	33	40
31	23	29	37	28
;

proc print data=sales;
run;

proc sgplot data=sales;
hbox age;
run;
