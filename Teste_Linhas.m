%Calculando Parâmetros da linha CAA 336,4 (Linnet)
%
%
%IACS=5.8001e7; %valor 100% da resistividade
IACS=5.71e7;
%Alumínio 1350:
%26 unidades
al.raio=2.89e-3/2; %diametro de 2,89 mm
al.mu_r=1+22e-5;  %permeabilidade magnética
al.rho=1/(0.61*IACS); % 61% IACS
%
%
%Aço :
%7 unidades
aco.raio=2.25e-3/2;  %Diâmetro=2,25 mm
aco.mu_r=inf;%2000; %mu_r=    precisa ser mudado futuramente
aco.rho=inf;%1/(0.09*IACS);  % 9% IACS

%Criando materiais al=alumínio e aco=aço
al=Material(al.raio,al.mu_r,al.rho);
aco=Material(aco.raio,aco.mu_r,aco.rho);

%Gerando o Cabo
Cabo_Linnet=Condutor();
Cabo_Linnet.Add_Cables(aco,7,al,26);
%Gerando a Linha
d=0.25; % Metade do lado do quadrado 
geo_fase=[0 0;-d d; d d;-d -d; d -d]; % geometria de uma fase
geo_linha=[-3 0;0 0;3 0]; % geometria entre fases
Linha_Linnet=Linha_Transmissao(Cabo_Linnet,geo_fase,geo_linha,60,25e3);
clear al aco d geo_fase geo_linha;


%Gerando cabo 336,4 CA - 19f (Tulip)
al.raio=3.38e-3/2;
al.mu_r=1+22e-5;
al.rho=1/(0.61*IACS);
al=Material(al.raio,al.mu_r,al.rho);

Cabo_Tulip=Condutor();
Cabo_Tulip.Add_Cables(al,19);

d=0.25;
geo_fase=[-d d; d d;-d -d; d -d];
geo_linha=[-1.2 0; 0 0; 1.2 0];
Linha_Tulip=Linha_Transmissao(Cabo_Tulip,geo_fase,geo_linha,60,5e3);
clear al d geo_fase geo_linha;

%Gerando Cabo 266,8 CA - 7f (Daisy)
al.raio=4.96e-3/2;
al.mu_r=1+22e-5;
al.rho=1/(0.61*IACS);
al=Material(al.raio,al.mu_r,al.rho);

Cabo_Daisy=Condutor();
Cabo_Daisy.Add_Cables(al,7);

d=0.3/2;
geo_fase=[-d 0; d 0; 0 d*sqrt(3)];
geo_linha=[-1.6 0; 0 0; 0.8 0];
Linha_Daisy=Linha_Transmissao(Cabo_Daisy,geo_fase,geo_linha,60,3.5e3);
clear d geo_fase geo_linha IACS al Cabo_Daisy Cabo_Linnet Cabo_Tulip;