% Airfoil design 

% Giriş Parametreleri
targetCp = [
  0.99197      0.14541
  0.97938      0.11461
  0.96091      0.10240
  0.93683      0.09557
  0.90744      0.09137
  0.87309      0.08698
  0.83422      0.08260
  0.79133      0.07751
  0.74496      0.07210
  0.69568      0.06571
  0.64411      0.05816
  0.59086      0.04948
  0.53661      0.03986
  0.48201      0.02985
  0.42771      0.01846
  0.37439      0.00556
  0.32268     -0.00901
  0.27321     -0.02585
  0.22653     -0.04540
  0.18320     -0.06822
  0.14369     -0.09492
  0.10842     -0.12588
  0.07775     -0.16089
  0.05197     -0.19964
  0.03127     -0.23722
  0.01577     -0.25930
  0.00556     -0.20739
  0.00094      0.60108
  0.00201      0.87962
  0.00801      0.44587
  0.01834      0.10292
  0.03293     -0.12226
  0.05173     -0.26607
  0.07459     -0.36091
  0.10136     -0.42546
  0.13177     -0.47011
  0.16555     -0.50110
  0.20236     -0.52387
  0.24184     -0.54071
  0.28358     -0.55258
  0.32715     -0.55573
  0.37225     -0.54109
  0.41867     -0.50790
  0.46615     -0.45960
  0.51442     -0.40028
  0.56317     -0.33183
  0.61207     -0.26196
  0.66063     -0.19983
  0.70820     -0.14486
  0.75412     -0.09604
  0.79775     -0.05168
  0.83849     -0.01195
  0.87574      0.02398
  0.90895      0.05689
  0.93760      0.08972
  0.96126      0.12277
  0.97953      0.15589
  0.99202      0.17010
  0.99839      0.18330
  0.99838      0.18330 ]; % Hedef basınç katsayıları

chordLength = 1.0; % Kanat şeridinin uzunluğu
numPanels = 100; % Panel sayısı


% Başlangıç tahmini profili oluştur%ilk olarak cember olarak modelledim 
xcenter=0.5;
y=0;
r=0.5;
th = 0:pi/50:2*pi;
xInit = r * cos(th) + x;
yInit = r * sin(th) + y;
initialGuess = [xInit; yInit];

% ilk profil görüntüle
figure;
plot(xInit,yInit, 'b-');
axis equal;
grid on;
xlabel('x1');
ylabel('y2');
title('ilk profil');


% Optimizasyon seçenekleri
options = optimset('Display', 'iter', 'MaxIter', 1000);

% Optimizasyon fonksiyonunu çağır

[xOpt,~] = fmincon(@ObjectiveFunction,(initialGuess), [], [], [], [], [], [], @Constraints, options);

% Optimizasyon sonucunda elde edilen profili ayır
xOptimized = xOpt(1:numPanels+1);
yOptimized = xOpt(numPanels+2:end);

% Sonuçları görüntüle
figure;
plot(xOptimized, yOptimized, 'b-');
axis equal;
grid on;
xlabel('x');
ylabel('y');
title('Optimize Edilmiş Airfoil Profili');

% Optimizasyon amacı fonksiyon
function obj = ObjectiveFunction(x)
    xAirfoil = x(1:end/2);
    yAirfoil = x(end/2+1:end);
    cp = panel(xAirfoil, yAirfoil);
    
    % norm alma
    error = cp - targetCp;
    p=2;%norm level 
   obj= sum(error.^p).^(1/p);
end

% Optimizasyon kısıt fonksiyonu
function [c, ceq] = Constraints(x)
    % Profil ucunda kısıtlamaları uygula (başlangıç ve bitiş noktaları sabit olsun)
    xAirfoil = x(1:end/2);
    yAirfoil = x(end/2+1:end);
    c = [xAirfoil(1); yAirfoil(1); xAirfoil(end) - 1; yAirfoil(end)];
    ceq = []; %herhangi bi denklik kistlamasi yok  
end

