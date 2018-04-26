data all_euro;
infile "\\Client\C$\Users\rem\Desktop\SMU DS\EuroDeathAge2.csv" DLM=',' firstobs=2;
input status $ age ID $ dont $;

proc glm data=all_euro;
class status;
model age=status;
contrast 'Aris greater than others'
	status 2 -1 -1
	/ E;
run;
