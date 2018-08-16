function plot( obj )
%Esta função plota a linha de transmissão
    hold on
    for i=1:size(obj.geo_linha,1)
        for j=1:size(obj.geo_fase,1)
            obj.condutor.plot(obj.geo_linha(i,:)+obj.geo_fase(j,:));
        end
    end
end

