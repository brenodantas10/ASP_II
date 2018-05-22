function Add_Linha( obj, Linha,i,j)
%Esta função adiciona Uma linha de transmissão ou transformador conectando
%os barramentos i e j
    if i>j
        n=j; m=i;
    elseif i<j
        n=i; m=j;
    else
        error('Não pode adicionar uma Linha conectando um barramento a ele mesmo');
    end
    
    if size(obj.Links{n,m},2)==1
        if isa(obj.Links{n,m}{1},'logical')
            obj.Links{n,m}{1}=logical(1);
        end
    elseif size(obj.Links{n,m},2)>1
        if (isa(obj.Links{n,m}{end},'Transformador') && ~isa(Linha,'Transformador')) || (isa(obj.Links{n,m}{end},'Linha_Transmissao') && ~isa(Linha,'Linha_Transmissao'))
            error('Entre dois Barramentos só pode haver transformadores em paralelo transformador ou várias Linhas em Paralelo');
        elseif isa(obj.Links{n,m}{end},'Transformador') && isa(Linha,'Transformador')
            if obj.Links{n,m}{end}.V1_base~=Linha.V1_base || obj.Links{n,m}{end}.V2_base~=Linha.V2_base || obj.Links{n,m}{end}.a~=Linha.a
                error('Os transformadores destes barramentos devem ter a mesma tensão base e relação de transformação');
            end
        end
    end
    
    if isa(Linha,'Linha_Transmissao')
        obj.Links{n,m}{end+1}=Linha_Transmissao(Linha);
    elseif isa(Linha,'Transformador')
        obj.Links{n,m}{end+1}=Transformador(Linha);
    else
        error('O objeto não se configura como uma linha ou transformador');
    end
end

