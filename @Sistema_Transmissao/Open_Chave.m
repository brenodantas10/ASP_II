function Open_Chave( obj,i )
%Esta Função abre a chave i do sistema
    if round(i)==i && i>0 && i<=numel(obj.Chaves)
        obj.Chaves{i}.Abrir_Chave;
    else
        error('Essa Chave não existe');
    end
end

