function Calc_RLC( obj )
%Esta função calcula a resistencia por metro, indutancia por metro e
%capacitancia por metro de um condutor
    p=1;
    n_ger=size(obj.geo_mat,2);
    geo_fase=[];
    L=[];
    R=[];
    C=[];
    for i=1:n_ger
        if obj.geo_mat{i}{1}.R_int<inf
            geo_fase(end+1,:)=obj.geo_mat{i}{2};
            L(end+1)=obj.geo_mat{i}{1}.L_int;
            R(end+1)=obj.geo_mat{i}{1}.R_int;
            C(end+1)=obj.geo_mat{i}{1}.C_int;
        end
    end
    n_ger=size(geo_fase,1);
    %calculando as distâncias entre condutores de mesma fase
    d=dist(geo_fase,geo_fase');

    %Calculando a multiplicação de distancias de mesma fase para cada germinação
    d_prod=prod(d+eye(size(d)));
    C=1./(1./C+log(p./d_prod)./(1e-9/18));
    L=L+2e-7*log(p./d_prod);
    
    %Calculando Parâmetros
    obj.R=1/sum(1./R);
    obj.L=1/sum(1./L);
    obj.C=sum(C);
end

