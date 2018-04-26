options ls=78;
data ost;
	infile '\\Client\D$\SMU\Stats II\Project 3\glow500.csv' firstobs = 2 dlm = ',';
	input sub_id site_id phy_id hist age wt ht bmi meno_45 mom_frac arm_ast smoke risk frac_score frac;
	ident = _n_;
	drop sub_id site_id phy_id smoke;
	run;

proc sort;
	by ident;
run;

title 'comp final';
proc cluster method=complete outtree=clust1;
	var hist age wt ht bmi meno_45 mom_frac arm_ast risk frac_score frac;
	id ident;
run;

proc tree horizontal nclusters=5 out=clust2;
	id ident;
run;

proc sort;
	by ident;
run;
/*
proc print;
run;
*/

data combine;
	merge ost clust2;
	by ident;
	run;

proc glm data=combine;
	class cluster;
	model hist age wt ht bmi meno_45 mom_frac arm_ast risk frac_score frac = cluster;
	means cluster;
	run;


