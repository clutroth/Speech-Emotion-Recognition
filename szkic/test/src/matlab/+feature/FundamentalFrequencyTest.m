
classdef FundamentalFrequencyTest < matlab.unittest.TestCase
    %FUNDAMENTALFREQUENCY Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        ff;
    end
    methods(TestMethodSetup)
        function setUp(testCase)
            raptMock = @(X, Fs)(440);
            testCase.ff = feature.FundamentalFrequency(raptMock);
        end
    end
    methods (Test)
        
        % recognize
        function testFundamentalFrequency(testCase)
            import matlab.unittest.constraints.IsEqualTo
            import matlab.unittest.constraints.RelativeTolerance
            f = 100;
            fs = 7400;
            duration = 5;
            t = testCase.tone(f, fs, duration);
            actual=testCase.ff(t, fs);
            testCase.verifyThat(actual, IsEqualTo(f, 'Within',...
                RelativeTolerance(.1)));
            
        end
    end
    methods
        function y = tone(testCase, f, fs, duration)
            t = 0:1/fs:duration;
            y = sin(2.*pi.*f.*t);
        end
    end
    
end

