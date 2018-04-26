data heart;
infile '\\Client\D$\SMU DS\Stats II\Pro 1\heart.csv' firstobs = 2 dlm = ',';
input ID $ age phys $ sbp dbp ht wt chol ses $ c_stat $;


data heart2;
set heart;
lht = log(ht);
lchol = log(chol);
SD = sbp * dbp;
run;

proc glm data=heart2 order=freq PLOTS=(DIAGNOSTICS RESIDUALS);
	model chol = wt ht / solution ss3;
run;

proc sgscatter data = heart;
matrix chol age sbp dbp ht wt;
run; 

proc reg data=heart2 plots = cooksd(LABEL);
model wt = ht sbp dbp / CLI CLM CLB;
run;
