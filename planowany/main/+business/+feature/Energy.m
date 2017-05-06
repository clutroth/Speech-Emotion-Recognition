classdef Energy < business.feature.AbstractFeature
    properties
        name = 'energy';
    end
    
    methods
        function obj = Energy(parent)
            obj@business.feature.AbstractFeature(parent);
        end
        function feature =  extract(obj, signal)
            data = signal.data;
            feature = sum(data .* data);
        end
    end
end

