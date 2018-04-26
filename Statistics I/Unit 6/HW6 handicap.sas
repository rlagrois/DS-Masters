data handi;
input score Hcap $;
datalines;
1.9	None
2.5	None
3	None
3.6	None
4.1	None
4.2	None
4.9	None
5.1	None
5.4	None
5.9	None
6.1	None
6.7	None
7.4	None
7.8	None
1.9	Amputee
2.5	Amputee
2.6	Amputee
3.2	Amputee
3.6	Amputee
3.8	Amputee
4	Amputee
4.6	Amputee
5.3	Amputee
5.5	Amputee
5.8	Amputee
5.9	Amputee
6.1	Amputee
7.2	Amputee
3.7	Crutches
4	Crutches
4.3	Crutches
4.3	Crutches
5.1	Crutches
5.8	Crutches
6	Crutches
6.2	Crutches
6.3	Crutches
6.4	Crutches
7.4	Crutches
7.4	Crutches
7.5	Crutches
8.5	Crutches
1.4	Hearing
2.1	Hearing
2.4	Hearing
2.9	Hearing
3.4	Hearing
3.7	Hearing
3.9	Hearing
4.2	Hearing
4.3	Hearing
4.7	Hearing
5.5	Hearing
5.8	Hearing
5.9	Hearing
6.5	Hearing
1.7	Wheelchair
2.8	Wheelchair
3.5	Wheelchair
4.7	Wheelchair
4.8	Wheelchair
5	Wheelchair
5.3	Wheelchair
6.1	Wheelchair
6.1	Wheelchair
6.2	Wheelchair
6.4	Wheelchair
7.2	Wheelchair
7.4	Wheelchair
7.6	Wheelchair
;
proc glm data = handi;
class Hcap;
model score=Hcap;
means Hcap / bon LSD DUNNETT Tukey scheffe;
run;

proc means data = handi;
class Hcap;
var score;
run;
