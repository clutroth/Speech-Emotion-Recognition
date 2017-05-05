classdef SignalTool
    methods
        function signals = split(obj, signal, duration)
            samplesPerPart = signal.sampleFrequency * duration/1000;
            signalLength = size(signal.data, 2);
            partsNumber = ceil(signalLength/samplesPerPart);
            signalDuration = partsNumber * samplesPerPart;
            extendedSignal = zeros(1, signalDuration);
            extendedSignal(:,1:size(signal.data,2)) = signal.data(:,:);
            splitedSignal = reshape(extendedSignal, ...
                [samplesPerPart, partsNumber]);
            splitedSignal = splitedSignal.';
            signals(1:size(splitedSignal, 1)) = model.Signal(0,0);
            for i = 1:size(splitedSignal, 1)
                signals(i)= model.Signal(splitedSignal(i,:), signal.sampleFrequency);
            end
        end
    end
    
end

