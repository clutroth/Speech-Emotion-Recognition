classdef Speech
    properties
        features,
        emotion,
        source,
    end
    
    methods
        function obj = Speech(features, emotion, source)
            obj.features = features;
            obj.emotion = emotion;
            obj.source = source;
        end
    end
    
end

