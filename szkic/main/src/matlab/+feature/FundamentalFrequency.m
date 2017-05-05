classdef FundamentalFrequency
    %FUNDAMENTALFREQUENCY Summary of this class goes here
    %   Detailed explanation goes here
    
    properties 
        rapt;
    end
    
    methods
        function obj = FundamentalFrequency(rapt)
            switch nargin
                case 0
                    obj.rapt = fxrapt;% voicebox
                case 1
                     obj.rapt = rapt;
            end

        end
    end
    
end

