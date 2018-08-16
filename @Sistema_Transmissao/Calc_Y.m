function Calc_Y( obj )
%Esta função calcula A Matriz de Adimitância para os Cálculos de fluxo de
%carga do sistema
    obj.Correct_V_base;
    obj.Check_Curto;
    obj.Check_Connected;
    obj.Unite_Curto_Bars;
    
    obj.Y_Barra=zeros(numel(obj.Curto_Bars));
    for l=1:numel(obj.Linhas)
        i=0; j=0;
        for k=1:numel(obj.Curto_Bars)
            for m=1:numel(obj.Curto_Bars{k})
                if obj.Curto_Bars{k}(m)==obj.Linhas{l}.Bar{1}
                    i=k;
                elseif obj.Curto_Bars{k}(m)==obj.Linhas{l}.Bar{2}
                    j=k;
                end
            end
        end
        if i~=j
            if isa(obj.Linhas{l},'Linha_Transmissao')
                obj.Y_Barra([i j],[i j])=obj.Y_Barra([i j],[i j])+obj.Linhas{l}.Y_Barra./obj.Linhas{l}.Bar{1}.Y_base;
            elseif isa(obj.Linhas{l},'Transformador')
                obj.Y_Barra([i j],[i j])=obj.Y_Barra([i j],[i j])+obj.Linhas{l}.Y_Barra;
            end
        end
    end
end