%hocanin attigi panel kod
function [cp]= panel()
%Smith-Hess Panel Method for single
%element lifting airfoil in 2-d
%incompressible flow.

	%This takes user input on the number of nodes to use on the
	%upper and lower surface and the 4 digit NACA number.
   clf
   writetofile=0;
   hold off
	NUpper=input('\nEnter the number of upper points.\n?');
	NLower=input('\nEnter the number of lower points.\n?');
	Naca=input('\nType in NACA airfoil number.\n?');

	if input('\nWould you like to print the information to a file?(y,n)\n?','s')=='y'
		filename=input('Enter a file name.\n?','s');
		filename=strcat(filename,'.dat');
		fid=fopen(filename,'w');
   	writetofile=1;
   end

	[x,y]=Body(NUpper,NLower,Naca);
	disp('    Shape of body.');
	disp('    x      y');
	disp([x,y])
   subplot(2,2,1),plot(x,y,'b-',x,y,'ro');
   subplot(2,2,1),axis([-.5,1.5,-.5,.5]);
   subplot(2,2,1),title('Shape of Airfoil');
   subplot(2,2,1),xlabel('x/c');
   subplot(2,2,1),ylabel('y/c');
   subplot(2,2,4),hold on
   if writetofile
      fprintf(fid,'    Shape of body\n');
		fprintf(fid,'     x            y\n');
		fprintf(fid,' ---------    --------\n');
      for i=1:length(x)
	   	fprintf(fid,'%9.5f    %9.5f\n',x(i),y(i));
      end
   end
   
   alpha=input('\nEnter an angle of attack between -90 and 90 degrees.\n?');
   while alpha<=90 & alpha>=-90
		[xmid,Cp,Cl,Cm,Cd]=FindPandC(x,y,alpha*pi/180);
      disp('    Pressure Distribution');
   	disp('    x      Cp');
   	disp([xmid Cp]);
   	disp(['    Cl =',num2str(Cl)]);
   	disp(['    Cd =',num2str(Cd)]);
      disp(['    Cm =',num2str(Cm)]);
	   if writetofile
      	fprintf(fid,'\n\nAngle of Attack  =  %9.3f\n',alpha);
      	fprintf(fid,'\nPressure Distribution\n');
			fprintf(fid,'     x           Cp\n');
			fprintf(fid,' ---------    --------\n');
      	for i=1:length(xmid)
	   		fprintf(fid,'%9.5f    %9.5f\n',xmid(i),Cp(i));
      	end
   		fprintf(fid,'Cl = %9.5f\n',Cl);
   		fprintf(fid,'Cd = %9.5f\n',Cd);
   		fprintf(fid,'Cm = %9.5f\n',Cm);
   	end
      subplot(2,2,3),plot([xmid;xmid(1)],-[Cp;Cp(1)],'b-',[xmid;xmid(1)],-[Cp;Cp(1)],'ro');
      subplot(2,2,3),title('Pressures');
      subplot(2,2,3),xlabel('x/c');
      subplot(2,2,3),ylabel('-Cp');
      subplot(2,2,4),plot(alpha,Cl,'bd');
      subplot(2,2,4),plot(alpha,Cd,'rx');
      subplot(2,2,4),plot(alpha,Cm,'g*');
	   subplot(2,2,4),title('Force and Moment Coefficients');
	   subplot(2,2,4),xlabel('Angle of Attack(degrees)');
   	subplot(2,2,4),ylabel('Cl,Cd,Cm');
	   alpha=input('\nEnter another angle of attack.\nIf you are done type in 91.\n?');
   end
   if writetofile 	
	   fclose(fid);
		disp(['Created filename',blanks(1),filename]);
   end
   
%********************************************************** 
Series=4;
	XUpper=zeros(NumU,1);
   CamberUpper=XUpper;
   dCamdxUpper=XUpper;
   BetaUpper=XUpper;
	XLower=zeros(NumL,1);
	CamberLower=XLower;
   dCamdxLower=XLower;
   BetaLower=XLower;
