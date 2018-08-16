function [Z_0, Z_pos, Z_neg] = Calc_Z_Simetrico( obj )
%Esta função calcula a matriz de impedância para realizar cálculos de
%estudo de curto-circuto do sistema
    Y_pos=zeros(numel(obj.Curto_Bars));
    Y_neg=Y_pos;
    Y_0=Y_pos;
    
    for l=1:numel(obj.Linhas)
        for k=1:numel(obj.Curto_Bars)
            for m=1:numel(obj.Curto_Bars{k})
                if obj.Curto_Bars{k}(m)==obj.Linhas{l}.Bar{1}
                    i=k;
                elseif obj.Curto_Bars{k}(m)==obj.Linhas{l}.Bar{2}
                    j=k;
                end
            end
        end
        if i~=j
            if isa(obj.Linhas{l},'Linha_Transmissao')
                Y_pos([i j],[i j])=Y_pos([i j],[i j])+obj.Linhas{l}.Y_Barra./obj.Linhas{l}.Bar{1}.Y_base;
                Y_neg([i j],[i j])=Y_neg([i j],[i j])+obj.Linhas{l}.Y_Barra./obj.Linhas{l}.Bar{1}.Y_base;
                Y_0([i j],[i j])=Y_0([i j],[i j])+obj.Linhas{l}.Y_Barra./obj.Linhas{l}.Bar{1}.Y_base;
            elseif isa(obj.Linhas{l},'Transformador')
                Y_pos([i j],[i j])=Y_pos([i j],[i j])+obj.Linhas{l}.Ypos_Barra;
                Y_neg([i j],[i j])=Y_neg([i j],[i j])+obj.Linhas{l}.Yneg_Barra;
                Y_0([i j],[i j])=Y_0([i j],[i j])+obj.Linhas{l}.Y0_Barra;
            end
        end
    end
    for k=1:numel(obj.Curto_Bars)
        for m=1:numel(obj.Curto_Bars{k})
            if strcmp(obj.Curto_Bars{k}(m).Tipo,'Carga')
                Y=conj(obj.Curto_Bars{k}(m).S_p/abs(obj.Curto_Bars{k}(m).V)^2);
                Y_pos(k,k)=Y_pos(k,k)+Y;
                Y_neg(k,k)=Y_neg(k,k)+Y;
                Y_0(k,k)=Y_0(k,k)+Y;
            elseif strcmp(obj.Curto_Bars{k}(m).Tipo,'V_Ctrl_Cap')
                Y=obj.Curto_Bars{k}(m).S_g/abs(obj.Curto_Bars{k}(m).V)^2;
                Y_pos(k,k)=Y_pos(k,k)+Y;
                Y_neg(k,k)=Y_neg(k,k)+Y;
                Y_0(k,k)=Y_0(k,k)+Y;
            elseif strcmp(obj.Curto_Bars{k}(m).Tipo,'V_Ctrl') || strcmp(obj.Curto_Bars{k}(m).Tipo,'Slack')
                if obj.Curto_Bars{k}(m).Zg==0
                    Y_pos(k,k)=Y_pos(k,k)+1e15*exp(-1i*pi/4);
                    Y_neg(k,k)=Y_neg(k,k)+1e15*exp(-1i*pi/4);
                else
                    Y_pos(k,k)=Y_pos(k,k)+1/obj.Curto_Bars{k}(m).Zg;
                    Y_neg(k,k)=Y_neg(k,k)+1/obj.Curto_Bars{k}(m).Zg;
                end
                if obj.Curto_Bars{k}(m).Zg==0 && obj.Curto_Bars{k}(m).Zn==0
                    Y_0(k,k)=Y_0(k,k)+1e15*exp(-1i*pi/4);
                else
                    Y_0(k,k)=Y_0(k,k)+1/(obj.Curto_Bars{k}(m).Zg+3*obj.Curto_Bars{k}(m).Zn);
                end
            end
        end
    end
    
    Z_0=Y_0^-1;
    Z_pos=Y_pos^-1;
    Z_neg=Y_neg^-1;
end

