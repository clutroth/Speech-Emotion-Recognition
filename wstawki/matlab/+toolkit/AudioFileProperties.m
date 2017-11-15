classdef AudioFileProperties
    %AUDIOFILEPROPERTIES Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        min;
        max;
        mean;
        standardDeviation;
    end
    
    methods 
        function obj = AudioFileProperties(y)
            obj.min = min(y);
            obj.max = max(y);
            obj.mean = mean(y);
            obj.standardDeviation = std(y);
        end
    end   
end

