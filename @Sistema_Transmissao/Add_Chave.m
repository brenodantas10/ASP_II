function Add_Chave( obj, varargin )
%Esta função adiciona uma chave ao sistema, uso
%Add_Chave(obj, Chave) ou Add_Chave(obj, n, m), onde n e m são as posições
%dos barramentos
    if nargin==1 && isa(varargin{1},'Chave')
        if varargin{1}.Terminais(1)<=size(obj.Barras,2)
            obj.Chaves{end+1}=Chave(varargin{1});
        else
            error('Numero no Terminal maior que a quantidade de barramentos')
        end
    elseif nargin==2
        if varargin{1}<=size(obj.Barras,2) && && varargin{2}<=size(obj.Barras,2)
            obj.Chaves{end+1}=Chave(varargin{1},varargin{2});
        else
            error('Numero no Terminal maior que a quantidade de barramentos')
        end
    else
        error('Número de argumentos Inválido');
    end
    
    obj.Links{obj.Chaves{end}.Terminais(1),obj.Chaves{end}.Terminais(2)}{1} = obj.Chaves{end};
end

