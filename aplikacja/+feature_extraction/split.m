function frames = split(signal, duration)
frameLength = int16(signal.fs * duration / 1000);
frames = enframe(signal.data.', frameLength);
1
% h = hamming(frameLength);
% hamminged= frames .* h.';
end