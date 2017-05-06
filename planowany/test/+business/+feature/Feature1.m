classdef Feature1 < business.feature.AbstractFeature
    properties
        name = 'f1';
    end
    
    methods
        function obj = Feature1(parent)
            obj@business.feature.AbstractFeature(parent);
        end
        function feature =  extract(obj, signal)
            feature = 1;
        end
    end
    
end

