data forex;
input result strat $;
datalines;
-0.00480999	Day
0.00283	Day
0.00418	Day
-0.00729	Day
-0.00083	SMA
-0.00099	SMA
-0.00207	SMA
0.00074	SMA
-0.00199	SMA
0.0021	SMA
-0.00085	SMA
0.00192	SMA
-0.00083	SMA
0.00638	Random
0.00504	Random
-0.0044	Random
-0.0534	Random
0.00516	Random
0.00326	Random
0.00766	Random
-0.00096	Random
0.00282	Random
-0.00045	Random
-0.0003	Twitter
0.00079	Twitter
-0.00214	Twitter
2.00E-05	Twitter
-0.00106	Twitter
0.00378	Twitter
-0.00205	Twitter
1.00E-05	Twitter
-0.00667	Twitter
;

proc anova data = forex;
class strat;
model result = strat;
run;

data log_forex;
set forex;
l_result = log(result);
run;

proc glm data = log_forex alpha = 0.4;
class strat;
model l_result = strat;
means strat / bon scheffe dunnett('Random');
run;

proc anova data = log_forex;
class strat;
model l_result = strat;
run;


