classdef Empator
	methods (Static)
		function R = recognize(Y, FS, frameDuration)
            frames = empator.Empator.splitSignal(Y, FS, frameDuration);
			throw(MException('Empator:recognize', 'not impplemented'));
		end
		function duration = signalDuration(data, sampleFrequency)
			duration = size(data, 1) / sampleFrequency;
        end
        function frames = splitSignal(signal, rate, frameDuration)
            n=rate * frameDuration;
            frames = enframe(signal,hamming(n,'periodic'),...
                n);
        end
	end
end