MaxCamber=floor(Naca/1000);
	PtMaxCamber=floor(Naca/100)-MaxCamber*10;
	MaxThickness=Naca-MaxCamber*1000-PtMaxCamber*100;
	MaxCamber=MaxCamber*.01;
	PtMaxCamber=PtMaxCamber*.1;
	MaxThickness=MaxThickness*.01
function [x,y]=Body(NumU,NumL,Naca)
	%Initialize variables
	
   
	%Convert NACA 4 digit to fraction of chord values.
	;
	if MaxCamber>=10
		PtMaxCamber=0.2025;
		MaxCamber=2.6595*PtMaxCamber^3;
		Series=5;
	end

	%Find the x and y coordinates of the airfoil.
	for i=1:NumU
		XUpper(i)=.5*(1-cos(pi*(i-1)/NumU));
	end
	for i=1:NumL
		XLower(i)=.5*(1+cos(pi*(i-1)/NumL));
    end
end

   %Evaluate thickness and camber
	%for naca 4- or 5-digit airfoil
	ThickUpper=5*MaxThickness*(.2969*sqrt(XUpper)-XUpper.*(.126+XUpper.*(.35372-XUpper.*(.2843-XUpper*.1015))));
	ThickLower=5*MaxThickness*(.2969*sqrt(XLower)-XLower.*(.126+XLower.*(.35372-XLower.*(.2843-XLower*.1015))));
	if Series==4
		for i=1:NumU
			if XUpper(i)<PtMaxCamber
				CamberUpper(i)=(MaxCamber/PtMaxCamber^2)*(2*PtMaxCamber-XUpper(i))*XUpper(i);
				dCamdxUpper(i)=(2*MaxCamber/PtMaxCamber^2)*(PtMaxCamber-XUpper(i));
			else
				CamberUpper(i)=(MaxCamber/(1-PtMaxCamber)^2)*(1+XUpper(i)-2*PtMaxCamber)*(1-XUpper(i));
				dCamdxUpper(i)=(2*MaxCamber/(1-PtMaxCamber)^2)*(PtMaxCamber-XUpper(i));
			end
			BetaUpper=atan(dCamdxUpper);
		end
		for i=1:NumL
			if XLower(i)<PtMaxCamber
				CamberLower(i)=(MaxCamber/PtMaxCamber^2)*(2*PtMaxCamber-XLower(i))*XLower(i);
				dCamdxLower(i)=(2*MaxCamber/PtMaxCamber^2)*(PtMaxCamber-XLower(i));
			else
				CamberLower(i)=(MaxCamber/(1-PtMaxCamber)^2)*(1+XLower(i)-2*PtMaxCamber)*(1-XLower(i));
				dCamdxLower(i)=(2*MaxCamber/(1-PtMaxCamber)^2)*(PtMaxCamber-XLower(i));
			end
			BetaLower=atan(dCamdxLower);
		end
	else
		for i=1:NumU
         if XUpper(i)<PtMaxCamber
				W=XUpper(i)/PtMaxCamber;
				CamberUpper(i)=MaxCamber*W*((W-3)*W+3-PtMaxCamber);
				dCamdxUpper(i)=MaxCamber*3*W*(1-W)/PtMaxCamber;
			else
				CamberUpper(i)=MaxCamber*(1-XUpper(i));
				dCamdxUpper(i)=-MaxCamber;
			end
			BetaUpper=atan(dCamdxUpper);
		end
		for i=1:NumL
			if XLower(i)<PtMaxCamber
				W=XLower(i)/PtMaxCamber;
				CamberLower(i)=MaxCamber*W*((W-3)*W+3-PtMaxCamber);
				dCamdxLower(i)=MaxCamber*3*W*(1-W)/PtMaxCamber;
			else
				CamberLower(i)=MaxCamber*(1-XLower(i));
				dCamdxLower(i)=-MaxCamber;
			end
			BetaLower=atan(dCamdxLower);
		end
   end
   x=XLower+ThickLower.*sin(BetaLower);
   y=CamberLower-ThickLower.*cos(BetaLower);
   x=[x;XUpper-ThickUpper.*sin(BetaUpper);x(1)];
   y=[y;CamberUpper+ThickUpper.*cos(BetaUpper);y(1)];
