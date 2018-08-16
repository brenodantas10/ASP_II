function Add_Connection(obj, connector)
%Esta função adiciona uma linha ou trafo ou chave ao Barramento
    if numel(connector)==1 && (isa(connector,'Chave') || isa(connector,'Linha_Transmissao') || isa(connector,'Transformador'))
        obj.Conexao{end+1}=connector;
    else
        error('O objeto posto não é um tipo de connector');
    end
end