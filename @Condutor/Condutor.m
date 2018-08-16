classdef Condutor < handle
    %Esta função contém as propriedades do condutor a ser utilizado
    
    properties (SetAccess = private, GetAccess = public)
        geo_mat={};
        R=0;
        L=0;
        C=0;
    end
    
    methods
        function obj = Condutor(varargin)
            if nargin==1 && isa(varargin{1},'Condutor')
                obj.geo_mat=varargin{1}.geo_mat;
                for i=1:size(obj.geo_mat,2)
                    obj.geo_mat{i}{1}=Material(obj.geo_mat{i}{1});
                end
                obj.Calc_RLC;
            elseif nargin==3 && isa(varargin{1},'double')
                obj.R=varargin{1};
                obj.L=varargin{2};
                obj.C=varargin{3};
            elseif nargin==1 && isa(varargin{1},'cell')
                if isa(varargin{1}{1}{1,1},'Material') && isa(varargin{1}{1}{1,2},'double')
                    obj.geo_mat=varargin{1};
                    for i=1:size(obj.geo_mat,2)
                        obj.geo_mat{i}{1}=Material(obj.geo_mat{i}{1});
                    end
                else
                    error('Tipo errado');
                end
                obj.Calc_RLC;
            elseif nargin~=0
                n=1;
                while(n<=nargin)
                    if (nargin-n+1)<3 && isa(varargin{n},'Material') && isa(varargin{n+1},'double')
                        obj.geo_mat{end+1}={varargin{n} varargin{n+1}};
                        n=n+2;
                    elseif isa(varargin{n},'Material') && isa(varargin{n+1},'double') && ~isa(varargin{n+2},'double')
                        obj.geo_mat{end+1}={varargin{n} varargin{n+1}};
                        n=n+2;
                    elseif isa(varargin{n},'Material') && isa(varargin{n+1},'double') && isa(varargin{n+2},'double')
                        obj.geo_mat{end+1}={varargin{n} [varargin{n+1} varargin{n+2}]};
                        n=n+3;
                    else
                        error('Formato não aceito');
                    end
                    obj.geo_mat{end}{1}=Material(obj.geo_mat{end}{1});
                end
                if size(obj.geo_mat,2)>0
                    obj.Calc_RLC;
                end
            end
        end
        Calc_RLC(obj);
        Add_Cables(obj,varargin);
        plot(obj,varargin);
        Change_R(obj,R);
    end
    
end

