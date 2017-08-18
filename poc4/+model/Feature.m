classdef Feature
    properties
        value,
        statistics,
        name
    end
    
    methods
        function obj = Feature(value,statistics,name)
            obj.value = value;
            obj.statistics = statistics;
            obj.name = name;
        end
    end
    
end

