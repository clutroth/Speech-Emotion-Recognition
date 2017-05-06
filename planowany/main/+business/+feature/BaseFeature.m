classdef BaseFeature < business.feature.AbstractFeature
    properties
        name = 'changeme';
    end
    methods
        function obj = BaseFeature
            obj = obj@business.feature.AbstractFeature(0);
        end
        function feature =  extract(obj, signal)
        end
        function [featureMap, signal] = findFeatures(obj, featureMap, signal)
        end
    end
end

