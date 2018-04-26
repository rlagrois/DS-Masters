data brain;
infile '\\client\c$\SMU DS\Stats 1\Unit 12\Brain.csv' firstobs = 2 dlm = ',';
input Species $	Brain	Body	Gestation	Litter;
run;

proc sgscatter data = brain;
matrix Brain Body Gestation Litter;
run;

/*log transformation*/
data log_brain;
set brain;
l_brain = log(brain);
l_body = log(body);
l_gest = log(gestation);
l_litter = log(litter);
run;

proc sgscatter data = log_brain;
matrix l_Brain l_Body l_Gest l_Litter;
run;

/*model for body, gest, and litter*/
proc glm data = log_brain;
model l_brain =l_body l_Gest l_litter;
run;

/*model for body only*/
proc glm data = log_brain;
model l_brain = l_body;
run;

/*model for body and gest*/
proc glm data = log_brain;
model l_brain = l_body l_gest;
run;

/*proc reg for residuals*/
proc reg data = log_brain;
model l_brain = l_litter l_body l_gest;
run;

data log_brain2;
set log_brain;
in_lit = litter**2;
run;

proc sgscatter data = log_brain2;
matrix l_brain l_gest l_body in_lit;
run;
