function Calc_RLC(obj)
   %LEIA -- IMPORTANTE
    %
    %
    %Esta função calcula a resistencia R, indutancia L e capacitancia C da
    %linha de transmissão de acordo com os seguintes parâmetros
    %
    %raio       => raio do condutor
    %geo_fase   => geometria das germinações de uma fase
    %geo_linha  => geometria das fases da linha de transmissão
    %mu_r       => é a permeabilidade do meio condutor
    %pho        => é o inverso da condutância do condutor
    %
    %Obs:As colunas das geometrias são as posições, as linhas são os condutores
    %NUNCA TROQUE
    %
    %
    %prod: a função prod multiplica os elementos de mesma coluna
    %
    %LEIA -- IMPORTANTE

    %pegando o numero de germinações
    n_ger=size(obj.geo_fase,1);

    %pegando numero de fases
    n_fases=size(obj.geo_linha,1);

    %calculando o angulo entre fases e fase referência
    alpha=2*pi*(0:(n_fases-1))/n_fases;

    %calculando as distâncias entre condutores de mesma fase
    d=dist(obj.geo_fase,obj.geo_fase');

    %Calculando a multiplicação de distancias de mesma fase para cada germinação
    d_prod=prod(d+obj.raio*eye(size(d)));

    %calculando Distâncias entre Fases
    D=dist(obj.geo_linha,obj.geo_linha');

    %Deslocar linhas para que os elementos da diagonal principal fiquem na
    %primeira coluna da matriz, para facilitar as multiplicações
    %
    % |d a b|     |d a b|
    % |c d e| =>  |d e c|
    % |f g d|     |d f g|
    %
    D_ref=zeros(size(D));
    D_ref(1,:)=D(1,:);
    for i=2:n_fases
        D_ref(i,:)=[D(i,i:n_fases) D(i,1:(i-1))];
    end
    %calculando a multiplicação das distancia em relação à fases de angulos
    %opostos

    D_prod=prod(D_ref);

    %calculando a soma do valor dos logaritmos necessários para a transposição
    log_sum=cos(alpha(2:n_fases))*log(D_prod(2)./D_prod(2:n_fases))';

    %Calculando a Resistencia
    obj.R=obj.pho/(n_ger*pi*obj.raio^2);

    %calculando a indutância de cada germinação
    L=2e-7*(log(D_prod(2)^(n_ger/n_fases)./(d_prod.*exp(-obj.mu_r/4))) + n_ger*log_sum/n_fases );

    %calculando a indutancia equivalente da linha
    obj.L=1/sum(1./L);

    %calculando a capacitância de cada germinação
    C=1e-9/18./(log(D_prod(2)^(n_ger/n_fases)./(d_prod)) + n_ger*log_sum/n_fases );

    %Calculando a capacitância equivalente
    obj.C=sum(C);
    
end 