classdef (Abstract) AbstractFeature
    properties (Abstract)
        name;
    end
    properties
        parent;
    end
    
    methods (Abstract)
        feature =  extract(obj, signal)
        
    end
    methods
        function obj = AbstractFeature(parent)
            obj.parent=parent;
        end
        
        function [fMap, sig] = findFeatures(obj, featureMap, signal)
            feature = obj.extract(signal);
            featureMap.put(obj.name, feature);
            [fMap, sig] = obj.parent.findFeatures(featureMap, signal);
        end
    end
    
end

