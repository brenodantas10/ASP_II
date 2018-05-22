function Change_S_base( obj,S_base )
%Esta função muda o S_base do transformador
    obj.X_pos=obj.X_pos*(S_base/obj.S_base);
    obj.X_0=obj.X_0*(S_base/obj.S_base);
    obj.S_base=S_base;
    
    obj.Calc_Y;


end

