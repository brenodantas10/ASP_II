clear;clc;
Tipo={'Slack';'Carga';'V_Ctrl'};
V_Sl=0.5*exp(1i*pi/4);
S_C=1*exp(1i*pi/4);
P_Vc=1;
V_Vc=1;

bar_slack=Barramento(Tipo{1},1,1,V_Sl);
bar_carga=Barramento(Tipo{2},1,1,S_C,1.5*S_C);
bar_V=Barramento(Tipo{3},1,1,P_Vc,V_Vc);

clear Tipo V_Sl S_C P_Vc V_Vc;

%Teste as funções V_Write e S_Write para todos os Barramentos