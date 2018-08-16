function Unite_Bars( obj,Bars )
%Esta função permite criar um Barramento com Características de todos os
%Barramentos que estão em curto Para Facilitar os métodos de Newton-Raphson
    prov=Bars(1).Tipo;
    obj.Tipo='Custom';
    obj.Fixo=Bars(1).Fixo;
    obj.S_base=Bars(1).S_base;
    obj.V_base=Bars(1).V_base;
    obj.Z_base=Bars(1).Z_base;
    obj.Y_base=Bars(1).Y_base;
    obj.V=Bars(1).V;
    obj.S_g=Bars(1).S_g;
    obj.S_p=Bars(1).S_p;
    obj.S_t=Bars(1).S_t;
    obj.Zg=Bars(1).Zg;
    obj.Zn=Bars(1).Zn;
    obj.Tipo_Aterramento=Bars.Tipo_Aterramento;
    for i=1:numel(Bars(1).Conexao)
        if ~isa(Bars(1).Conexao{i},'Chave')
            obj.Conexao{end+1}=Bars(1).Conexao{i};
        end
    end

    for i=2:numel(Bars)
        if obj.S_base~=Bars(i).S_base || obj.V_base~=Bars(i).V_base
            error('As bases dos Barramentos devem ser idênticas');
        elseif (strcmpi(prov,'V_Ctrl') || strcmpi(prov,'V_Ctrl_Cap')) && (strcmpi(Bars(i).Tipo,'V_Ctrl') || strcmpi(Bars(i).Tipo,'V_Ctrl_Cap')) && obj.V~=Bars(i).V
            error('Um dos barramentos de tensão controlada tem tensão diferente dos demais');
        end
        
        obj.Fixo([1 2])=obj.Fixo([1 2]) & Bars(i).Fixo([1 2]);
        obj.Fixo([3 4])=obj.Fixo([3 4]) | Bars(i).Fixo([3 4]);
        obj.S_g=obj.S_g+Bars(i).S_g;
        obj.S_p=obj.S_p+Bars(i).S_p;
        if strcmpi(Bars(i).Tipo,'V_Ctrl') || strcmpi(Bars(i).Tipo,'V_Ctrl_Cap')
            obj.V=Bars(i).V;
        end
        if strcmpi(Bars(i).Tipo,'V_Ctrl') || strcmpi(Bars(i).Tipo,'Slack')
            obj.Zg=1/(1/Bars(i).Zg + 1/obj.Zg);
            obj.Zn=1/(1/Bars(i).Zn + 1/obj.Zn);
        end
        for j=1:numel(Bars(i).Conexao)
            if ~isa(Bars(i).Conexao{j},'Chave')
                obj.Conexao{end+1}=Bars(i).Conexao{j};
            end
        end
    end
    obj.S_t=obj.S_g-obj.S_p;
end

