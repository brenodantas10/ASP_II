function plot_fase( obj )
%Esta função plota as configurações de uma fase da linha
    hold on
    for j=1:size(obj.geo_fase,1)
        obj.condutor.plot(obj.geo_fase(j,:));
    end
end

