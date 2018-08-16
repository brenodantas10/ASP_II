classdef Sistema_Transmissao    <   handle
    %Nesta Classe estará contida toda a descrição de um sistema de
    %transmissão com todos os barramentos e conexões entre estes
    %barramentos, bem como métodos capazes de calcular as tensões e
    %potências de cada um dos barramentos.
    %
    %   M-Monofásico
    %   B-Bifásico
    %   T-Trifásico
    %   A-Aterrado
    %
    
    properties (SetAccess = private, GetAccess = public)
        S_base=1e6         %Potência Base do Sistema
        Barras={}          %Vetor contendo todos os barramentos do Sistema
        Curto_Bars={}      %Barras em curto com outras, mesma linha são os pares
        Y_Barra=[]         %Matriz de admitância entre os barramentos do sistema
        Chaves={}          %Isto será um handle lógico para abrir ou fechar chaves (1=fechada)
        Linhas={}          %Aqui está contido informações a 
        I_Falta=[]         %Correntes de falta [M B BA(B) BA(C) T]
    end
    
    methods
        function    obj     =   Sistema_Transmissao(varargin)   %TERMINAR
            if nargin==1
                if isa(varargin{1},'Sistema_Transmissao')
                    obj.S_base=varargin{1}.S_base;
                    for i=1:size(varargin{1}.Barras,2)
                        obj.Add_Bar(varargin{1}.Barras{i});
                    end
                    prov=1:numel(obj.Barras);
                    for i=1:numel(varargin{1}.Linhas)
                        Bars{1}=prov(varargin{1}.Linhas{i}.Bar{1}==[varargin{1}.Barras{:}]);
                        Bars{2}=prov(varargin{1}.Linhas{i}.Bar{2}==[varargin{1}.Barras{:}]);
                        obj.Add_Linha(varargin{1}.Linhas{i},Bars{1},Bars{2});
                    end
                elseif isa(varargin{1},'double') && numel(varargin{1}==1)
                    obj.S_base=varargin{1};
                end
            elseif nargin~=0
                error('Muitos argumentos');
            end
                
        end
        function delete(obj)
            if ~isempty(obj)
                bar_prov=[obj.Barras{:,:}];
                delete(bar_prov);
            end
        end
        Save_File(obj, Path_Name);
        obj = Open_File(Path_Nome);
        Add_Bar(obj,bar);
        Add_Linha(obj,linha,i,j);   %i e j são referentes ao numero do barramento ao qual a linha será adicionada
        Calc_Y(obj);
        result = Gauss_Seidel(obj,varargin);    %Falta implementar 
        [S_t, V, it, erro] = Newton_Raphson(obj, varargin);   %Falta implementar
        Open_Chave(obj,i);
        Close_Chave(obj,i);
        [I]=Calc_I_Curtos(obj); %Usado após calcular o fluxo de potência por um dos dois algorítmos.
    end
    
    methods     (Access = private)
        Check_Curto(obj);
        Check_Connected(obj);
        Unite_Curto_Bars(obj);              %Une as barras em curto colocando-a no fim de Curto_Bars
        Correct_V_base(obj);                %Corrige as tensões de base dos barramentos de acordo com as tensões de base do transformador
        Change_Bar_V_Base(obj,bar_ant,linha_ant) %Muda as tensões de base dos Barramentos com recorrencia
        jacob = Jacobiana ( obj, V, bool_P, bool_Q, bool_V, bool_Ang )           %Falta implementar
        Calc_S_Linhas(obj);
        [Z_0, Z_pos, Z_neg] = Calc_Z_Simetrico(obj);
    end
    
end

