data cars;
input rate location $;
datalines;
13.75	Dallas
13.75	Dallas
13.5	Dallas
13.5	Dallas
13.4	Dallas
13.2	Dallas
13	Dallas
13	Dallas
13	Dallas
12.75	Dallas
12.5	Dallas
13.25	east
13	east
12.1	east
12.75	east
12.5	east
12.5	east
12.4	east
12.8	east
12.3	east
11.9	east
11.9	east
14	west
14	west
13.51	west
13.5	west
13.5	west
13.25	west
13	west
12.5	west
12.5	west
14.5	west
14	west
14	west
13.9	west
13.75	west
13.25	west
13	west
13.5	west
13.4	west
12.5	north
12.25	north
12.25	north
12	north
12	north
12	north
12	north
11.9	north
11.9	north
9.1	east
10	east
9.3	east
10.1	east
10.3	east
9.8	east
10.9	west
11.5	west
11.4	west
11.8	west
11.6	west
11.5	west
11.4	west
11.3	west
11.5	west
11.1	west
11.7	west
12.4	west
12.3	west
12.8	west
12.7	west
12.5	west
12.4	west
12.6	west
10.7	north
10.5	north
10.4	north
10.8	north
9.9	north
10.4	north
10.2	north
10.8	north
;


proc glm data=cars;
class location;
model rate = location;
means location / bon dunnett('Dallas');
run;
