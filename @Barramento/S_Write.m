function S_Write(obj,S)
    if strcmp(obj.Tipo,'Slack')
        obj.S_t=S;
    elseif strcmp(obj.Tipo,'Carga')
        error('Barramento de carga não muda a Potência Transmitida');
    elseif strcmp(obj.Tipo,'V_Ctrl')
        obj.S_t=real(obj.S_t)+1i*imag(S);
end