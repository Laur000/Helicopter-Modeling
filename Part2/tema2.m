clear
clc
P_tan=date_indiv(165)

omeg = logspace(-2 ,2 ,1000)' ;  %vector de pulastii

%1a

 nyquist(P_tan , omeg) ;
 inters1 = evalfr(P_tan , 0) ;
 
 %1b
 
 inters2 = -0.1502 ;
 
 %1.c)
nyquist(2*P_tan, omeg);
inters3 = -0.3004;

%1.d)
nyquist(P_tan * exp(-1i * pi / 4), omeg);
inters4 = -0.2192;
hold on;
nyquist(P_tan, omeg);
hold off;
%1e
nyquist(P_tan * tf(1,[1, 0]), omeg);
asimpt = -0.0949;


%---------------------------------------------------
%2C_1
K_1 = 100 * P_tan.den{1}(4) / P_tan.num{1}(4) ;
T_1 = 300;
C_1 = tf(K_1, [T_1, 1]);

nyquist(P_tan * C_1, omeg);     %Intersecteaza in -0.429
hold on;
nyquist(P_tan, omeg);
hold off;

%2.C_2    C_2 = Compensator de faza
K_2 = 100 * P_tan.den{1}(4) / P_tan.num{1}(4) ;
T_2 = 1000;  %Polul e instabil  !  -20
C_2 = K_2 * tf([1 1], [T_2 1]); %intersecteaza in -0.24
nyquist(P_tan * C_2, omeg);
hold on;
nyquist(P_tan, omeg);
nyquist(tf([-1 1], [1 1]), omeg);
hold off;
%3
bode(P_tan, omeg);
amp1 = 7* abs(evalfr(P_tan,1i));
def1 = 45 + rad2deg(atan(imag(evalfr(P_tan,1i))  / real(evalfr(P_tan,1i))));



amp2 = 7 * abs(evalfr(P_tan * 3,1i));
def2 = rad2deg(atan(imag(evalfr(P_tan * 3,1i))  / real(evalfr(P_tan * 3,1i)))) + 45;

amp3 = 7 * abs(evalfr(P_tan * exp(-1i*pi/6),1i));
def3 = rad2deg(atan( imag( evalfr(P_tan * exp(-1i*pi/6) , 1i) )  / real( evalfr(P_tan * exp(-1i*pi/6) , 1i) ) )) + 45;

[mag4, faza4] = bode(P_tan * 100, omeg);
val1 = min(abs(mag4(:)-1));
idx1 = 0;
for i=1:length(mag4)
    if val1 == abs(mag4(i)-1)
        idx1 = i;
    end
end
omeg_1 = omeg(idx1);

val2 = min(abs(faza4(:)+180));
idx2 = 0;
for i=1:length(faza4)
    if val2 == abs(faza4(i)+180)
        idx2 = i;
    end
end
omeg_2 = omeg(idx2);


%4.C_3
K_3 = 100 * P_tan.den{1}(4) / P_tan.num{1}(4);
w_3 = 1/5;
C_3 = tf(K_3 * w_3, [1 w_3]);
bode(P_tan * C_3, omeg);

%4.C_4
A_4 = 1;
B_4 = omeg_2^2;
C_4 = 100 * tf(B_4 * [1 A_4], A_4 * [1 B_4]);
bode(P_tan * C_4, omeg); 

save('Bagiu_Laurentiu-Ionut_324AB_tema2.mat', 'inters1', 'inters2', ...
'inters3', 'inters4', 'asimpt', 'K_1', 'T_1', 'K_2', 'T_2', ...
'amp1', 'def1', 'amp2', 'def2', 'amp3', 'def3', 'omeg_1', ...
'omeg_2', 'K_3', 'w_3', 'A_4', 'B_4');