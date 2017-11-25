classdef Signal
    %SIGNAL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        data;
        fs;
    end
    
    methods
        function obj = Signal(data, fs);
            obj.data = data;
            obj.fs = fs;
        end
    end
    
end

