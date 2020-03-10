clear
clc
P_tan=date_indiv(165)

omeg = logspace(-2 ,2 ,1000)' ;  %vector de pulastii

%1a

 nyquist(P_tan , omeg) ;
 inters1 = evalfr(P_tan , 0) ;

%1b
[re,im] = nyquist(P_tan,omeg);
re = squeeze(re);
im = squeeze(im);
for i = 2 : length(omeg)
    if sign(im(i)) ~= sign(im(i-1))
        if abs(im(i)) < abs(im(i-1))
            inters2  = re(i) ;
        else
           inters2  = re(i-1) ;
        end
    end
end

%1c

[re,im] = nyquist(P_tan*2 ,omeg);
re = squeeze(re);
im = squeeze(im);
for i = 2 : length(omeg)
    if sign(im(i)) ~= sign(im(i-1))
        if abs(im(i)) < abs(im(i-1))
            inters3  = re(i) ;
        else
           inters3 = re(i-1) ;
        end
    end
end

hold on ;
nyquist(P_tan, omeg);
hold off;


%1d

[re,im] = nyquist(P_tan * exp(-1i * pi / 4), omeg);
re = squeeze(re);
im = squeeze(im);
for i = 2 : length(omeg)
    if sign(im(i)) ~= sign(im(i-1))
        if abs(im(i)) < abs(im(i-1))
            inters4  = re(i) ;
        else
           inters4  = re(i-1) ;
        end
    end
end


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

%3a

s = tf('s') ;
U = ((sqrt(2)*s)/2 + sqrt(2)/2)/(s^2 + 1 ) 
bode(P_tan*U,omeg)
[amp,def,~] = bode(P_tan*U,omeg);

amp1 = amp(500)  ;

def1 = def(500) ;

%3b
bode(P_tan*3*U,omeg)
[amp,def,~] = bode(P_tan*3*U,omeg);

amp2 = amp(500)  ;

def2 = def(500) ;

%3c

bode(P_tan * exp(-1i * pi / 6)*U,omeg)
[amp,def,~] = bode(P_tan * exp(-1i * pi / 6)*U,omeg);

amp3 = amp(500)  ;

def3 = def(500) ;

%3d

bode(P_tan * 100, omeg) 
omeg_1 = 3.51 ;

%3e
bode(P_tan * 100, omeg) 
omeg_2 = 1.85 ;

%4C_3
K_3 = 1000;
w_3 = 1/5;
C_3 = tf(K_3 * w_3, [1 w_3]);
bode(P_tan * C_3, omeg);


%4C_4
A_4 = 1;
B_4 = omeg_2^2;
C_4 = tf(B_4 * [1 A_4], A_4 * [1 B_4]);
bode(P_tan * C_4, omeg);    %Faza este -145

save('Bagiu_Laurentiu-Ionut_324AB_tema2.mat', 'inters1', 'inters2', ...
'inters3', 'inters4', 'asimpt', 'K_1', 'T_1', 'K_2', 'T_2', ...
'amp1', 'def1', 'amp2', 'def2', 'amp3', 'def3', 'omeg_1', ...
'omeg_2', 'K_3', 'w_3', 'A_4', 'B_4');