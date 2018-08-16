function Check_Curto( obj )
%Esta função checa se há curto entre duas barras
    obj.Curto_Bars=obj.Barras;
    for i=1:numel(obj.Linhas)
        if isa(obj.Linhas{i},'Chave')
            if obj.Linhas{i}
                flag_1=true;
                j=0;
                while(flag_1)
                    j=j+1;
                    if obj.Curto_Bars{j}(1)==obj.Linhas{i}.Bar{1}
                        obj.Curto_Bars{j}(end+1)=obj.Linhas{i}.Bar{2};
                        flag_1=false;
                        flag_2=true;
                        while flag_2
                            j=j+1;
                            if obj.Curto_Bars{j}(1)==obj.Linhas{i}.Bar{2}
                                obj.Curto_Bars(j)=[];
                                flag_2=false;
                            end
                        end
                    elseif obj.Curto_Bars{j}(1)==obj.Linhas{i}.Bar{2}
                        obj.Curto_Bars{j}(end+1)=obj.Linhas{i}.Bar{1};
                        flag_1=false;
                        flag_2=true;
                        while flag_2
                            j=j+1;
                            if obj.Curto_Bars{j}(1)==obj.Linhas{i}.Bar{1}
                                obj.Curto_Bars(j)=[];
                                flag_2=false;
                            end
                        end
                    end
                end
            end
        end
    end
end

