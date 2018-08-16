function Calc_Y( obj )
%Esta função calcula a matriz de admitância do transformador em p.u.
    obj.Y_Barra=[1 -1;-1 1]/(1i*obj.X_pos);
    prov=[1 2];
    
    alpha=0; %Adiantamento de tensão nos trafos
    
    if strcmp(obj.Tipo{1},'YA') && strcmp(obj.Tipo{1},'YA')
        Y0_Barra=[1 -1;-1 1]/(1i*obj.X_0);
        Ypos_Barra=obj.Y_Barra;
        Yneg_Barra=obj.Y_Barra;
    elseif (strcmp(obj.Tipo{1},'YA') && strcmp(obj.Tipo{1},'Y')) || (strcmp(obj.Tipo{1},'Y') && strcmp(obj.Tipo{1},'YA'))
        if ~strcmp(obj.Tipo{1},'YA')
            prov=prov([2 1]);
        end
        Y0_Barra=zeros(2);
        Ypos_Barra=obj.Y_Barra;
        Yneg_Barra=obj.Y_Barra;
    elseif strcmp(obj.Tipo{1},'Y') && strcmp(obj.Tipo{1},'Y')
        Y0_Barra=zeros(2);
        Ypos_Barra=obj.Y_Barra;
        Yneg_Barra=obj.Y_Barra;
    elseif (strcmp(obj.Tipo{1},'YA') && strcmp(obj.Tipo{1},'D')) || (strcmp(obj.Tipo{1},'D') && strcmp(obj.Tipo{1},'YA'))
        if ~strcmp(obj.Tipo{1},'YA')
            prov=prov([2 1]);
        end
        Y0_Barra=[1 0;0 0]/(1i*obj.X_0);
        Ypos_Barra=[1 -exp(-1i*alpha);-1 exp(-1i*alpha)]/(1i*obj.X_pos);
        Yneg_Barra=[1 -exp(1i*alpha);-1 exp(1i*alpha)]/(1i*obj.X_pos);
    elseif (strcmp(obj.Tipo{1},'Y') && strcmp(obj.Tipo{1},'D')) || (strcmp(obj.Tipo{1},'D') && strcmp(obj.Tipo{1},'Y'))
        if ~strcmp(obj.Tipo{1},'Y')
            prov=prov([2 1]);
        end
        Y0_Barra=zeros(2);
        Ypos_Barra=[1 -exp(-1i*alpha);-1 exp(-1i*alpha)]/(1i*obj.X_pos);
        Yneg_Barra=[1 -exp(1i*alpha);-1 exp(1i*alpha)]/(1i*obj.X_pos);
    elseif strcmp(obj.Tipo{1},'D') && strcmp(obj.Tipo{1},'D')
        Y0_Barra=zeros(2);
        Ypos_Barra=obj.Y_Barra;
        Yneg_Barra=obj.Y_Barra;
    end
    obj.Y0_Barra=Y0_Barra(prov,prov);
    obj.Ypos_Barra=Ypos_Barra(prov,prov);
    obj.Yneg_Barra=Yneg_Barra(prov,prov);
end