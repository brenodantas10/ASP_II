classdef Linha_Transmissao < handle
    %Esta classe está associada aos parâmetros e cálculos de uma linha de
    %transmissão afins de facilitar a implementação de sistemas maiores
    %
    %Objetivos desta classe
    %
    %   -Fornecer todos os parâmetros necessários de uma linha de
    %   transmissão
    %   -Criar um modo de calcular com rapidez todas as propriedades desta
    %   linha
    %   
    %   
    
    properties (SetAccess = private, GetAccess = public)
        raio =1         %Raio dos condutores
        mu_r=1          %Permeabilidade do condutor
        pho=1           %Inverso da condutividade do Condutor
        geo_fase=[0 0]  %Geometria de uma fase (informa as germinações)
        geo_linha=[0 0] %Geometria da linha (quanto as posições das fases)
        R=0             %Resistência por unidade de comprimento
        L=0             %Indutância por unidade de comprimento
        C=0             %Capacitância por unidade de comprimento
        f=60            %Frequência da rede ao qual está acoplada
        Z0=50           %Impedância intrínseca à Linha
        gamma=1         %Constante de propagação da Linha
        l=32000         %Comprimento total da Linha
        Y=zeros(2,2)    %Matriz de Admitância de transmissão
    end
    
    methods
        Calc_RLC(obj);
        Calc_Z0_gamma(obj);
        Calc_Y(obj);
        function obj        =   Linha_Transmissao(varargin)
            if nargin==1
                if isa(varargin{1},'Linha_Transmissao')
                    obj.raio=varargin{1}.raio;
                    obj.pho=varargin{1}.pho;
                    obj.mu_r=varargin{1}.mu_r;
                    obj.geo_fase=varargin{1}.geo_fase;
                    obj.geo_linha=varargin{1}.geo_linha;
                    obj.R=varargin{1}.R;
                    obj.L=varargin{1}.L;
                    obj.C=varargin{1}.C;
                    obj.f=varargin{1}.f;
                    obj.Z0=varargin{1}.Z0;
                    obj.gamma=varargin{1}.gamma;
                    obj.l=varargin{1}.l;
                    obj.Y=varargin{1}.Y;
                elseif size(varargin{1},1)~=2 || size(varargin{1},2)~=2
                    error('A matriz de admitância possui tamanho indevido, deve ser 2x2');
                end
                    obj.Y=varargin(1);
            elseif nargin==3
                obj.Z0=varargin{1};
                obj.gamma=varargin{2};
                obj.l=varargin{3};
                obj.Calc_Y();
            elseif nargin==5
                obj.R=varargin{1};
                obj.L=varargin{2};
                obj.C=varargin{3};
                obj.f=varargin{4};
                obj.l=varargin{5};
                obj.Calc_Z0_gamma();
                obj.Y=obj.Calc_Y();
            elseif nargin==7
                if size(varargin{4},2)~=2 || size(varargin{5},2)~=2
                    error('As posições XY ficam nas colunas');
                end
                obj.raio=varargin{1};
                obj.mu_r=varargin{2};
                obj.pho=varargin{3};
                obj.geo_fase=varargin{4};
                obj.geo_linha=varargin{5};
                obj.f=varargin{6};
                obj.l=varargin{7};
                obj.Calc_RLC();
                obj.Calc_Z0_gamma();
                obj.Calc_Y();
            end
        end
        Save_File(obj,Path_Name);
        obj = Open_File(obj,Path_File);
    end
end