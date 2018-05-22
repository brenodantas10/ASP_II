function V_New_Base( obj, V_base )
%Esta função permite trocar a base de tensão do Barramento
obj.V=obj.V*obj.V_base/V_base;
obj.V_base=V_base;
obj.Z_base=obj.V_base^2/obj.S_base;
obj.Y_base=1/obj.Z_base;
end

