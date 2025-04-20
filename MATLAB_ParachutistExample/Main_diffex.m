clear all
clc
close

ff=@(x) -0.1*x^ 4-0.15*x^ 3-0.5*x^ 2-0.25*x+1.2;
df=@(x) -0.4*x^ 3-0.45*x^ 2-x-0.25; 

x=0.5;
n = 11;

diffex(ff,df,x,n)



