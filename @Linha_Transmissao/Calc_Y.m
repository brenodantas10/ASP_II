function Calc_Y(obj)
    %Esta função calcula a matriz de admitância da linha de
    %transmissão com base nos parâmetros Z0, gamma e l.

    obj.Y=[ 1/(obj.Z0*tanh(obj.gamma*obj.l))    -1/(obj.Z0*sinh(obj.gamma*obj.l));
       -1/(obj.Z0*sinh(obj.gamma*obj.l))     1/(obj.Z0*tanh(obj.gamma*obj.l))];
end