function Check_Disconnected_Bars( obj )
%Esta função checa as barras desconectadas do sistema
    obj.Non_Linked_Bars=num2cell(logical(zeros(size(obj.Barras,2))));
    for i=1:size(obj.Barras,2)
        for j=(i+1):size(obj.Barras,2)
            obj.Non_Linked_Bars{[i j]}=(Non_Linked_Bars{[i j]} | obj.Links{i,j}{1});
        end
    end
end

