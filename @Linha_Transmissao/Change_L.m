function Change_L( obj, L )
    %Esta função muda o L da Linha
    obj.L=L;
    obj.Calc_Z0_gamma;
    obj.Calc_Y;
end

