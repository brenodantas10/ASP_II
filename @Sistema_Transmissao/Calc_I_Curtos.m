function [I] = Calc_I_Curtos( obj )
%Esta função calcula as correntes de Falta para cada tipo de curto em cada
%Barramento
    [Z_0, Z_pos, Z_neg]=obj.Calc_Z_Simetrico;
    obj.I_Falta=zeros(numel(obj.Curto_Bars),5);
    I=obj.I_Falta;
    
    a=exp(1i*2*pi/3);
    T=[1 1 1; 1 a^2 a; 1 a a^2];
    for i=1:numel(obj.Curto_Bars)
        V_th=obj.Curto_Bars{i}(end).V;
        %Calculo do Ia+ Ia0 e Ia- da Falta Bifasica Aterrada
        Ia_pos=V_th/(1/(1/Z_neg(i,i)+1/Z_0(i,i))+Z_pos(i,i));
        Ia_0=-Ia_pos*Z_neg(i,i)/(Z_neg(i,i)+Z_0(i,i));
        Ia_neg=-Ia_pos*Z_0(i,i)/(Z_neg(i,i)+Z_0(i,i));
        
        %Cálculo do restante dos curtos
        obj.I_Falta(i,1)=3*V_th/(Z_0(i,i)+Z_neg(i,i)+Z_pos(i,i));
        obj.I_Falta(i,2)=V_th/(Z_pos(i,i)+Z_neg(i,i))*sqrt(3)*exp(-1i*pi/2);
        obj.I_Falta(i,3)=T(2,:)*[Ia_0; Ia_pos; Ia_neg];
        obj.I_Falta(i,4)=T(3,:)*[Ia_0; Ia_pos; Ia_neg];
        obj.I_Falta(i,5)=obj.Curto_Bars{i}(end).V/Z_pos(i,i);
        obj.I_Falta(i,:)=obj.I_Falta(i,:)./sqrt(3);
        
        I(i,:)=obj.I_Falta(i,:)*(obj.S_base/obj.Curto_Bars{i}(end).V_base);
    end
    
end

