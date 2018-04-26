data wildflower;
infile '\\Client\C$\SMU DS\Stats II\Unit 2 HW\Wildflower.csv' dlm=',' firstobs=2 missover;
input  Year Region $ Sep Oct Nov Dec Jan Feb Mar Total Rating $ Score;
RandNumber=ranuni(1);
run;

*converting the Region categories into dummy variables;
data wildflower2;
set wildflower;
DumCol=(Region='colorado');
DumMoj=(Region='mojave');
DumUpl=(Region='upland');
Total2=Total*Total;
run;

proc print data=wildflower; run;

************************************************************************************;

proc sgscatter data=wildflower2 ;
matrix Score  Oct Nov Dec Total/ diagonal=(histogram) group=Region ;
run;

proc sgscatter data=wildflower2 ;
matrix Score Jan Feb Mar Sep / diagonal=(histogram) group=Region ;
run;


proc sgscatter data=wildflower2 ;
matrix Score Jan Feb Mar Sep Oct Nov Dec Total  / diagonal=(histogram) group=Region ;
run;

************************************************************************************;
*First pass analysis by fitting all the predictors in the model                     ;


proc reg data = wildflower2 outest=WildResults plots(label) = (rstudentbyleverage cooksd)  ;
model Score = DumCol DumMoj DumUpl Sep Oct Nov Dec Jan Feb Mar Total / AIC VIF  CLI; *CORRB INFLUENCE CLB;
run;
quit;



*Answer some questions about the above output and try to make your own corresponding adjustments





*Modelselection;

data train;
set Wildflower;
if RandNumber > 1/2 then delete;
run;


data test;
set Wildflower;
if RandNumber < 1/2 then delete;
run;


ods graphics on;
proc glmselect data=Wildflower
               seed=1 plots(stepAxis=number)=(criterionPanel ASEPlot CRITERIONPANEL);
class Region;
model Score = Region Total Sep Oct Nov Dec Jan Feb Mar Year / selection=LASSO(choose=CV stop=AIC) CVdetails  ;
run;
quit;
ods graphics off;


ods graphics on;
proc glmselect data=Wildflower
               seed=1 plots(stepAxis=number)=(criterionPanel ASEPlot CRITERIONPANEL);
class Region;
model Score = Region Total Sep Oct Nov Dec Jan Feb Mar Year / selection=LASSO(choose=AIC stop=CV) CVdetails  ;
run;
quit;
ods graphics off;


ods graphics on;
proc glmselect data=train testdata=test
               seed=1 plots(stepAxis=number)=(criterionPanel ASEPlot CRITERIONPANEL);
class Region;
model Score = Region Total Sep Oct Nov Dec Jan Feb Mar Year / selection=LASSO(choose=CV stop=AIC) CVdetails  ;
run;
quit;
ods graphics off;


*An example of using proc reg to compare a full model with a reduced model.  Resulting output
produces an F-test. Null: the regression coeffecients on the additional predictors are all 0 versus
the alternative that at least one is not 0.;
*In the below example I am testing if any of the individual months are significant given that TOTAL is already
included in the model along with REGION;


ods graphics on ;

proc reg data = wildflower2 outest=WildResults    plots(label) = (rstudentbyleverage cooksd)  ;
model Score = DumCol DumMoj DumUpl Total Sep Oct Nov Dec Jan Feb Mar / AIC VIF  CLI; *CORRB INFLUENCE CLB;
test Sep, Oct, Nov, Dec, Jan, Feb, Mar;
run;
quit;
ods graphics off;



  *Here is an example of how to do run the same types of multiple regression using proc GLM;
*Note to get VIF type diagnostics we have to specify the Tolerance option (Tolerance=1/VIF);
*CLI is still used to obtain the predicted values of the observations as well as new observations
*We have to specify noint as an option since we have a categorical variable.  Although it is okay to not specify it, the resulting t-table output may confuse you. See Dr.McGee's
slides on parameterization of multiple regeression models.
Solutions provides the t-tests for the regression coeffiecents.;

ods graphics on;
proc glm data = wildflower PLOTS=(DIAGNOSTICS RESIDUALS);
class Region;
model Score = Region Total Sep Oct Nov Dec Jan Feb Mar / Noint Solution Tolerance CLI;
run; quit;

ods graphics off;
