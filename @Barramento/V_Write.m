function V_Write(obj,V)
    if strcmp(obj.Tipo,'Slack')
        error('Barramento Slack não muda tensão');
    elseif strcmp(obj.Tipo,'Carga')
        obj.V=V;
    elseif strcmp(obj.Tipo,'V_Ctrl')
        obj.V=abs(obj.V)*exp(1i*angle(V));
    end
    
end