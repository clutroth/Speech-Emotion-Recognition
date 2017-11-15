classdef File
    %FILE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        fileanme;
        fs;
        signal;
    end
    
    methods
        function obj = File(filename)
            [y,fs] = audioread(filename);
            obj.fileanme = filename;
            obj.signal = y;
            obj.fs = fs;
        end
    end
    
end

