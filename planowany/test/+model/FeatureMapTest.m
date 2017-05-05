classdef FeatureMapTest < matlab.unittest.TestCase
    %FEATUREMAPTEST Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        map
    end
    
    methods(TestMethodSetup)
        function setUp(testCase)
            testCase.map = model.FeatureMap;
        end
    end
    methods(Test)
        function putPair(testCase)
            m = testCase.map;
            m.put('lol', 1.23);
            val = m.get('lol');
            testCase.verifyEqual(val, 1.23, 'value differ expected');
        end
        function errorOnIntKey(testCase)
            m = testCase.map;
            testCase.verifyError(@()(m.put(1, 1.23)),...
                'MATLAB:Containers:TypeMismatch');
        end
        function errorOnCharValue(testCase)
            m = testCase.map;
            testCase.verifyError(@()(m.put('dsa', '1.23')),...
                'MATLAB:Containers:TypeMismatch');
        end
    end
    
end

