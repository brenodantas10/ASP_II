function Calc_Y(obj)
    %Esta função calcula a matriz de admitância da linha de
    %transmissão com base nos parâmetros Z0, gamma e l.
    if obj.l<=32000
        obj.Y_Barra=[1 -1;-1 1]/((obj.R+1i*2*pi*obj.f*obj.L)*obj.l);
    else
        obj.Y_Barra=[    1/(obj.Z0*tanh(obj.gamma*obj.l))    -1/(obj.Z0*sinh(obj.gamma*obj.l));
                        -1/(obj.Z0*sinh(obj.gamma*obj.l))     1/(obj.Z0*tanh(obj.gamma*obj.l))];
    end
end