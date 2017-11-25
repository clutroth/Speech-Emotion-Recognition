function [ signal ] = fileToSignal( file )
signal = model.Signal(file.data, file.fs);
end

