classdef FundamentalFrequency < business.feature.AbstractFeature
    properties
        name = 'f0';
    end
    
    methods
        function obj = FundamentalFrequency(parent)
            obj@business.feature.AbstractFeature(parent);
        end
        function feature =  extract(obj, signal)
            y=signal.data;
            Fs=signal.sampleFrequency;
            ydft = fft(y);
            freq = 0:Fs/length(y):Fs/2;
            ydft = ydft(1:floor(length(y)/2)+1);
            [~,idx] = max(abs(ydft));
            feature = freq(idx);
        end
    end
end

