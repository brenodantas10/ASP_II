function  Calc_S_Linhas( obj )
%Esta função calcula a transferência de potência das Linhas e
%Transformadores do Sistema
    for i=1:numel(obj.Linhas)
        if ~isa(obj.Linhas{i},'Chave')
            obj.Linhas{i}.Calc_S_t;
        end
    end
end

