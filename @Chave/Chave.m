classdef Chave      <   handle
    %Esta classe servirá apenas com o propósito de abrir e fechar chaves
    
    properties
        Key=logical(0);
        Bar={[] []};
    end
    
    methods
        function obj = Chave(varargin)
            if nargin==1 && isa(varargin{1},'Chave')
                obj.Key=varargin{1}.Key;
                obj.Bar=varargin{1}.Bar;
            elseif nargin==2
                obj.Bar{1}=varargin{1};
                obj.Bar{2}=varargin{2};
            elseif nargin~=0
                error('número de argumentos inválidos');
            end
        end
        Abrir_Chave(obj);
        Fechar_Chave(obj);
        Add_Bar(obj,varargin);
        l = logical(obj);
        out = or(obj1,obj2);
        out = and(obj1,obj2);
        out = not(obj);
    end
    
end

