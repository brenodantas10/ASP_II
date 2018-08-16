function Change_Aterramento( obj, Tipo )
%Esta função muda o tipo de aterramento do Barramento
    if strcmpi(Tipo,'Y')
        obj.Tipo_Aterramento='Y';
    elseif strcmpi(Tipo,'YA')
        obj.Tipo_Aterramento='YA';
    elseif strcmpi(Tipo,'D')
        obj.Tipo_Aterramento='D';
    end


end

