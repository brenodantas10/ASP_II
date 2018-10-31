clear;clc;
%Teste Sistema (Rodar Teste Linhas Primeiro)
%Criando Linhas
Teste_Linhas;

% Linha_Linnet.Change_R(3.386000000000000e-05);
% Linha_Linnet.Change_L(5.856643775837285e-07);
% 
% Linha_Tulip.Change_R(4.212500000000000e-05);
% Linha_Tulip.Change_L(4.204969628467665e-07);
% 
% Linha_Daisy.Change_R(7.080000000000000e-05);
% Linha_Daisy.Change_L(5.787439236049622e-07);



%Criando Barramentos
Bar{1}=Barramento('Slack','YA',1,1,230e3);
Bar{2}=Barramento('Carga','YA',1,1,0);
Bar{3}=Barramento('Carga','YA',1,1,0);
Bar{4}=Barramento('Carga','YA',1,1,0);
Bar{5}=Barramento('Carga','YA',1,1,0);
Bar{6}=Barramento('Carga','YA',1,1,0);
Bar{7}=Barramento('Carga','YA',1,1,0);
Bar{8}=Barramento('Carga','YA',1,1,0);
Bar{9}=Barramento('Carga','YA',1,1,0);
Bar{10}=Barramento('Carga','YA',1,1,0);
Bar{11}=Barramento('Carga','YA',1,1,0);

Bar{12}=Barramento('Carga','YA',1,1,(12+8.5i)*1e6);
Bar{13}=Barramento('Carga','YA',1,1,(10+3.5i)*1e6);
Bar{14}=Barramento('Carga','YA',1,1,(13+7.5i)*1e6);

Bar{15}=Barramento('Carga','YA',1,1,(19+7.5i)*1e6);
Bar{16}=Barramento('Carga','YA',1,1,(18+15.5i)*1e6);
Bar{17}=Barramento('Carga','YA',1,1,(14.5+12.5i)*1e6);
Bar{18}=Barramento('Carga','YA',1,1,(18+15i)*1e6);

Bar{19}=Barramento('V_Ctrl','Y',1,1,20e6,13.8e3);
Bar{20}=Barramento('V_Ctrl_Cap','YA',1,1,18e6i,13.8e3);
Bar{21}=Barramento('V_Ctrl','Y',1,1,30e6,13.8e3);

%Criando a Classe Sistema
Sistema=Sistema_Transmissao(100e6);

%Adicionando Barramentos ao Sistema
for i=1:numel(Bar)
    Sistema.Add_Bar(Bar{i});
end
clear Bar i;

%Adicionando Linhas
Sistema.Add_Linha(Linha_Linnet.Change_l(25e3),1,2);
Sistema.Add_Linha(Linha_Linnet.Change_l(25e3),1,2);

Sistema.Add_Linha(Transformador(50e6,230e3,'YA',69e3,'D',0.055,0.075),2,3);
Sistema.Add_Linha(Transformador(50e6,230e3,'YA',69e3,'D',0.055,0.075),2,4);
Sistema.Add_Linha(Transformador(50e6,230e3,'YA',69e3,'D',0.055,0.075),2,4);

Sistema.Add_Linha(Chave(),3,4);

Sistema.Add_Linha(Linha_Tulip.Change_l(5e3),3,5);
Sistema.Add_Linha(Linha_Tulip.Change_l(23e3),3,6);
Sistema.Add_Linha(Linha_Tulip.Change_l(17e3),3,7);

Sistema.Add_Linha(Linha_Daisy.Change_l(12e3),4,8);
Sistema.Add_Linha(Linha_Daisy.Change_l(12e3),4,9);
Sistema.Add_Linha(Linha_Daisy.Change_l(5.5e3),4,10);
Sistema.Add_Linha(Linha_Daisy.Change_l(3.5e3),4,11);

Sistema.Add_Linha(Transformador(15e6,69e3,'YA',13.8e3,'D',0.085,0.12),5,12);
Sistema.Add_Linha(Transformador(15e6,69e3,'YA',13.8e3,'D',0.085,0.12),6,13);
Sistema.Add_Linha(Transformador(15e6,69e3,'YA',13.8e3,'D',0.085,0.12),7,14);

Sistema.Add_Linha(Transformador(25e6,69e3,'YA',13.8e3,'D',0.065,0.0845),8,15);
Sistema.Add_Linha(Transformador(25e6,69e3,'YA',13.8e3,'D',0.065,0.0845),9,16);
Sistema.Add_Linha(Transformador(25e6,69e3,'YA',13.8e3,'D',0.065,0.0845),10,17);
Sistema.Add_Linha(Transformador(25e6,69e3,'YA',13.8e3,'D',0.065,0.0845),11,18);

Sistema.Add_Linha(Chave(),15,19);
Sistema.Add_Linha(Chave(),16,20);
Sistema.Add_Linha(Chave(),18,21);

%Fechando as Chaves necessárias
Sistema.Open_Chave(1);
Sistema.Open_Chave(2);
Sistema.Close_Chave(3);
Sistema.Open_Chave(4);

%Calculando Matriz Y_Barra
Sistema.Calc_Y;

%Calculando Fluxo de Potência
[S, V, it, erro]=Sistema.Newton_Raphson;

If=Sistema.Calc_I_Curtos; %Corrigir Corrente de Falta

for i=1:numel(Sistema.Curto_Bars)
V_prov(i,:)=[abs(Sistema.Curto_Bars{i}(end).V) angle(Sistema.Curto_Bars{i}(end).V)*180/pi];
end
S_prov=[real(S) imag(S)]/1e6;

I_M=[abs(If(:,1))/1e3 angle(If(:,1))*180/pi];
I_B=[abs(If(:,2))/1e3 angle(If(:,2))*180/pi];
I_BA_B=[abs(If(:,3))/1e3 angle(If(:,3))*180/pi];
I_BA_C=[abs(If(:,4))/1e3 angle(If(:,4))*180/pi];
I_T=[abs(If(:,5))/1e3 angle(If(:,5))*180/pi];
clear i;