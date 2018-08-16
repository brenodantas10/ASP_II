function Change_Bar_V_Base(obj,bar_ant,linha_ant)
%Esta função Muda com recorrência todas as tensões de base dos barramentos
%até encontrar um transformador
    for i=1:numel(bar_ant{end}.Conexao)
        prov1=false;
        clear prov;
        for j=1:numel(linha_ant)
            prov1= (prov1 ||  (bar_ant{end}.Conexao{i}==linha_ant{j}));
        end
        
        if ~isa(bar_ant{end}.Conexao{i},'Transformador') && ~prov1
            for j=1:numel(bar_ant)
                prov(j,:)=([bar_ant{end}.Conexao{i}.Bar{:}]==bar_ant{j});
            end
            prov(j+1,:)=[0 0];
            prov=logical(prod(~prov));
            linha_pos={linha_ant{:} bar_ant{end}.Conexao{i}};
            
            if sum(prov)~=0
                bar_ant{end}.Conexao{i}.Bar{prov}.V_New_Base(bar_ant{end}.V_base);
                bar_pos={bar_ant{:} bar_ant{end}.Conexao{i}.Bar{prov}};
                obj.Change_Bar_V_Base(bar_pos,linha_pos);
            end
        end
    end
end

