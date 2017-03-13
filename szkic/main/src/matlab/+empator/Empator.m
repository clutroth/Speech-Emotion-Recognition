classdef Empator
	methods (Static)
		function R = recognize(filename, frameTime)
			[Y, FS] = readwav(filename);
			throw(MException('Empator:recognize', 'not impplemented'));
		end
		function duration = signalDuration(data, sampleFrequency)
			duration = size(data, 1) / double(sampleFrequency);
		end
	end
end
