function Connect( obj,Bar1,Bar2 )
%Esta função connecta os Barramentos de um sistema
    if isa(Bar1,'Barramento') & isa(Bar2,'Barramento')
        obj.Connections{end+1}=Bar1;
        obj.Connections{end+1}=Bar2;
    else
        error('Bar1 e Bar2 precisam ser da classe Barramento');
    end
end

