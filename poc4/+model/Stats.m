classdef Stats  < matlab.mixin.SetGet
    properties
        mean,
        variance,
        minimum,
        range,
        skewness,
        kurtosis,
    end
    
    methods
        function obj = Stats(raw)
            obj.variance=var(raw);
            obj.minimum=min(raw);
            obj.range=max(raw)-obj.minimum;
            obj.skewness=skewness(raw);
            obj.kurtosis=kurtosis(raw);
            obj.mean = mean(raw);
        end
    end
    
end

