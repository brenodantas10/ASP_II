function Calc_RLC( obj )
%Esta função calcula a indutância interna ao condutor que ele faz nele
%mesmo
    p=1;
    obj.L_int=2e-7*log(p./(obj.raio.*exp(-obj.mu_r/4)));
    obj.R_int=obj.rho/(pi*obj.raio^2);
    obj.C_int=(1e-9/18)./log(p./obj.raio);
end

