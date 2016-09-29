data group_analysis;
set work.import;

/*sort based on No. of groups and no. of friends*/
proc sort data=group_analysis;
	by descending No__of_Friends;
run;
	
proc sort data=group_analysis;
	by descending No__of_Groups;
run;
	
/*mean of no. of groups and no.of friends*/
proc means data=group_analysis;
	var No__of_Groups No__of_Friends;
run;

/*graphical representation*/
proc sgplot data=group_analysis;
	scatter x=No__of_Friends y=No__of_Groups;
	series x=No__of_Friends y=No__of_Groups;
run;

proc sgplot data=group_analysis;
	hbox No__of_Friends / category=No__of_Groups;
run;

/*Check Correlation between No. of Groups and No. of Friends*/
proc corr data=group_analysis;
	var No__of_Groups No__of_Friends;
run;

/*summarizing data distribution of analysis variable No. of Groups*/
proc univariate data=group_analysis;
	var No__of_Groups;
run;

/*summarizing data distribution of analysis variable No. of Friends*/
proc univariate data=group_analysis;
	var No__of_Friends;
run;

/*Regression analysis : Y=No. of groups, X=No. of friends*/
proc reg data=group_analysis;
	model No__of_Groups = No__of_Friends;
run;

/*Regression analysis : Y=No. of Friends, X=No. of groups*/
proc reg data=group_analysis;
	model No__of_Friends = No__of_Groups;
run;

/*Transformation of variables with Reciprocal*/
proc reg data=group_analysis;
	model Reciprocal_Groups = Reciprocal_Friends;
run;

proc reg data=group_analysis;
	model Reciprocal_Friends = Reciprocal_Groups;
run;

/*Transformation of variables with Log*/
proc reg data=group_analysis;
	model Log_Groups = Log_Friends;
run;

proc reg data=group_analysis;
	model Log_Friends = Log_Groups;
run;

/*Transformation of variables with Sqrt*/
proc reg data=group_analysis;
	model Sqrt_Groups = Sqrt_Friends;
run;

proc reg data=group_analysis;
	model Sqrt_Friends = Sqrt_Groups;
run;

/*cluster analysis*/			
proc fastclus data=group_analysis out=clust maxclusters=10 maxiter=100 converge=0;
	var No__of_Groups No__of_Friends;
run;

/*plotting the clusters*/
proc plot;
	plot No__of_Groups*No__of_Friends=cluster;
run;

/*ANOVA Tukey Procedure*/
proc Anova data=group_analysis;
class No__of_Groups;
model No__of_Friends = No__of_Groups;
means No__of_Groups / tukey;
run;

