data crime;
input STATE $	VI	VI2	MU	ME	WH	HS	PO;
datalines;
AK	593	59	6	65.6	70.8	90.2	8
AL	430	43	7	55.4	71.4	82.4	13.7
AR	456	46	6	52.5	81.3	79.2	12.1
AZ	513	51	8	88.2	87.6	84.4	11.9
CA	579	58	7	94.4	77.2	81.3	10.5
CO	345	34	4	84.5	90.3	88.3	7.3
CT	308	31	3	87.7	85.1	88.8	6.4
DE	658	66	3	80.1	75.3	86.5	5.8
FL	730	73	5	89.3	80.6	85.9	9.7
GA	454	45	8	71.6	66.4	85.2	10.8
HI	270	27	2	91.5	26.5	88	7.4
ID	243	24	2	66.4	95.5	87.9	9.8
IL	557	56	7	87.8	79.4	86.8	8.5
IN	353	35	6	70.8	88.7	87.2	7.5
IO	272	27	2	61.1	95	89.8	6.9
KS	396	40	5	71.4	89.4	89.6	7.1
KY	262	26	5	55.8	90.4	81.8	14.2
LA	646	65	13	72.6	64.1	78.7	16.6
MA	469	47	2	91.4	87	86.9	7.5
MD	704	70	10	86.1	64.5	87.4	6.1
ME	109	11	1	40.2	97	87.1	7.6
MI	511	51	6	74.7	81.4	87.9	8.6
MN	263	26	3	70.9	89.8	92.3	5.6
MO	473	47	5	69.4	85.4	87.9	8.6
MS	326	33	9	48.8	61.3	83	16.4
MT	365	36	3	54.1	91	91.9	9.9
NC	455	46	6	60.2	74.1	80.9	10.7
ND	78	8	2	55.9	92.4	89.5	8.4
NE	289	29	3	69.8	92.1	91.3	8.2
NH	149	15	1	59.3	96.2	90.8	5.1
NJ	366	37	5	94.4	76.9	87.6	6.6
NM	665	66	6	75	84.7	82.9	14.8
NV	614	61	9	91.5	82.5	86.3	8.7
NY	465	46	5	87.5	73.9	85.4	10.7
OH	333	33	5	77.4	85.2	88.1	9.4
OK	506	51	6	65.3	78.6	85.2	12.4
OR	296	30	2	78.7	90.9	87.4	9.7
PA	398	40	5	77.1	86.2	86.5	8.2
RI	286	29	2	90.9	89	81.1	8.2
SC	794	79	7	60.5	68.3	83.6	11.3
SD	173	17	1	51.9	88.7	87.5	7.2
TN	688	69	7	63.6	80.7	82.9	10.6
TX	553	55	6	82.5	83.3	78.3	13.1
UT	249	25	3	88.2	93.8	91	7.6
VA	276	28	6	73	73.8	88.4	6.6
VT	110	11	2	38.2	96.9	90.8	6.4
WA	347	35	3	82	85.3	89.7	7.9
WI	221	22	3	68.3	90.2	88.8	7.2
WV	258	26	4	46.1	95.2	80.9	15.5
WY	262	26	3	65.1	94.7	91.9	7.3
DC	1608	161	44	100	37.4	86.4	18.5
;

proc reg data = crime;
model VI = ME / CLM CLB;
run;


proc print data = crime;
var State VI ME;
run;