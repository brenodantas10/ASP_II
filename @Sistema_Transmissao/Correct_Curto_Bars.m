function Correct_Curto_Bars( obj )
%Esta função corrige os indices do Curto_Bars
    for i=1:size(obj.Curto_Bars,2)
        for j=2:size(obj.Curto_Bars{i},2)
            prov=logical(sum(eq([obj.Curto_Bars{i}{:}]',[obj.Curto_Bars{j}{:}])));
            for k=2:size(prov,2)
                if ~prov(k)
                    obj.Curto_Bars{i}{end+1}=obj.Curto_Bars{j}{k};
                end
            end
            obj.Curto_Bars(j)=[];
        end
    end
end