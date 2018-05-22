function Change_X( obj, varargin )
%Esta função muda X_pos ou X_0 da seguinte maneira
%Change_X(obj, X_pos, '+') muda o X_pos
%Change_X(obj, X_0, '0') muda o X_0
%Change_X(obj,X_pos,X_0) muda o X_pos e X_0
    if nargin==2
        if isa(varargin{1},'double')
            if isa(varargin{2},'char')
                if varargin{2}=='+'
                    obj.X_pos=varargin{1};
                elseif varargin{2}=='0'
                    obj.X_0=varargin{1};
                end
            elseif isa(varargin{2},'double'}
                obj.X_pos=varargin{1};
                obj.X_0=varargin{2};
            else
                error('Tipo do segundo termo incompatível');
            end
        else
            error('Tipo do primeiro termo incompatível');
        end
    else
        error('Quantidade errada de termos');
    end
    obj.Calc_Y;
end

