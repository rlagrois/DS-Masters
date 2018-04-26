data crabforce;

infile '\\client\c$\SMU DS\Stats 1\Unit 12\Crab.csv' firstobs = 2 dlm = ',';
input Force Height Species $;
run;

proc glm data = crabforce;
class Species;
model Force = Height | Species / solution;
run;

proc sgplot data = crabforce;
scatter x = Height y = Force / group = species;
run;

symbol1 value=star color=red;
symbol2 value=plus color=blue;
symbol3 value=x color=green;
proc gplot data = crabforce;
plot height*force = species;
run;

/*sets log trans*/
data lcrab;
set crabforce;
l_height = log(Height);
l_force = log(Force);
run;

/*scatterplot for log trans data*/
symbol1 value=star color=red;
symbol2 value=plus color=blue;
symbol3 value=x color=green;
proc gplot data = lcrab;
plot l_height*l_force = species;
run;

/*multi reg model for log trans*/
proc glm data = lcrab;
class Species (ref='Hemigrap');
model l_force = l_height | Species / solution;
run;

/*sets dummy variables for species*/
data lcrab2;
set lcrab;
if Species = 'Lophopan' then dmy1 = 1; else dmy1= 0;
if Species = 'Cancer p' then dmy2 = 1; else dmy2 = 0;
int1 = l_height * dmy1;
int2 = l_height * dmy2;
run;
proc print data = lcrab2;
run;

/*for residual plots for log trans*/
proc reg data = lcrab2;
model l_force = l_height dmy1 dmy2 int1 int2;
run;