end
   
   
%********************************************************** 
function [xmid,Cp,Cl,Cm,Cd]=FindPandC(x,y,alpha)
	%This function finds a coefficient matrix using the information
   %given by the x and y coordinates of the body shape., and finds
   %the solution matrix.  It then uses that to find the pressures
   %along the surface and the lift,moment,drag coefficients.
   %Input  x     - x values of contour
   %       y     - y values of contour
   %       alpha - angle of attack
   %Output sol   - solution to A*sol=b
   
   %Initialize
   nodetotal=length(x);
   A=zeros(nodetotal);
   b=zeros(nodetotal,1);
   c=A;
   
   %Set variables for the use of making the coefficient matrix.
   dx=x(2:nodetotal)-x(1:nodetotal-1);
   dy=y(2:nodetotal)-y(1:nodetotal-1);
   sintheta=dy./sqrt(dx.*dx+dy.*dy);
   costheta=dx./sqrt(dx.*dx+dy.*dy);
   xmid=(x(1:nodetotal-1)+x(2:nodetotal))/2;
   ymid=(y(1:nodetotal-1)+y(2:nodetotal))/2;
   
   dxj=xmid-x(1:nodetotal-1);
   dxjp=xmid-x(2:nodetotal);
   dyj=ymid-y(1:nodetotal-1);
   dyjp=ymid-y(2:nodetotal);
   flog=.5*log((dxjp.*dxjp+dyjp.*dyjp)./(dxj.*dxj+dyj.*dyj));
   ftan=atan2(dyjp.*dxj-dxjp.*dyj,dxjp.*dxj+dyjp.*dyj);
   
   %Create A matrix
   for i=1:nodetotal-1
      for j=1:nodetotal-1
      	flog=0;
      	ftan=pi;
      	if j~=i
		    dxj=xmid(i)-x(j);
		    dxjp=xmid(i)-x(j+1);
		    dyj=ymid(i)-y(j);
		    dyjp=ymid(i)-y(j+1);
		    flog=.5*log((dxjp*dxjp+dyjp*dyjp)/(dxj*dxj+dyj*dyj));
      		ftan=atan2(dyjp*dxj-dxjp*dyj,dxjp*dxj+dyjp*dyj);
      	end
      	ctimtj=costheta(i)*costheta(j)+sintheta(i)*sintheta(j);
      	stimtj=sintheta(i)*costheta(j)-sintheta(j)*costheta(i);
      	A(i,j)=(.5/pi)*(ftan*ctimtj+flog*stimtj);
      	c(i,j)=(.5/pi)*(flog*ctimtj-ftan*stimtj);
         A(i,nodetotal)=A(i,nodetotal)+c(i,j);
      	if i==1 || i==nodetotal-1
			%If ith panel touches trailing edge, add contribution
			%to kutta condition
	      	A(nodetotal,j)=A(nodetotal,j)-c(i,j);
   	   	    A(nodetotal,nodetotal)=A(nodetotal,nodetotal)+A(i,j);
        end
   	  end
		%Fill in known sides
		b(i)=sintheta(i)*cos(alpha)-costheta(i)*sin(alpha);
   end
   b(nodetotal)=-(costheta(1)+costheta(nodetotal-1))*cos(alpha)-(sintheta(1)+sintheta(nodetotal-1))*sin(alpha);
   sol=A\b;
   
	%Use solution to find Pressures along airfoil
	Cp=zeros(nodetotal-1,1);
	for i=1:nodetotal-1
		vtang=cos(alpha)*costheta(i)+sin(alpha)*sintheta(i);
		for j=1:nodetotal-1
         vtang=vtang-c(i,j)*sol(j)+sol(nodetotal)*A(i,j);
		end
		Cp(i)=1-vtang^2;
	end
   
   %
   Cfx=Cp'*dy;
   Cfy=-Cp'*dx;
   Cm=Cp'*(dx.*xmid+dy.*ymid);
   Cd=Cfx*cos(alpha)+Cfy*sin(alpha);
   Cl=Cfy*cos(alpha)-Cfx*sin(alpha);

end