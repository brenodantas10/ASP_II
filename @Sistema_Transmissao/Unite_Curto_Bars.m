function Unite_Curto_Bars( obj )
%Esta função une os Barramentos em Curto em um só Barramento afim de
%Facilitar cálculos de Fluxo de Potência, este Barramento será posto no fim
%da célula de Curto_Bars{i}
    for i=1:numel(obj.Curto_Bars)
        if numel(obj.Curto_Bars{i})>1
            obj.Curto_Bars{i}(end+1)=Barramento(obj.Curto_Bars{i});
        end
    end
end

