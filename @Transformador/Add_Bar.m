function Add_Bar( obj, varargin )
%Esta função permite identificar quais barramentos estão conectados a este
%objeto
    if nargin==2
        if isa(varargin{1},'Barramento') && numel(varargin{1})==1
            if isempty(obj.Bar{1})
                obj.Bar{1}=varargin{1};
            elseif isempty(obj.Bar{2}) 
                obj.Bar{2}=varargin{1};
            else
                error('A chave está com os dois lados conectados');
            end
        else
            error('O objeto de entrada não é um Barramento e deve ser de tamanho 1');
        end
    elseif nargin==3
        if isa(varargin{1},'Barramento') && numel(varargin{1})==1
            if isa(varargin{2},'double') && numel(varargin{2})==1 && (varargin{2}==1 || varargin{2}==2)
                if isempty(obj.Bar{varargin{2}})
                    obj.Bar{varargin{2}}=varargin{1};
                else
                    error('Barramento escolhido não está vazio');
                end
            else
                error('Posição inexistente ou incoerente');
            end
        else
            error('A entrada não é do tipo Barramento ou possui multiplos Barramentos');
        end
    else
       error('Tem muitos argumentos ou nenhum'); 
    end
end