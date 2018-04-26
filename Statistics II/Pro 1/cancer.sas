data cancer;
infile '\\Client\D$\SMU DS\Stats II\Pro 1\pharynx.csv' firstobs = 2 dlm = ',';
input case $ sex treat grade age condi site t_stage n_stage time;
 
data cancer2;
set cancer;
	l_time = log(time);
run;

proc glm data=cancer2 order=freq PLOTS=(DIAGNOSTICS RESIDUALS) ;
	class condi;
	model time = condi / solution ss3;
run;

