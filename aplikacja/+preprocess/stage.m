function [ signalOut ] = stage( signalIn)
signalOut = model.Signal(zscore(signalIn.data), signalIn.fs);
end

