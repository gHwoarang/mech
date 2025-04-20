j=0.01
Kb=0.01
Kf=0.1
Km=0.01
L=0.5
R=1




Amotor= [-Kf/j Km/j ; -Kb/L -R/L];
Bmotor= [0;1/L];
Cmotor= [1,0];
Dmotor=[0];
motor= ss(Amotor,Bmotor,Cmotor,Dmotor,'InputName','v','OutputName','y','StateName',{'w','i'})

