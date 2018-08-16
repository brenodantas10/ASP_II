function Change_Type(obj,tipo,lado)
%Esta função muda o tipo do trafo no lado primário ou secundário
%Utilização
%
%tipo:
%   'Y' - terminação em Y
%   'YA'- terminação em Y aterrado
%   'D' - terminação em Delta
%
% lado:
%   1 - Referente ao lado primário
%   2 - Referente ao lado secundário

    if lado~=1 && lado~=2
        error('Deve ser conectado ao lado primario ou secundario (1 ou 2)');
    end

    if strcmpi(tipo,'Y')
        obj.Tipo{lado}='Y';
    elseif strcmpi(tipo,'YA')
        obj.Tipo{lado}='YA';
    elseif strcmpi(tipo,'D')
        obj.Tipo{lado}='D';
    else
        error('O tipo informado não condiz com o suportado');
    end

end

