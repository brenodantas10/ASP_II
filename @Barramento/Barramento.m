classdef Barramento < handle
    %Esta classe conterá todas as características contidas num barramento
    %como a tensão base, potencia aparente base, impedância base e admitancia
    %base, bem como a tensão nele em p.u., potencias de geração, perdas e 
    %transmissão, e o tipo do barramento
    %envolvente.
    
    properties (SetAccess = private, GetAccess = public)
        Tipo='Carga'
        S_base=1e6      %
        V_base=1e3      %Parâmetros de Base
        Z_base=1        %
        Y_base=1        %
        V=1             %Tensão na barra em p.u.
        S_g=0           %Potencia de geração
        S_p=0           %Potência de Perdas
        S_t=0           %Potência Transmitida
        Conexao={}      %A quais linhas ou trafos ele esta conectado
    end
    
    methods
        function obj = Barramento(varargin)  %Construtor
            if nargin==1
                if isa(varargin{1},'Barramento')
                    obj.Tipo=varargin{1}.Tipo;
                    obj.S_base=varargin{1}.S_base;
                    obj.V_base=varargin{1}.V_base;
                    obj.Z_base=varargin{1}.Z_base;
                    obj.Y_base=varargin{1}.Y_base;
                    obj.V=varargin{1}.V;
                    obj.S_g=varargin{1}.S_g;
                    obj.S_p=varargin{1}.S_p;
                    obj.S_t=varargin{1}.S_t;
                else
                    error('Se usar apenas 1 argumento como input, então ele deve ser do tipo Barramento');
                end
            elseif nargin>3
                
                obj.S_base=varargin{2};
                obj.V_base=varargin{3};
                obj.Z_base=obj.V_base.^2./obj.S_base;
                obj.Y_base=1/obj.Z_base;

                if strcmpi(varargin{1},'Slack')
                    obj.Tipo='Slack';
                elseif strcmpi(varargin{1},'Carga')
                    obj.Tipo='Carga';
                elseif strcmpi(varargin{1},'V_Ctrl')
                    obj.Tipo='V_Ctrl';
                else
                    error('Tipo não existente...');
                end

                if nargin==4
                    if strcmpi(obj.Tipo,'Slack')
                        obj.V=varargin{4}/obj.V_base;
                    elseif strcmpi(obj.Tipo,'Carga')
                        obj.S_p=varargin{4}/obj.S_base;
                    elseif strcmpi(obj.Tipo,'V_Ctrl')
                        error('Dados insulficientes');
                    end
                elseif nargin==5
                    if strcmpi(obj.Tipo,'Slack')
                        obj.V=varargin{4}*exp(1i*varargin{5})/obj.V_base;
                    elseif strcmpi(obj.Tipo,'Carga')
                        obj.S_p=varargin{4};
                        obj.S_g=varargin{5};
                        obj.S_t=obj.S_g-obj.S_p;
                    elseif strcmpi(obj.Tipo,'V_Ctrl')
                        obj.S_t=real(varargin{4});
                        obj.V=abs(varargin{5});
                    end
                else
                    error('Quantidade de Dados desnecessários, ver comentários do contrutor');
                end
            end
            
            
        end
        V_Write(obj,V);
        S_Write(obj,S);
        V_New_Base(obj,V_base);
        S_New_Base(obj,S_base);
        add_connection(obj, connector);
        Save_File(obj,Path_Name);
        obj = Open_File(obj,Path_Name);
    end
    
end

