classdef EnergyTest < matlab.unittest.TestCase
    properties
        feature;
    end
    methods(TestMethodSetup)
        function setUp(tc)
            tc.feature = business.feature.Energy(0);
        end
    end
    methods(Test)
        function testEnergySimple(tc)
            tc.verifyEnergy([1 1], 2);
        end
        function testEnergyBig(tc)
            tc.verifyEnergy([2 2], 8);
        end
        function testEnergyMinus(tc)
            tc.verifyEnergy([2 -2], 8);
        end
    end
    methods
        function verifyEnergy(tc, sig, energy)
            f = tc.feature.extract(model.Signal(sig, 1));
            tc.assertEqual(f, energy);
        end
    end
    
end

