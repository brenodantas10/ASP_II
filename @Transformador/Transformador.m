classdef Transformador  <   handle
    %Esta classe irá definir um objeto transformador
    
    properties  (SetAccess = private, GetAccess = public)
        Bar={[] []}         %Conexões (Aqui devem ser barramentos)
        Tipo={'YA' 'YA'};   %Dois componentes falando o tipo de conexão de cada lado do trafo
        S_base=1;           %Potência base do transformador (Geralmente o quanto de potência ele pode transferir)
        V_base1=1;          %Primário
        V_base2=1;          %Secundário
        n=1;                %relação de transformação, n=V_base1/V_base2
        X_pos=0;            %Valor em p.u. de X+
        X_0=0;              %Valor em p.u. de X0
        Y_Barra=zeros(2);   %A matriz de  em p.u.
        Y0_Barra=zeros(2);
        Ypos_Barra=zeros(2);
        Yneg_Barra=zeros(2);
        S_t=[0;0]
    end
    
    methods
        function obj = Transformador(varargin)
            if nargin==1 && isa(varargin{1},'Transformador')
                obj.S_base=varargin{1}.S_base;
                obj.V_base1=varargin{1}.V_base1;
                obj.V_base2=varargin{1}.V_base2;
                obj.X_pos=varargin{1}.X_pos;
                obj.X_0=varargin{1}.X_0;
                obj.Y_Barra=varargin{1}.Y_Barra;
                obj.n=varargin{1}.n;
                obj.Tipo=varargin{1}.Tipo;
            elseif nargin==5
                obj.S_base=varargin{1};
                obj.V_base1=varargin{2};
                obj.V_base2=varargin{4};
                obj.Change_Type(varargin{3},1);
                obj.Change_Type(varargin{5},2);
                obj.n=obj.V_base1/obj.V_base2;
            elseif nargin==7
                obj.S_base=varargin{1};
                obj.V_base1=varargin{2};
                obj.V_base2=varargin{4};
                obj.Change_Type(varargin{3},1);
                obj.Change_Type(varargin{5},2);
                obj.n=obj.V_base1/obj.V_base2;
                obj.X_pos=varargin{6};
                obj.X_0=varargin{7};
            elseif nargin~=0
                error('Quantidade de argumentos não condizente ou tipo errado');
            end
            obj.Calc_Y;
            
        end
        Change_V_base(obj,V1,V2);
        Change_S_base(obj,S_base);
        Add_Bar(obj,varargin);
        Change_Type(obj,tipo,lado);
        Calc_Y(obj);
        Change_X(obj,varargin);
        Calc_S_t(obj);
    end
    
end

