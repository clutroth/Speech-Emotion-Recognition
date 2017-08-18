classdef StatisticMap
    properties
        map,
    end
    
    methods
        function obj = StatisticMap(data)
            obj.map = containers.Map();
            fields = properties(class(data));
            metrics = properties('stat.Stats');
            for j = 1:length(fields)
                f = fields{j};
                s = stat.Stats(data.get(f));
                for k = 1:length(metrics)
                    m = metrics{k};
                    obj.map(strcat(f,'_',m)) = s.get(m);
                end
            end
        end
    end
    
end
