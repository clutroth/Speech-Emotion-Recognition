classdef FundamentalFrequency < business.feature.AbstractFeature
    properties
        name = 'f0';
    end
    
    methods
        function obj = FundamentalFrequency(parent)
            obj@business.feature.AbstractFeature(parent);
        end
        function feature =  extract(obj, signal)
            feature = 1;
        end
    end
end

