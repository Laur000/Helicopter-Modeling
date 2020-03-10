clear all;
[~, P_gir] = date_indiv(147);

%1.
a1 = 3;
Q1 = tf(0);
[X1, Y1, N1, M1] = eucl_Youla(P_gir.num{1}, P_gir.den{1}, a1);
C1 = (X1 + M1 * Q1) / (Y1 - N1 * Q1);
C1 = tf(ss(C1, 'min'));
stabil1 = 1 + evalfr(P_gir * C1, inf);  %Diferit de 0 => intern stabil

T1 = (P_gir * C1) / (1 + P_gir * C1);
T1 = tf(ss(T1, 'min'));
%stepinfo(T1)
%Rise Time = 0.6958  (Timp crestere)
%Settling Time = 4.1022 (Timp tranzitoriu)

%==========================================================================

%2.
a2 = 5;
[X2, Y2, N2, M2] = eucl_Youla(P_gir.num{1}, P_gir.den{1}, a2);
%Q2 = tf(evalfr(Y2, 0) / evalfr(N2, 0) * 1/10, [1 1/10]); 
%Q2 = tf(1, [1, evalfr(N2, 0) / evalfr(Y2, 0)]); 
Q2 = tf(70) + tf(evalfr(Y2, 0) / evalfr(N2, 0) - 70, [1 1]);
%Y(0) - N(0)Q(0) = 0    => Pol in 0
%Adaugam lui Q2 un pol pentru scadere suprareglaj
C2 = (X2 + M2 * Q2) / (Y2 - N2 * Q2);
C2 = tf(ss(C2, 'min'));
stabil2 = 1 + evalfr(P_gir * C2, inf);  %Diferit de 0 => intern stabil

T2 = (P_gir * C2) / (1 + P_gir * C2);
T2 = tf(ss(T2, 'min'));
%stepinfo(T2)
%Rise Time = 0.2678  (Timp crestere)
%Settling Time = 3.1990 (Timp tranzitoriu)
%Overshoot = 45.8157    (Suprareglaj)

%==========================================================================

%3.

a3 = 3;
[X3, Y3, N3, M3] = eucl_Youla(P_gir.num{1}, P_gir.den{1}, a3);
Q3 = tf(0);
C3 = (X3 + M3 * Q3) / (Y3 - N3 * Q3);
C3 = tf(ss(C3, 'min'));
stabil3 = 1 + evalfr(P_gir * C3, inf);  %Diferit de 0 => intern stabil
%margin(P_gir * C3);

T3 = (P_gir * C3) / (1 + P_gir * C3);
T3 = tf(ss(T3, 'min'));
%stepinfo(T3)
%Rise Time = 0.6958  (Timp crestere)
%Settling Time = 4.1022 (Timp tranzitoriu)
%Margine de amplificare = 9.47dB
%Margine de faza = 44.5deg

%==========================================================================

%4.

a4 = 4;
[X4, Y4, N4, M4] = eucl_Youla(P_gir.num{1}, P_gir.den{1}, a4);
%Q4 = tf(79) + tf(evalfr(Y4, 0) / evalfr(N4, 0) - 80, [1 1]);
Q4 = tf(evalfr(Y4, 0) / evalfr(N4, 0) * 1/10, [1 1/10]);
%Y(0) - N(0)Q(0) = 0    => Pol in 0
%Adaugam lui Q un pol pentru scadere suprareglaj
C4 = (X4 + M4 * Q4) / (Y4 - N4 * Q4);
C4 = tf(ss(C4, 'min'));
stabil4 = 1 + evalfr(P_gir * C4, inf);  %Diferit de 0 => intern stabil
%margin(P_gir * C4);

T4 = (P_gir * C4) / (1 + P_gir * C4);
T4 = tf(ss(T4, 'min'));
%stepinfo(T4)
%Rise Time = 0.4649  (Timp crestere)
%Settling Time = 3.3122 (Timp tranzitoriu)
%Overshoot = 36.9703 (Suprareglaj)
%Margine de amplificare = 9.2dB
%Margine de faza = 41.1deg

%==========================================================================

save('Ciurezu_EduardClaudiu_323AB_tema3.mat', 'a1', 'Q1', ...
    'a2', 'Q2', 'a3', 'Q3', 'a4', 'Q4');
