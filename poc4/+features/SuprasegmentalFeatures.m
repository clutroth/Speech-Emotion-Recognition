classdef SuprasegmentalFeatures
    properties
        fundamentalFrequency;
    end
    
    methods
        function obj = SuprasegmentalFeatures(x, fs)
            fundamentalFrequency = obj.m_fundamentalFreqency(x, fs);
            
            obj.fundamentalFrequency = fundamentalFrequency;
        end
    end
    
    methods(Static)
        function [f] = m_fundamentalFreqency(x, fs)
            dt = 1/fs;
            c = cceps(x);
            t = 0:dt:length(x)*dt-dt;
            
            trng = t(t>=2e-3 & t<=10e-3);
            crng = c(t>=2e-3 & t<=10e-3);
            
            [~,I] = max(crng);
            f=1/trng(I);
        end
    end
    
end

