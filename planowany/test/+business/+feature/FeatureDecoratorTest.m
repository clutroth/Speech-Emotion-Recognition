classdef FeatureDecoratorTest < matlab.unittest.TestCase
    properties
        map;
        signal;
    end
    methods(TestMethodSetup)
        function setUp(tc)
            tc.map = model.FeatureMap;
            tc.signal = model.Signal(0,0);
        end
    end
    methods(Test)
        function testFeature1andFeature2(tc)
            f=business.feature.Feature1(...
                business.feature.Feature2(...
                business.feature.BaseFeature));
            [fMap, sig] = f.findFeatures(tc.map , tc.signal);
            expectedMap = model.FeatureMap;
            expectedMap.put('f1', 1);
            expectedMap.put('f2', 2);
            tc.assertEqual(fMap, expectedMap);
            tc.assertEqual(sig, tc.signal);
        end
        function testFeature1(tc)
            f1=business.feature.Feature1(business.feature.BaseFeature);
            [fMap, sig] = f1.findFeatures(tc.map , tc.signal);
            expectedMap = model.FeatureMap;
            expectedMap.put('f1', 1);
            tc.assertEqual(fMap, expectedMap);
            tc.assertEqual(sig, tc.signal);
        end
        function testFeature2(tc)
            f2=business.feature.Feature2(business.feature.BaseFeature);
            [fMap, sig] = f2.findFeatures(tc.map , tc.signal);
            expectedMap = model.FeatureMap;
            expectedMap.put('f2', 2);
            tc.assertEqual(fMap, expectedMap);
            tc.assertEqual(sig, tc.signal);
        end
    end
    
    methods
    end
    
end

