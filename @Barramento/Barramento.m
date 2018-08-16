classdef Barramento < handle
    %Esta classe conterá todas as características contidas num barramento
    %como a tensão base, potencia aparente base, impedância base e admitancia
    %base, bem como a tensão nele em p.u., potencias de geração, perdas e 
    %transmissão, e o tipo do barramento
    %envolvente.
    
    properties (SetAccess = private, GetAccess = public)
        Tipo='Carga';                   %Tipo de Barramento
        Tipo_Aterramento='YA';          %Tipo de Aterramento da Carga
        Fixo=[false false false false]  %Parâmetros imutáveis [P_t  Q_t  |V|  angle(V)]
        S_base=1                        %
        V_base=1                        %Parâmetros de Base
        Z_base=1                        %
        Y_base=1                        %
        V=1                             %Tensão na barra em p.u.
        S_g=0                           %Potencia de geração
        S_p=0                           %Potência de Perdas
        S_t=0                           %Potência Transmitida
        Conexao={}                      %A quais linhas ou trafos ele esta conectado
        Zg=inf                          %Impedância do Gerador
        Zn=inf                          %Impedância de Neutro
        Z_Carga=inf;
    end
    
    methods
        function obj = Barramento(varargin)  %Construtor
            if nargin==1
                if isa(varargin{1},'Barramento')
                    if numel(varargin{1})==1
                        obj.Tipo=varargin{1}.Tipo;
                        obj.Fixo=varargin{1}.Fixo;
                        obj.S_base=varargin{1}.S_base;
                        obj.V_base=varargin{1}.V_base;
                        obj.Z_base=varargin{1}.Z_base;
                        obj.Y_base=varargin{1}.Y_base;
                        obj.V=varargin{1}.V;
                        obj.S_g=varargin{1}.S_g;
                        obj.S_p=varargin{1}.S_p;
                        obj.S_t=varargin{1}.S_t;
                        obj.Tipo_Aterramento=varargin{1}.Tipo_Aterramento;
                        obj.Zg=varargin{1}.Zg;
                        obj.Zn=varargin{1}.Zn;
                    else
                        obj.Unite_Bars(varargin{1});
                    end
                else
                    error('Se usar apenas 1 argumento como input, então ele deve ser do tipo Barramento');
                end
            elseif nargin>4
                obj.Change_Tipo(varargin{1});
                obj.Change_Aterramento(varargin{2});
                obj.S_base=varargin{3};
                obj.V_base=varargin{4};
                obj.Z_base=obj.V_base.^2./obj.S_base;
                obj.Y_base=1/obj.Z_base;
                if strcmpi(obj.Tipo,'Slack') || strcmpi(obj.Tipo,'V_Ctrl')
                    if strcmp(obj.Tipo_Aterramento,'YA')
                        
                        obj.Zn=0;
                        obj.Zg=0;
                    elseif strcmp(obj.Tipo_Aterramento,'Y') || strcmp(obj.Tipo_Aterramento,'D')
                        obj.Zn=inf;
                        obj.Zg=0;
                    end
                end
                if nargin==5
                    if strcmpi(obj.Tipo,'Slack')
                        obj.V=varargin{5}/obj.V_base;
                    elseif strcmpi(obj.Tipo,'Carga')
                        obj.S_p=varargin{5}/obj.S_base;
                    elseif strcmpi(obj.Tipo,'V_Ctrl') || strcmpi(obj.Tipo,'V_Ctrl_Cap')
                        error('Dados insulficientes');
                    else
                        error('Tipo não Compatível');
                    end
                elseif nargin==6
                    if strcmpi(obj.Tipo,'Slack')
                        obj.V=varargin{5}*exp(1i*varargin{6})/obj.V_base;
                    elseif strcmpi(obj.Tipo,'Carga')
                        obj.S_p=varargin{5};
                        obj.S_g=varargin{6};
                    elseif strcmpi(obj.Tipo,'V_Ctrl')
                        obj.S_g=real(varargin{5});
                        obj.V=abs(varargin{6});
                    elseif strcmpi(obj.Tipo,'V_Ctrl_Cap')
                        obj.S_g=1i*imag(varargin{5});
                        obj.V=abs(varargin{6});
                    else
                        error('Tipo não Compatível');
                    end
                else
                    error('Quantidade de Dados desnecessários, ver comentários do contrutor');
                end
                obj.S_t=obj.S_g-obj.S_p;
            end
        end
        V_Write(obj,V);
        S_Write(obj,S);
        V_New_Base(obj,V_base);
        S_New_Base(obj,S_base);
        Add_Connection(obj, connector);
        Change_Aterramento(obj,Tipo);
        Save_File(obj,Path_Name); %Não implementado
        obj = Open_File(obj,Path_Name); %Não implementado
        Calc_Z_Carga(obj); %Necessita de implementação
        Change_Tipo(obj,Tipo);
        Unite_Bars(obj,Bars);
    end
    
end

