function V_Write(obj,V)
    if ~obj.Fixo(3) && ~obj.Fixo(4)
        obj.V=V;
    elseif obj.Fixo(3) && ~obj.Fixo(4)
        obj.V=abs(obj.V)*exp(1i*angle(V));
    elseif ~obj.Fixo(3) && obj.Fixo(4)
        obj.V=abs(V)*exp(1i*angle(obj.V));
    end
end