classdef FeatureMap
    properties(Access=private)
        map;
    end
    
    methods
        function obj = FeatureMap
            obj.map = containers.Map('KeyType','char','ValueType','double');
        end
        function val = get(obj, key)
            val = obj.map(key);
        end
        function []=put(obj, key, value)
            obj.map(key) = value;
        end
    end
    
end

