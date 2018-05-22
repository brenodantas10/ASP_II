classdef Sistema_Transmissao    <   handle
    %Nesta Classe estará contida toda a descrição de um sistema de
    %transmissão com todos os barramentos e conexões entre estes
    %barramentos, bem como métodos capazes de calcular as tensões e
    %potências de cada um dos barramentos.
    
    properties (SetAccess = private, GetAccess = public)
        S_base=1e6         %Potência Base do Sistema
        Barras={}          %Vetor contendo todos os barramentos do Sistema
        Non_Linked_Bars={} %Barras não conectadas (um vetor booleano)
        Curto_Bars={}      %Barras em curto com outras, mesma linha são os pares
        Links={}           %Conexões entre todos barramentos (Linhas, Trafos, Chaves)
        Y_Barra=[]         %Matriz de admitância entre os barramentos do sistema
        Chaves={}          %Isto será um handle lógico para abrir ou fechar chaves (1=fechada)
    end
    
    methods
        function    obj     =   Sistema_Transmissao(varargin)   %TERMINAR
            if nargin==0
                
            elseif nargin==1
                if isa(varargin{1},'Sistema_Transmissao')
                    obj.S_base=varargin{1}.S_base;
                    for i=1:size(varargin{1}.Barras,2)
                        obj.Add_Bar(varargin{1}.Barras{i});
                    end
                    
                    for i=1:size(varargin{1}.Chaves,2)
                        obj.Add_Chave(varargin{1}.Chaves{i});
                    end
                    
                    for i=1:(size(varargin{1}.Barras,2)-1)
                        for j=(i+1):size(varargin{1}.Barras,2)
                            for k=2:size(varargin{1}.Links{i,j},2)
                                obj.Add_Linha(varargin{1}.Links{i,j}{k},i,j);
                            end
                        end
                    end
                end
            end
                
        end
        function delete(obj)
            if ~isempty(obj)
                bar_prov=[obj.Barras{:,:}];
                delete(bar_prov);
                link_prov=[Links{:,:}];
                for i=1:size(link_prov,2)
                    delete(link_prov{i});
                end
            end
        end
        Save_File(obj, Path_Name);
        obj = Open_File(Path_Nome);
        Gauss_Seidel(obj);
        Newton_Rapsh(obj);          %Newton_Robson
        Add_Bar(obj,bar);
        Add_Chave(obj,varargin);
        Add_Linha(obj,linha,i,j);   %i e j são referentes ao numero do barramento ao qual a linha será adicionada
        Calc_Y(obj);
    end
    
    methods     (Access = private)
        Correct_V_base(obj);        %Corrige as tensões de base dos barramentos de acordo com as tensões de base do transformador
        Correct_Curto_Bars(obj);
        Check_Disconnected_Bars( obj );
    end
    
end

