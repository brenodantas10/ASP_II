function Change_Tipo( obj,Tipo )
%Esta função muda o tipo do Barramento
    if strcmpi(Tipo,'Slack')
        obj.Tipo='Slack';
        obj.Fixo=logical([0 0 1 1]);
    elseif strcmpi(Tipo,'Carga')
        obj.Tipo='Carga';
        obj.Fixo=logical([1 1 0 0]);
    elseif strcmpi(Tipo,'V_Ctrl')
        obj.Tipo='V_Ctrl';
        obj.Fixo=logical([1 0 1 0]);
    elseif strcmpi(Tipo,'V_Ctrl_Cap')
        obj.Tipo='V_Ctrl_Cap';
        obj.Fixo=logical([1 1 0 0]);
    else
        error('Tipo não existente...');
    end
    
end

