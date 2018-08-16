function Calc_S_t( obj )
%Esta função calcula a potência transferida por esta linha
    V=[obj.Bar{1}.V*obj.Bar{1}.V_base; obj.Bar{2}.V*obj.Bar{2}.V_base];
    obj.S_t=V.*conj(obj.Y_Barra*V);
end

