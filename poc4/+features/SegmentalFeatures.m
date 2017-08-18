classdef SegmentalFeatures
    properties
        mfcc,
        autoCorrelation,
        lpcc,
        powerSpectrum,
        fourier,
        lpc,
        energy,
        fundamentalFrequency
        formants;
    end
    
    methods
        function obj = SegmentalFeatures(frame, fs)
            
            
            fourier = fft(frame);
            powerSpectrum = abs(fourier).^2;
%             autoCorrelation = ifft(powerSpectrum);
%             lpcc = ifft(log(powerSpectrum));
            mfcc = obj.m_mfcc(powerSpectrum, fs, 24).';
%             lpc_ = lpc(frame,10);
            energy = sum(frame.^2);
            formants = obj.m_formants(frame, fs);
            fundamentalFrequency = obj.m_fundamentalFreqency(frame, fs);
            
            
            obj.mfcc = mfcc; % 1:12
%             obj.autoCorrelation = autoCorrelation;
%             obj.powerSpectrum = powerSpectrum;
%             obj.fourier = fourier;
%             obj.lpcc = lpcc;
%             obj.lpc = lpc_;
            obj.energy = energy;
            obj.formants = formants;
            obj.fundamentalFrequency = fundamentalFrequency;
        end
    end
    
    methods(Static)
        function ffreq = m_formants(x, fs)
            ncoeff=2+fs/1000;           % rule of thumb for formant estimation
            a=lpc(x,ncoeff);
            % a= lpc_(1:5);
            r=roots(a);                  % find roots of polynomial a
            r=r(imag(r)>0.01);           % only look for roots >0Hz up to fs/2
            ffreq=sort(atan2(imag(r),real(r))*fs/(2*pi)).';
        end
        function [f] = m_fundamentalFreqency(x, fs)
            dt = 1/fs;
            c = cceps(x);
            t = 0:dt:length(x)*dt-dt;
            
            trng = t(t>=2e-3 & t<=10e-3);
            crng = c(t>=2e-3 & t<=10e-3);
            
            [~,I] = max(crng);
            f=1/trng(I);
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

