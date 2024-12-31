% Airfoil design 
%Integrate an optimization algorithm to optimize an initial wing profile (airfoil) to match the given target pressure (Cp) distributions.
%A panel code to solve the Laplace Equation together with the target Cp's are attached.
% Giriş Parametreleri
ig=[0.5 2];%initial guess for errors

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

% Optimizasyon seçenekleri
options = optimset('Display', 'iter', 'MaxIter', 1000);

% Optimizasyon fonksiyonunu çağır
xopt=fmincon(@cf,ig,[],[],[],[],[],[],[],const,[]);

%retrieving optimized cpvalues for x and and y
xopt=cpopt;airfoilim 


function [c,ceq]=const(x)
% Profil ucunda kısıtlamaları uygula (başlangıç ve bitiş noktaları sabit
% olsun)?
    c = [];
    ceq = []; %herhangi bi denklik kistlamasi yok  

end


function f = cf(x)
  % norm alma
    error = cp - targetCp;
    % norm alma
    p=2;%norm level 
   f= sum(error.^p).^(1/p);
end

