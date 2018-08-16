function Correct_V_base( obj )
%Esta função regulariza todas as tensões de base dos Barramentos
    for i=1:numel(obj.Linhas)
        if isa(obj.Linhas{i},'Transformador')
            prov{1}=obj.Linhas{i}.Bar{1};
            prov{2}=obj.Linhas{i}.Bar{2};
            prov{1}.V_New_Base(obj.Linhas{i}.V_base1);
            prov{2}.V_New_Base(obj.Linhas{i}.V_base2);
            obj.Change_Bar_V_Base({prov{1}},{obj.Linhas{i}});
            obj.Change_Bar_V_Base({prov{2}},{obj.Linhas{i}});
        end
    end
end

