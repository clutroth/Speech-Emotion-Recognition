classdef Signal
    properties
        data;
        sampleFrequency;
    end
    
    methods
        function obj = Signal(data, sampleFrequency)
            obj.data = data;
            obj.sampleFrequency = sampleFrequency;
        end
    end
    
end

