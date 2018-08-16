function Change_R( obj, R )
    %Esta função muda o R da Linha
    obj.R=R;
    obj.Calc_Z0_gamma;
    obj.Calc_Y;
end

