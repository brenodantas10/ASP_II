function jacob = Jacobiana ( obj, V, bool_P, bool_Q, bool_V, bool_Ang )
%Esta função calcula a jacobiana do sistema para ser usado no método
%iterativo de Newton-Rapsh.
    
    eye_prov=logical(eye(numel(obj.Curto_Bars)));
    %Calculando Matriz Jacobiana Provisória
    
    %Em relação à angulo(V)
    jacob_grande_ang=(-1i)*V.*conj(obj.Y_Barra.*V');
    jacob_grande_ang(eye_prov)=(1i)*(V.*conj(obj.Y_Barra*V))+jacob_grande_ang(eye_prov);
    
    %Em relação à |V|
    jacob_grande_v=V.*conj(obj.Y_Barra.*V');
    jacob_grande_v(eye_prov)=V.*conj(obj.Y_Barra*V)+jacob_grande_v(eye_prov);
    
%     %Recorrigindo |V|
%     jacob_grande_v=jacob_grande_v./V';
    
    %Pegando pelos parâmetros Fixos e Variáveis
    PV=real(jacob_grande_v(bool_P,bool_V));
    PAng=real(jacob_grande_ang(bool_P,bool_Ang));
    
    QV=imag(jacob_grande_v(bool_Q,bool_V));
    QAng=imag(jacob_grande_ang(bool_Q,bool_Ang));
    
    %Calculando Jacobiana em tamanho real
    jacob=[PAng PV; QAng QV];
end

