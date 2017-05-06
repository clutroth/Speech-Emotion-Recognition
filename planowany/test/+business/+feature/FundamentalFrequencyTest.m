classdef FundamentalFrequencyTest < matlab.unittest.TestCase
    properties
        feature;
        signal;
    end
    methods(TestMethodSetup)
        function setUp(tc)
            tc.feature = business.feature.FundamentalFrequency(0);
            tc.signal = model.Signal(tc.makeSignal(123), 1000);
        end
    end
    methods
        function y = makeSignal(tc, f)
            t = 0:0.001:1;
            y = cos(2*pi*f*t)+randn(size(t));
        end
    end
    methods(Test)
        function testFF(tc)
            f = tc.feature.extract(tc.signal);
            tc.assertEqual(f, 123, 'RelTol', 1e-2);
        end
    end
    
end

