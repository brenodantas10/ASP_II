function Mudar_Terminais( obj,n,m )
%Esta função indica quais Barramentos estão conectados
    if m>n
        obj.Terminais=[n m];
    elseif n>m
        obj.Terminais=[m n];
    else
        error('Não existe chave que liga um barramento a ele mesmo');
    end
end

