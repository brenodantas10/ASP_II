function Add_Bar( obj, Bar )
%Esta Função Adiciona um Barramento ao Sistema
obj.Barras{end+1}=Barramento(Bar);
obj.Barras{end}.S_New_Base(obj.S_base);
n=size(obj.Barras,2);
obj.Links{:,end+1}=num2cell(logical(zeros(n,1)));
obj.Links{n,n}{1}=logical(1);
end

