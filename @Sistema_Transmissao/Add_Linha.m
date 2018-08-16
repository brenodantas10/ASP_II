function Add_Linha( obj, Linha,i,j)
%Esta função adiciona Uma linha de transmissão ou transformador conectando
%os barramentos i e j
    if ~(isa(Linha,'Linha_Transmissao') || isa(Linha,'Transformador') || isa(Linha,'Chave')) && numel(Linha)~=1
        error('A classe de entrada não é válida');
    elseif i>numel(obj.Barras) || j>numel(obj.Barras) || i==j || i<=0 || j<=0 round(i)~=i || round(j)~=j
        error('Indicies não condizem com o numero de Barras ou os indices são iguais');
    end
    
    if isa(Linha,'Linha_Transmissao')
        obj.Linhas{end+1}=Linha_Transmissao(Linha);
    elseif isa(Linha,'Transformador')
        obj.Linhas{end+1}=Transformador(Linha);
        obj.Linhas{end}.Change_S_base(obj.S_base);
    elseif isa(Linha,'Chave')
        obj.Linhas{end+1}=Chave(Linha);
        obj.Chaves{end+1}=obj.Linhas{end};
    end
    obj.Linhas{end}.Add_Bar(obj.Barras{i},1);
    obj.Linhas{end}.Add_Bar(obj.Barras{j},2);
    obj.Barras{i}.Add_Connection(obj.Linhas{end});
    obj.Barras{j}.Add_Connection(obj.Linhas{end});
end