classdef Chave      <   handle
    %Esta classe servirá apenas com o propósito de abrir e fechar chaves
    
    properties
        Key=logical(0)
        Terminais=[0 0]
    end
    
    methods
        function obj = Chave(varargin)
            if nargin==1 && isa(varargin{1},'Chave')
                obj.Key=varargin{1}.Key;
                obj.Terminais=varargin{1}.Terminais;
            elseif nargin==2
                obj.Terminais(1)=varargin{1};
                obj.Terminais(2)=varargin{2};
            elseif nargin~=0
                error('número de argumentos inválidos');
            end
        end
        Abrir_Chave(obj);
        Fechar_Chave(obj);
        Mudar_Terminais(obj,n,m);
        l = logical(obj);
        out = or(obj1,obj2);
        out = and(obj1,obj2);
        out = not(obj);
    end
    
end

