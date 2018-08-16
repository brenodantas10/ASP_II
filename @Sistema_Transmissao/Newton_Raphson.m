function [S_t, V, it, erro]= Newton_Raphson(obj, varargin)
%Esta função Calcula Recursivamente o fluxo de potência do Sistema
%(Necessita executar primeiro o Calc_Y
    %Criando Variáveis necessárias
    bool_P= false(numel(obj.Curto_Bars),1); %Vetor booleano com potencias ativas fixas
    bool_Q=bool_P; %Vetor booleano com potencias reativas fixas
    bool_V=bool_P; %Vetor booleano com voltagem variável
    bool_Ang=bool_P; %Vetor booleano com angulo variável
    V=double(bool_P);
    S_esp=V;
    %Calculando Parâmetros para utilizar na jacobiana
    for i=1:numel(obj.Curto_Bars)
        bool_P(i)=obj.Curto_Bars{i}(end).Fixo(1);     %Potencia Fixa
        bool_Q(i)=obj.Curto_Bars{i}(end).Fixo(2);     %Reatância Fixa
        bool_V(i)= ~obj.Curto_Bars{i}(end).Fixo(3);   %|V| não Fixa
        bool_Ang(i)= ~obj.Curto_Bars{i}(end).Fixo(4); %angulo não Fixo
        
        %Normalizando as tensões iniciais para facilitar calculos
        obj.Curto_Bars{i}(end).V_Write(1);
        for j=1:(numel(obj.Curto_Bars{i})-1)
            obj.Curto_Bars{i}(j).V_Write(obj.Curto_Bars{i}(end).V);
        end
        %Colocando as tensões e potências em vetores afim de agilizar algorítmo
        V(i)=obj.Curto_Bars{i}(end).V;
        S_esp(i)=obj.Curto_Bars{i}(end).S_t;
    end
    
    %Definição de número de iterações, se não há então será baseado em erro
    if nargin==1
        n=inf;
        p=1;
    elseif nargin==2 && numel(varargin{1})==1 && round(varargin{1})==varargin{1}
        n=varargin{1};
        p=1;
    elseif nargin==3
        n=varargin{1};
        p=varargin{2};
    else
        error('Muitos Parâmetros ou parâmetro não é tipo double');
    end
    
    %Inicializando erro e contador de iterações
    erro=1;
    it=0;
    
    %Fazendo pré-calculos de alguns valores importantes
    S_calc=V.*conj(obj.Y_Barra*V);
    Delta_S=S_esp-S_calc;
    P_esp=real(S_esp);
    Q_esp=imag(S_esp);
    
    %Separando tensão em módulo e angulo
    V_abs=abs(V);
    V_ang=angle(V);
    
    %Pegando número de |V| variáveis e angulos variáveis
    nv=sum(bool_V);
    nang=sum(bool_Ang);
    
    flag=1;
    %Loop de Cálculos de Newton-Raphson
    while flag
        it=it+1; %Contagem das iterações
        
        %Calculo da Jacobiana
        jacob = obj.Jacobiana(V,bool_P,bool_Q,bool_V,bool_Ang);
        
        %Pegando variações de angulo e |V|
        prov_VAng=(jacob\[real(Delta_S(bool_P)); imag(Delta_S(bool_Q))]); %primeiros elementos são angulos e os seguintes são voltagens
        Delta_Ang= prov_VAng(1:nang)/p;
        Delta_V= prov_VAng((nang+1):(nv+nang))/p;
        
        %Modificando alguns valores de |V| e angulo de acordo com os que
        %são variáveis
        V_abs(bool_V)=V_abs(bool_V).*(1+Delta_V);
        V_ang(bool_Ang)=V_ang(bool_Ang)+Delta_Ang;
        %Unindo módulo e fase num só vetor
        V=V_abs.*exp(1i*V_ang);
        
        %Atualizando potências Considerando apenas as potências
        %não fixas
        S_calc=V.*conj(obj.Y_Barra*V);
        P_esp(~bool_P)=real(S_calc(~bool_P));
        Q_esp(~bool_Q)=imag(S_calc(~bool_Q));
        S_esp=P_esp+1i*Q_esp;
        Delta_S=S_esp-S_calc;
        
        erro=sum(abs(Delta_S));
        if n<inf
            flag=it<n;
        elseif it>1e5 || isnan(erro) || erro==inf
            flag=erro>1e-1;
            if flag || isnan(erro) || erro==inf
                error('Método não está convergindo');
            end
        else
            flag=erro>1e-12;
        end
        
    end
    
    %Atualizando parâmetros nos Barramentos
    for i=1:numel(obj.Curto_Bars)
       obj.Curto_Bars{i}(end).S_Write(S_esp(i));
       obj.Curto_Bars{i}(end).V_Write(V(i));
       for j=1:(numel(obj.Curto_Bars{i})-1)
           obj.Curto_Bars{i}(j).S_Write(obj.Curto_Bars{i}(end).S_t);
           obj.Curto_Bars{i}(j).V_Write(obj.Curto_Bars{i}(end).V);
       end
       
       V(i)=V(i)*obj.Curto_Bars{i}(end).V_base;
    end
    S_t=S_esp*obj.S_base;
    obj.Calc_S_Linhas;
end

