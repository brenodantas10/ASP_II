function Close_Chave( obj,i )
%Esta Função fecha a chave i do sistema
    if round(i)==i && i>0 && i<=numel(obj.Chaves)
        obj.Chaves{i}.Fechar_Chave;
    else
        error('Essa Chave não existe');
    end
end

