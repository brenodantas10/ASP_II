function Calc_S_t( obj )
%Esta função calcula a potência transferida por este Transformador
    V=[obj.Bar{1}.V; obj.Bar{2}.V];
    obj.S_t=V.*conj(obj.Y_Barra*V);
    obj.S_t=obj.S_t*obj.S_base;

end

