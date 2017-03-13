classdef EmpatorTest < matlab.unittest.TestCase
	properties
		filename;
		frameTime;
	end
	methods
		function verifySignalDuration(testCase, data, sampleFrequency, expectedDuration)
			actualDuration = empator.Empator.signalDuration(data, sampleFrequency);
			testCase.verifyEqual(expectedDuration, actualDuration, ...
				'duration differ than excpected');
		end
	end
	methods(TestMethodSetup)
		function setUp(testCase)
			testCase.filename = 'audio/03a01Fa.wav';
			testCase.frameTime = .25;
		end
	end
	methods (Test)
		function testRecognizeSampleSignal(testCase)
			[data, sampleFrequency] = audioread(filename);
			result = empator.Empator.recognizeSignal(...
				data, sampleFrequency, testCase.frameTime);
			testCase.verifyEqual(result.judgment, empator.BasicEmotions.JOY, ...
				'Judgment is inorrect');
		end
		function testRecognizeSampleFile(testCase)
			result = empator.Empator.recognize(...
				testCase.filename, testCase.frameTime);
			testCase.verifyEqual(result.judgment, empator.BasicEmotions.JOY, ...
				'Judgment is inorrect');
		end
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
	end
end
