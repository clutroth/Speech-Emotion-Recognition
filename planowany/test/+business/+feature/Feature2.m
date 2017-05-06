classdef Feature2 < business.feature.AbstractFeature
    properties
        name = 'f2';
    end
    
    methods
        function obj = Feature2(parent)
            obj@business.feature.AbstractFeature(parent);
        end
        function feature =  extract(obj, signal)
            feature = 2;
        end
    end
    
end

