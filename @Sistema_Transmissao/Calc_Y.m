function Calc_Y( obj )
%Esta função calcula A Matriz de Adimitância para os Cálculos de fluxo de
%carga do sistema
    n_bar=size(obj.Barras,2);
    Y_prov=num2cell(zeros(n_bar));
    obj.Curto_Bars=num2cell(num2cell([1:n_bar]));
    obj.Check_Disconnected_Bars();
    obj.Correct_V_base();
    for i=1:(n_bar-1)
        for j=(i+1):n_bar
            if obj.Links{i,j}{1}
                k_max=size(obj.Links{i,j},2);
                if k_max>1
                    if isa(obj.Links{i,j}{2},'Transformador')
                        if obj.Barras{i}.V_base~=obj.Links{i,j}{2}.V_base1 || obj.Barras{j}.V_base~=obj.Links{i,j}{2}.V_base2
                            error('Os barramentos possuem tensões de base diferentes do que as do transformador');
                        end
                        for k=2:k_max
                            Y_prov{[i j],[i j]}=Y_prov{[i j],[i j]}+obj.Links{i,j}{k}.Y*obj.S_base/obj.Links{i,j}{k}.S_base;
                        end
                    elseif isa(obj.Links{i,j}{2},'Linha_Transmissao')
                        if obj.Barras{i}.V_base~=obj.Barras{j}.V_base
                            error('Os Barramentos possuem diferentes tensões de base');
                        end
                        for k=2:k_max
                            Y_prov{[i j],[i j]}=Y_prov{[i j],[i j]}+obj.Links{i,j}{k}.Y*obj.S_base/obj.Barras{i}.V_base^2;
                        end
                    end
                else
                    obj.Curto_Bars{i}{end+1}={j};
                end
            end
        end
    end
    obj.Correct_Curto_Bars();
    Y_prov2=num2cell(obj.Curto_Bars);
    prov_bars=1:size(obj.Barras,2);
    prov_curto={};
    obj.Y_Barra=zeros(size(obj.Curto_Bars,2));
    for i=1:size(obj.Curto_Bars,2)
        for j=2:size(obj.Curto_Bars{i},2)
            prov_curto{end+1}=obj.Curto_Bars{i}{j};
        end
    end
    for i=1:size(obj.Curto_Bars,2)
            for j=2:size(obj.Curto_Bars{i},2)
                Y_prov{obj.Curto_Bars{i}{1},:}=Y_prov{obj.Curto_Bars{i}{1},:}+Y_prov{obj.Curto_Bars{i}{j},:};
                Y_prov{:,obj.Curto_Bars{i}{1}}=Y_prov{:,obj.Curto_Bars{i}{1}}+Y_prov{:,obj.Curto_Bars{i}{j}};
            end
        obj.Y_Barra(i,:)=[Y_prov{i,~sum(eq(prov_bars,[prov_curto]))}];
    end
    
    for i=1:size(Y_prov,1)
        obj.Y_Barra(i,:)=[Y_prov{i,:}];
    end
end