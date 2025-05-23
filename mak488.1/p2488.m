%mak 488.2
%Use the classical Inverse Design Method to obtain wing profiles (airfoil) which
% match the given target pressure (Cp) distributions. Moreover, compare the results to those of Project I.
%kordinat sistemini 0.0 leading adge soldan saga saatin tersi yonunde kabul ediyoruz
%panels are placed on chords 
%two dimension 
%vnormal = 0
%sadece sokldaki x degelerini kullanicam y deki cpleri nasil kullanacagimi
%bilmiyorum 
chordLength = 1.0; % Kanat şeridinin uzunluğu
numPanels = 60*2; % Panel sayısı
panelmedium = 0.5;
kalinlik = 0.15;

targetCp = [ 
  0.99838      0.19565
  0.99197      0.13227
  0.97938      0.08893
  0.96091      0.09352
  0.93683      0.10416
  0.90744      0.11465
  0.87309      0.12271
  0.83422      0.13155
  0.79133      0.13987
  0.74496      0.14885
  0.69568      0.15706
  0.64411      0.16503
  0.59086      0.17347
  0.53661      0.18260
  0.48201      0.19360
  0.42771      0.20447
  0.37439      0.21692
  0.32268      0.23033
  0.27321      0.24586
  0.22653      0.26400
  0.18320      0.28690
  0.14369      0.31664
  0.10842      0.35825
  0.07775      0.41769
  0.05197      0.50609
  0.03127      0.64101
  0.01577      0.83707
  0.00556      0.99915
  0.00094     -0.26415
  0.00201     -1.78409
  0.00801     -1.66096
  0.01834     -1.56604
  0.03293     -1.46618
  0.05173     -1.37128
  0.07459     -1.28759
  0.10136     -1.21519
  0.13177     -1.15106
  0.16555     -1.09454
  0.20236     -1.04570
  0.24184     -1.00187
  0.28358     -0.96206
  0.32715     -0.91601
  0.37225     -0.85237
  0.41867     -0.77382
  0.46615     -0.68257
  0.51442     -0.58442
  0.56317     -0.47874
  0.61207     -0.37861
  0.66063     -0.29253
  0.70820     -0.21535
  0.75412     -0.14742
  0.79775     -0.08515
  0.83849     -0.03017
  0.87574      0.01978
  0.90895      0.06533
  0.93760      0.11258
  0.96126      0.16083
  0.97953      0.20842
  0.99202      0.20806
  0.99839      0.19565]; % List of target Cp values at each panel location

%%simpson simple integration to get fi
myfi = 1:60;
for i = 1:60
   a = 0;         % Lower bound of the interval
    b =1/60 ;      % Upper bound of the interval
    n = 2;         % Number of subintervals
    
    f = @(x) targetCp(i)/2 ;  % Define the function you want to integrate
   
    integral = simpson_rulefunc(f, a, b, n);
    myfi(i)= integral ;
end


for j = 1:length(myfi)
    disp(myfi(j));
end

r=kalinlik;
%for influence coefficient green formula geometriye bagli olarak 
g =  -1 / (2 * pi) * log(0.15)

% tum r leri olarak kalinligida esdeger alicam 
influcoef = 1:60;

for k= 1:60
influcoef(k)=g;
   
end

%denklem sisteminden unknownstreght matrisini bulma inverse matris ile 

A = influcoef; % m x n boyutlarında A matrisi
b = myfi; % m boyutunda b vektörü
y = pinv(A).* b'; %  en küçük kareler yöntemini 
disp("Çözüm:");
disp(x);

for l = 1:60
  
    
    f= @(x) y(l)/2 ;  % Define the function you want to integrate
   
    integral = simpson_rulefunc(f, a, b, n);
    y= integral ;
end

disp("Y DEGERLERI ");
 disp(y);

% Veriyi grafik üzerinde çiz

z=1:60;
% Grafik özelliklerini ayarla (isteğe bağlı)
xlabel('x cordinates'); % x ekseni etiketi
ylabel('y cordinates '); % y ekseni etiketi
title('airfoil shape '); % Grafik başlığı
plot(z,y)

%superposition of symetric airfol and camberline 
%to get cambered airfoil here is the y camberline cordinates 
%cp upper ve lower degerlerinin ne oldugunu cikartamadim o nedenle symetric
%kaldi airfoil 
%ayrica iyi de bi deger vermedi 









