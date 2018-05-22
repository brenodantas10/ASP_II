function Change_V_base( obj,V1,V2 )
%Esta função muda as tensões de Base do Transformador
    obj.V_base1=V1;
    obj.V_base2=V2;
    obj.n=obj.V_base1/obj.V_base2;
end

