clear; clc; %limpar a memoria para fazer os calculos

%Parâmetros da Linha
d=0.3;
raio=1e-2;
pho=1.78e-8;                    %inverso da condutãncia do condutor
D=2.1;
geo_fase=[0 0;d 0;0 -d; d -d];  %geometria da fase em metros
geo_linha=[-D 0; 0 0; D 0];     %geometria da linha em metros
mu_r=1;                         %permeabilidade do condutor

%Calculando todos os parâmetros da linha

Linha= Linha_Transmissao(raio,mu_r,pho,geo_fase,geo_linha,60,32000);

%Limpar Variáveis Desnecessárias
clear d raio pho D geo_fase geo_linha mu_r;
