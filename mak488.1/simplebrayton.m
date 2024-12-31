% Brayton Çevrimi Simülasyonu - MATLAB
%Kompresör ve türbinlerin izentropik verimlilikleri (eta_c ve eta_t) sabit olarak verilmiştir.
% Giriş Değerleri
T1 = 300;      % Giriş sıcaklık (K)
P1 = 100;      % Giriş basınç (kPa)
P2 = 500;      % Kompresör çıkış basıncı (kPa)
T3 = 1400;     % Yanma odası sıcaklığı (K)
T4 = 900;      % Türbin çıkış sıcaklığı (K)
eta_c = 0.85;  % Kompresör verimliliği
eta_t = 0.85;  % Türbin verimliliği

% Kompresör Çalışma (İzentropik) - Sürekli Isentropik Süreç
T2s = T1 * (P2/P1)^((gamma-1)/gamma);

% Kompresör Çıkış Sıcaklığı (İzentropik) - Sürekli Isentropik Süreç
T2 = T1 + (T2s - T1) / eta_c;

% Yanma Odası Çıkış Sıcaklığı
T4s = T3 / (P2/P1)^((gamma-1)/gamma);

% Türbin Çıkış Sıcaklığı
T4 = T3 - (T3 - T4s) * eta_t;

% Çevrim Performansı Hesaplamaları
Q_in = cp * (T3 - T2);           % Yanma odasına verilen ısı (Joule)
W_comp = cp * (T2 - T1);         % Kompresör tarafından yapılan iş (Joule)
W_turb = cp * (T3 - T4);         % Türbin tarafından yapılan iş (Joule)
eta_cycle = (W_turb - W_comp) / Q_in;   % Çevrim verimliliği

% Sonuçları Yazdırma
disp(['Çevrim Verimliliği: ', num2str(eta_cycle)]);