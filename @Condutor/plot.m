function plot( obj, varargin )
%Esta função plota o condutor
    theta=0:2*pi/100:2*pi;
    x=cos(theta);
    y=sin(theta);
    raio=0;
    for i=1:size(obj.geo_mat,2)
        if raio<dist([0 0],obj.geo_mat{i}{2}')
            raio=dist([0 0],obj.geo_mat{i}{2}');
            n=i;
        end
    end
    raio=raio+obj.geo_mat{n}{1}.raio;
    
    if nargin==1
        x_center=0;
        y_center=0;
    elseif nargin==2 && prod(size(varargin{1}))==2
        x_center=varargin{1}(1);
        y_center=varargin{1}(2);
    elseif nargin==3 && prod(size(varargin{1}))==1 && prod(size(varargin{2}))==1
        x_center=varargin{1};
        y_center=varargin{2};
    else
        error('Número de parâmetros incompatível');
    end
    hold on; axis equal;
    for i=1:size(obj.geo_mat,2)
        plot(x_center+obj.geo_mat{i}{2}(1)+obj.geo_mat{i}{1}.raio*x,y_center+obj.geo_mat{i}{2}(2)+obj.geo_mat{i}{1}.raio*y,'k');
    end
    plot(x_center+raio*x,y_center+raio*y,'k');
end

