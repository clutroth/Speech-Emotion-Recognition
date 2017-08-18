classdef DataFeatures < matlab.mixin.SetGet
    properties
        energy,
        fundamentalFrequency,
        mfcc1,
        mfcc2,
        mfcc3,
        mfcc4,
        mfcc5,
        mfcc6,
        mfcc7,
        formant1,
        formant2,
        formant3,
        formant4;
    end
    
    methods
        function obj = DataFeatures(l)
            obj.mfcc1 = zeros(l,1);
            obj.mfcc2 = zeros(l,1);
            obj.mfcc3 = zeros(l,1);
            obj.mfcc4 = zeros(l,1);
            obj.mfcc5 = zeros(l,1);
            obj.mfcc6 = zeros(l,1);
            obj.mfcc7 = zeros(l,1);
            obj.energy = zeros(l,1);
            obj.fundamentalFrequency = zeros(l,1);
            obj.formant1 = zeros(l,1);
            obj.formant2 = zeros(l,1);
            obj.formant3 = zeros(l,1);
            obj.formant4 = zeros(l,1);
        end
    end
    
end

