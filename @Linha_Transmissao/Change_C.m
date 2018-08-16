function Change_C( obj, C )
    %Esta função muda o C da Linha
    obj.C=C;
    obj.Calc_Z0_gamma;
    obj.Calc_Y;
end



