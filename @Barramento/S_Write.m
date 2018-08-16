function S_Write(obj,S)
    if ~obj.Fixo(1) && ~obj.Fixo(2)
        obj.S_t=S;
    elseif obj.Fixo(1) && ~obj.Fixo(2)
        obj.S_t=real(obj.S_t)+1i*imag(S);
    elseif ~obj.Fixo(1) && obj.Fixo(2)
        obj.S_t=real(S)+1i*imag(obj.S_t);
    end
end