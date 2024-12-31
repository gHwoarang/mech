% Gerçek Turbofan Çevrimi Hesaplaması - MATLAB

% Giriş Değerleri
T1 = 300;         % Giriş sıcaklık (K)
P1 = 100;         % Giriş basıncı (kPa)
P2 = 500;         % Kompresör çıkış basıncı (kPa)
T3 = 1400;        % Yanma odası sıcaklığı (K)
T4 = 900;         % Türbin çıkış sıcaklığı (K)
T4s = 800;        % İzentropik türbin çıkış sıcaklığı (K)
eta_c = 0.85;     % Kompresör verimliliği
eta_t = 0.85;     % Türbin verimliliği
bypass_ratio = 5; % Fan bypass oranı

% Gazın Özellikleri (hava için)
gamma = 1.4;      % Gazın özgül ısı oranı
R = 287;          % Gaz sabiti (J/kg-K)
cp = R / (gamma - 1);  % Gazın özgül ısı (J/kg-K)

% Fan ve Kompresör Çıkış Sıcaklıkları
T2f = T1 + (T1 * bypass_ratio * (P2/P1)^((gamma-1)/gamma) - T1) / eta_c;
T2 = T1 + (T2f - T1) / eta_c;

% Yanma Odası Çıkış Sıcaklığı
T3s = T2 * (P2/P1)^((gamma-1)/gamma);
T3 = T2 + (T3s - T2) * eta_c;

% Türbin Çıkış Sıcaklığı
T5 = T4 + (T3 - T4) * eta_t;

% Çevrim Performansı Hesaplamaları
Q_in = cp * (T3 - T2);                % Yanma odasına verilen ısı (Joule)
W_comp = cp * (T2 - T1);              % Kompresör tarafından yapılan iş (Joule)
W_fan = cp * (T2f - T1);              % Fan tarafından yapılan iş (Joule)
W_turb = cp * (T3 - T5);              % Türbin tarafından yapılan iş (Joule)
eta_cycle = (W_turb + W_fan - W_comp) / Q_in;  % Çevrim verimliliği

% Sonuçları Yazdırma
disp(['Çevrim Verimliliği: ', num2str(eta_cycle)]);