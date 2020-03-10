clear
clc
P_tan=date_indiv(165)
%1
H=zeros(4);
H(1,1)=P_tan.den{1}(2);
H(1,2)=P_tan.den{1}(4);
H(2,1)=P_tan.den{1}(1);
H(2,2)=P_tan.den{1}(3);

H(3,2)=P_tan.den{1}(2);
H(3,3)=P_tan.den{1}(4);
H(4,2)=P_tan.den{1}(1);
H(4,3)=P_tan.den{1}(3);
H

det1=det(H(1,1));
det2=det(H(1:2,1:2));
det3=det(H(1:3,1:3));
numitor=P_tan.den{1};
poli=roots(numitor);

%2
t=(0:0.01:180)';
h_pondere=impulse(P_tan,t);
rasp_trp=step(P_tan,t);
trp=double(t>=0);
rasp_conv=conv(trp,h_pondere)*0.01;
rasp_conv=rasp_conv(1:length(t));
norm_dif=norm(rasp_trp-rasp_conv,Inf);
%plot(t,rasp_trp,t,rasp_conv);
%3
x0=[1,1,1];
rasp_tot=lsim(ss(P_tan,'min'),trp,t,x0);
rasp_perm=trp*evalfr(P_tan,0);
rasp_tran=rasp_tot-rasp_perm;
plot(t,rasp_perm,t,rasp_tran);
rasp_libr=initial(ss(P_tan,'min'),x0,t);
rasp_fort=rasp_tot-rasp_libr;
plot(t,rasp_fort,t,rasp_trp);

%4
S=stepinfo(P_tan);
tc1=S.RiseTime;
tt1=S.SettlingTime;
tv1=S.PeakTime;
sr1=S.Overshoot;

s=tf('s');
P_aux=1/(10*s+1);
S=stepinfo(P_tan*P_aux);
tc2=S.RiseTime;
tt2=S.SettlingTime;
tv2=S.PeakTime;
sr2=S.Overshoot;

S=stepinfo(P_tan*(s+1));
tc3=S.RiseTime;
tt3=S.SettlingTime;
tv3=S.PeakTime;
sr3=S.Overshoot;
save('Bagiu_Laurentiu-Ionut_324AB_tema1.mat','H', 'det1', 'det2',...
'det3', 'poli', 'h_pondere', 'rasp_trp', 'rasp_conv',...
'norm_dif', 'rasp_tot', 'rasp_perm', 'rasp_tran',...
'rasp_libr', 'rasp_fort', 'tc1', 'tt1', 'tv1', 'sr1',...
'tc2', 'tt2', 'tv2', 'sr2', 'tc3', 'tt3', 'tv3', 'sr3');

