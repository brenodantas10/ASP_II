classdef Transformador  <   handle
    %Esta classe irá definir um objeto transformador
    
    properties  (SetAccess = private, GetAccess = public)
        Connections={}      %Conexões (Aqui devem ser barramentos)
        S_base=1;           %Potência base do transformador (Geralmente o quanto de potência ele pode transferir)
        V_base1=1;          %Primário
        V_base2=1;          %Secundário
        n=1;                %relação de transformação, n=V_base1/V_base2
        X_pos=0;            %Valor em p.u. de X+
        X_0=0;              %Valor em p.u. de X0
        Y_Barra=zeros(2);   %A matriz de  em p.u.
    end
    
    methods
        function obj = Transformador(varargin)
            if nargin==1 & isa(varvargin{1},'Transformador')
                obj.S_base=varvargin{1}.S_base;
                obj.V_base1=varvargin{1}.V_base1;
                obj.V_base2=varvargin{1}.V_base2;
                obj.X_pos=varvargin{1}.X_pos;
                obj.X_0=varvargin{1}.X_0;
                obj.Y_Barra=varvargin{1}.Y_Barra;
                obj.n=varvargin{1}.n;
            elseif nargin==3
                obj.S_base=varvargin{3};
                obj.V_base1=varvargin{1};
                obj.V_base2=varvargin{2};
                obj.n=obj.V_base1/obj.V_base2;
            elseif nargin==5
                obj.S_base=varvargin{3};
                obj.V_base1=varvargin{1};
                obj.V_base2=varvargin{2};
                obj.n=obj.V_base1/obj.V_base2;
                obj.X_pos=varargin{4};
                obj.X_0=varargin{5};
            elseif narargin~=0
                error('Quantidade de argumentos não condizente ou tipo errado');
            end
            obj.Calc_Y;
            
        end
        Change_V_base(obj,V1,V2);
        Change_S_base(obj,S_base);
        Connect(obj,Bar1,Bar2);
        Calc_Y(obj);
        Change_X(obj,varargin);
    end
    
end

