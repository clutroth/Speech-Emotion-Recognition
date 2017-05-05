classdef EmpatorTest < matlab.unittest.TestCase
	properties
		filename;
		frameTime;
	end
	methods
		function verifySignalDuration(testCase, len, sampleFrequency, expectedDuration)
            data = testCase.mockFrame(len);
			actualDuration = empator.Empator.signalDuration(data, sampleFrequency);
			testCase.verifyEqual(actualDuration, expectedDuration, ...
				'duration differ than excpected');
        end
        function frame = mockFrame(testCase,length)
            frame = zeros(length,1);
        end
	end
	methods(TestMethodSetup)
		function setUp(testCase)
			testCase.filename = '03a01Fa.wav';
			testCase.frameTime = .25;
		end
	end
	methods (Test)
        % recognize
		function testRecognizeSampleSignal(testCase)
			[data, sampleFrequency] = audioread(testCase.filename);
			result = empator.Empator.recognize(...
				data, sampleFrequency, testCase.frameTime);
			testCase.verifyEqual(result.judgment, empator.BasicEmotions.JOY, ...
				'Judgment is inorrect');
		end
% 		function testRecognizeSampleFile(testCase)
% 			result = empator.Empator.recognizeFile(...
% 				testCase.filename, testCase.frameTime);
% 			testCase.verifyEqual(result.judgment, empator.BasicEmotions.JOY, ...
% 				'Judgment is inorrect');
%         endfilename = '03a01Fa.wav';
        % signalDuration
		function testShortSignalDuration(testCase)
			testCase.verifySignalDuration(5, 10, .5);
		end
		function testLongSignalDuration(testCase)
			testCase.verifySignalDuration(50, 10, 5);
		end
		function testEmptySignalDuration(testCase)
			testCase.verifySignalDuration(0, 10, 0);
		end
		function testOneFrameSignalDuration(testCase)
			testCase.verifySignalDuration(10, 10, 1);
        end
        % splitSignal
        function testSplitSignal(testCase)
            signal = ones(100,1);
            frames = empator.Empator.splitSignal(signal, 100, .25);
            testCase.verifyEqual(size(frames), ...
                [4,25],...
                'Signal hasn''t been splited as excpected')
        end
	end
end
