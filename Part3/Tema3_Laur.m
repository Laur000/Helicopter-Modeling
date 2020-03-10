clc ;
clear all;
[~, P_gir] = date_indiv(165);


%1

a1 = 3 ;
Q1 = tf(0) ;
[X1, Y1, N1, M1] = eucl_Youla(P_gir.num{1}, P_gir.den{1}, a1);
C1 = (X1 + M1 * Q1) / (Y1 - N1 * Q1);
C1 = tf(ss(C1, 'min'));

este_stabil_1 = 1 + evalfr(P_gir * C1, inf); %Diferit de 0 => intern stabil

T1 = (P_gir * C1) / (1 + P_gir * C1);
T1 = tf(ss(T1, 'min'));
%stepinfo(T1)
%RiseTime: 0.6746
%SettlingTime: 4.1470

%2

a2 = 5 ;

[X2, Y2, N2, M2] = eucl_Youla(P_gir.num{1}, P_gir.den{1}, a2);
Q2 = tf(70) + tf(evalfr(Y2, 0) / evalfr(N2, 0) - 70, [1 1]);
%Y(0) - N(0)Q(0) = 0    => Pol in 0
%Adaugam lui Q2 un pol pentru scadere suprareglaj
C2 = (X2 + M2 * Q2) / (Y2 - N2 * Q2);
C2 = tf(ss(C2, 'min'));
este_stabil_2 = 1 + evalfr(P_gir * C2, inf);  %Diferit de 0 => intern stabil

T2 = (P_gir * C2) / (1 + P_gir * C2);
T2 = tf(ss(T2, 'min'));
%stepinfo(T2)
%indeplineste a , b si c
%RiseTime: 0.2519
  %  SettlingTime: 3.1395
  %Overshoot: 46.3474
  
  
  %3
  
  a3 = 3;
[X3, Y3, N3, M3] = eucl_Youla(P_gir.num{1}, P_gir.den{1}, a3);
Q3 = tf(0);
C3 = (X3 + M3 * Q3) / (Y3 - N3 * Q3);
C3 = tf(ss(C3, 'min'));
este_stabil_3 = 1 + evalfr(P_gir * C3, inf);  %Diferit de 0 => intern stabil
%margin(P_gir * C3);

T3 = (P_gir * C3) / (1 + P_gir * C3);
T3 = tf(ss(T3, 'min'));

%stepinfo(T3)
%RiseTime: 0.6746
 %SettlingTime: 4.1470
 %Margine de faza 43deg
 %Margine de amplificare 9.24
 %margin(P_gir *C3)

%4


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

%RiseTime: 0.4664
%SettlingTime: 3.3027
%Overshoot: 39.7579
%Margine de faza 39.8deg
%Margine de amplificare 8.9
%margin(P_gir *C4)
save('Bagiu_Laurentiu-Ionut_324AB_tema3.mat', 'a1', 'Q1', ...
    'a2', 'Q2', 'a3', 'Q3', 'a4', 'Q4');





