classdef EmotionalFile  
    properties
        filename,
        emotion,
    end
    
    methods
        function obj = EmotionalFile(filename, emotion)
            obj.filename = filename;
            obj.emotion = emotion;
        end
    end
    
end

