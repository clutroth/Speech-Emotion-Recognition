classdef File
    %FILE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        fileanme;
        fs;
        data;
    end
    
    methods
        function obj = File(filename)
            [y,fs] = audioread(filename);
            obj.fileanme = filename;
            obj.data = y;
            obj.fs = fs;
        end
    end
    
end

