classdef Features
    %FEATURES Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        mfcc,
        autoCorrelation,
        lpcc,
        powerSpectrum,
        fourier;
    end
    
    methods
        function obj = Features(frame, fs)
            fourier = fft(frame);
            powerSpectrum = abs(fourier).^2;
            autoCorrelation = ifft(powerSpectrum);
            lpcc = ifft(log(powerSpectrum));
            mfcc = obj.m_mfcc(powerSpectrum, fs, 24).';
            
            obj.mfcc = mfcc; % 1:12
            obj.autoCorrelation = autoCorrelation;
            obj.powerSpectrum = powerSpectrum;
            obj.fourier = fourier;
            obj.lpcc = lpcc;
        end
    end
    
    methods(Static)
        function [ c ] = m_mfcc( power, fs, filterBanksNumber )
            n = size(power,2);
            reducedFft = power(1:1+floor(n/2));
            x=melbankm(filterBanksNumber, n, fs);	        % n is the fft length, p is the number of filters wanted
            z=log(x*reducedFft.');         % multiply x by the power spectrum
            c=dct(z);                   % take the DCT
        end
    end
    
end

