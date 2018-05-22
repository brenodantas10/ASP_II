function Calc_Z0_gamma(obj)
    %Esta função calcula os valores da impedância intrínseca e
    %constante de propagação da linha de acordo com valores já
    %pre-estabelecidos R,L,C;

    obj.Z0      =   sqrt((obj.R+1i*2*pi*obj.f*obj.L)/(1i*2*pi*obj.f*obj.C));
    obj.gamma   =   sqrt((obj.R+1i*2*pi*obj.f*obj.L)*(1i*2*pi*obj.f*obj.C));
end