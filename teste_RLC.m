clear; clc; %limpar a memoria para fazer os calculos

%Parâmetros da Linha
d=0.3;
raio=1e-2;
rho=1.78e-8;                    %inverso da condutãncia do condutor
D=2.1;
geo_fase=[0 0;d 0;0 -d; d -d];  %geometria da fase em metros
geo_linha=[-D 0; 0 0; D 0];     %geometria da linha em metros
mu_r=1;                         %permeabilidade do condutor

%Calculando Material
mat=Material(raio,mu_r,rho);
%Calculando Condutor
cond=Condutor(mat,[0 0]);
%Calulando Linha
linha=Linha_Transmissao(cond,geo_fase,geo_linha,60,32000);

%Mosrando Resistencia, Indutancia, Capacitancia
fprintf('R: %e\nL: %e\nC: %e\n\n',linha.R,linha.L,linha.C);
%Limpar Variáveis Desnecessárias
clear d raio rho D geo_fase geo_linha mu_r cond mat;