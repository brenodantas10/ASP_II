function Add_Bar( obj, Bar )
%Esta Função Adiciona um Barramento ao Sistema
obj.Barras{end+1}=Barramento(Bar);
obj.Barras{end}.S_New_Base(obj.S_base);
end

