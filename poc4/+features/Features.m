classdef Features
    properties
        mfcc,
        autoCorrelation,
        lpcc,
        powerSpectrum,
        fourier,
        lpc,
        energy,
        fundamentalFrequency;
    end
    
    methods
        function obj = Features(frame, fs)
            
            
            fourier = fft(frame);
            powerSpectrum = abs(fourier).^2;
            autoCorrelation = ifft(powerSpectrum);
            lpcc = ifft(log(powerSpectrum));
            mfcc = obj.m_mfcc(powerSpectrum, fs, 24).';
            lpc_ = lpc(frame,10);
            energy = sum(frame.^2);
            cepstrum=cceps(frame);
            fundamentalFrequency = obj.m_fundamentalFreqency(frame, fs);
            
            obj.mfcc = mfcc; % 1:12
            obj.autoCorrelation = autoCorrelation;
            obj.powerSpectrum = powerSpectrum;
            obj.fourier = fourier;
            obj.lpcc = lpcc;
            obj.lpc = lpc_;
            obj.energy = energy;
            obj.fundamentalFrequency = fundamentalFrequency;
        end
    end
    
    methods(Static)
        function [f] = m_fundamentalFreqency(x, fs)
            ms1=int16(fs/550);                 % maximum speech Fx at 1000Hz
            ms20=int16(min(fs/50,size(x,2)));  % minimum speech Fx at 50Hz
            Y=fft(x);
            C=fft(log(abs(Y)+eps));
            [~,fx]=max(abs(C(ms1:ms20)));
            f=fs/(ms1+fx-1);
        end
        function [ c ] = m_mfcc( power, fs, filterBanksNumber )
            n = size(power,2);
            reducedFft = power(1:1+floor(n/2));
            x=melbankm(filterBanksNumber, n, fs);	        % n is the fft length, p is the number of filters wanted
            z=log(x*reducedFft.');         % multiply x by the power spectrum
            c=dct(z);                   % take the DCT
        end
    end
    
end

