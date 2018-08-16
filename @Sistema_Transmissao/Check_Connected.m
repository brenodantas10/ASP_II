function Check_Connected( obj )
%Esta função checa as barras conectadas ao sistema, caso não estejam, serão
%desconsideradas do sistema
    i=0;
    while i<numel(obj.Curto_Bars)
        i=i+1;
        flag_j=true;
        if numel(obj.Curto_Bars{i}(1).Conexao)==0
            obj.Curto_Bars(i)=[];
            i=i-1;
        else
            flag_j=true;
            j=0;
            while j<numel(obj.Curto_Bars{i}(1).Conexao)
                j=j+1;
                if isa(obj.Curto_Bars{i}(1).Conexao{j},'Linha_Transmissao') || isa(obj.Curto_Bars{i}(1).Conexao{j},'Transformador')
                    flag_j=false;
                elseif isa(obj.Curto_Bars{i}(1).Conexao{j},'Chave')
                    if obj.Curto_Bars{i}(1).Conexao{j}
                        flag_j=false;
                    end
                end
            end
            if flag_j
                obj.Curto_Bars(i)=[];
                i=i-1;
            end
        end
    end
end

