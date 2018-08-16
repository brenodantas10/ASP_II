classdef Material < handle
    %Esta classe contém informações acerca do material a ser utilizado
    
    properties (SetAccess = private, GetAccess = public)
        mu_r=1;         %Permeabilidade do Material
        rho=1;
        raio=1;         %Raio do fio de Material
        L_int=0;        %indutância interna por metro
        R_int=0;        %Resistencia por metro
        C_int=0;
    end
    
    methods
        function obj = Material(varargin)
            if nargin==1 && isa(varargin{1},'Material')
                obj.raio=varargin{1}.raio;
                obj.mu_r=varargin{1}.mu_r;
                obj.rho=varargin{1}.rho;
                obj.Calc_RLC;
            elseif nargin==3 && isa(varargin{1},'double') && isa(varargin{2},'double') && isa(varargin{3},'double')
                obj.raio=varargin{1};
                obj.mu_r=varargin{2};
                obj.rho=varargin{3};
                obj.Calc_RLC;
            else
                error('Não é possível configurar com estas configurações');
            end
        end
        Calc_RLC(obj);
    end
    
end

