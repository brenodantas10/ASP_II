function S_New_Base( obj, S_base )
%Esta função permite trocar a base de potência do Barramento

S_prov=[obj.S_g, obj.S_p, obj.S_t]*(obj.S_base/S_base);
obj.S_g=S_prov(1); obj.S_p=S_prov(2); obj.S_t=S_prov(3);
obj.S_base=S_base;
obj.Z_base=obj.V_base^2/obj.S_base;
obj.Y_base=1/obj.Z_base;


end

