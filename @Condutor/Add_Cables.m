function Add_Cables( obj,varargin )
%Esta função serve para criar os cabos internos ao condutor de forma que o
%corte transversal forme um círculo
%Formato    Add_Cables(Material_1,n_1,Material_2,n_2,...)
%           Add_Cables({Material_1 n_1},{Material_2 n_2})
%
%A ordem dos materiais indica a ordem de dentro pra fora
    if nargin~=1
        obj.geo_mat={};
        i=1;
        prov_raio=0;
        prov_raio_ant=0;
        n=0;
        j=1;
        n_lastshell_end=0;
        prov_n=0;
        while i<=(nargin-1)
            if isa(varargin{i},'cell')
                if isa(varargin{i}{1}, 'Material') && prod(size(varargin{i}{2}))==1 && isa(varargin{i}{2},'double')
                    prov_mat=varargin{i}{1};
                    prov_n=varargin{i}{2};
                    i=i+1;
                else
                    error('Célula não suportado')
                end
            elseif isa(varargin{i},'Material') && prod(size(varargin{i+1}))==1 && isa(varargin{i+1},'double')
                prov_mat=varargin{i};
                prov_n=varargin{i+1};
                i=i+2;
            else
                error('Formato não suportado');
            end
            n=n+prov_n;
            
            while j<=n
                prov_ang=2*atan(sqrt(1/(1-(prov_mat.raio/prov_raio)^2)-1));
                prov_cabe=floor(2*pi/prov_ang);
                prov_ang=2*pi/prov_cabe;
                if prov_raio==0
                    obj.geo_mat{end+1}={Material(prov_mat) [0 0]};
                    prov_raio=obj.geo_mat{end}{1}.raio;
                    j=j+1;
                    n_lastshell_end=n_lastshell_end+1;
                elseif prov_ang<0 || abs(prov_raio- prov_raio_ant-(obj.geo_mat{n_lastshell_end}{1}.raio+prov_mat.raio))>1e-15
                    prov_raio=prov_raio+prov_mat.raio;
                elseif (j-n_lastshell_end)<prov_cabe
                    obj.geo_mat{end+1}={Material(prov_mat) prov_raio*[cos((j-n_lastshell_end-1)*prov_ang) sin((j-n_lastshell_end-1)*prov_ang)]};
                    j=j+1;
                elseif (j-n_lastshell_end)==prov_cabe
                    obj.geo_mat{end+1}={Material(prov_mat) prov_raio*[cos((j-n_lastshell_end-1)*prov_ang) sin((j-n_lastshell_end-1)*prov_ang)]};
                    n_lastshell_end=j;
                    j=j+1;
                    prov_raio_ant=prov_raio;
                    prov_raio=prov_raio+obj.geo_mat{end}{1}.raio;
                end
            end
            
            
        end
    end
        
    
    obj.Calc_RLC;
end

