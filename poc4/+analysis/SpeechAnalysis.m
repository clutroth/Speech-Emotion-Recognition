classdef SpeechAnalysis
    properties
        frameLength,
    end
    
    methods
        function obj = SpeechAnalysis()
            obj.frameLength = 200;
        end
        function analysedSpeach=analyse(obj,corpus)
            files = corpus.listFiles();
            analysedSpeach = cell(size(files));
            parpool(8)
            parfor j = 1:length(files)
                file = files{j};
                j, file,
                [signal, fs] = obj.read(file.filename);
                frames = obj.split(signal, obj.frameLength);
                featuresData = obj.extractFeatures(frames, signal, fs);
                analysedSpeach{j} = obj.createSpeech(featuresData, file);
            end
        end
    end
    methods(Static)
        function data = extractFeatures(frames, signal, fs)
            framesNumber = size(frames,1);
            segmentalFeatures = ObjectArray(framesNumber);
            suprasegmentalFeatures = features.SuprasegmentalFeatures(signal, fs);
            for j = 1:framesNumber
                frame = frames(j,:);
                segmentalFeatures(j).Value = features.SegmentalFeatures(frame, fs);
            end
            data = createFeatureData(features.DataFeatures(framesNumber),...
                segmentalFeatures,...
                suprasegmentalFeatures);
        end
        
        function hamminged = split(signal, frameLength)
            frames = enframe(signal, frameLength);
            h = hamming(frameLength);
            hamminged= frames .* h.';
        end
        function [signal, fs] = read(filename)
            [y,fs] = audioread(filename);
            preemphasisFilter = @(x)(filter( [1 -.97], 1, x ));
            y = y(:,1);
            signal = preemphasisFilter(y);
        end
        function speech = createSpeech(data, file)
            fields = properties(class(data));
            features = containers.Map();
            for j = 1:length(fields)
                f = fields{j};
                v = data.get(f);
                s = model.Stats(v);
                features(f) = model.Feature(v, s, f);
            end
            speech = model.Speech(features, file.emotion, file.filename);
        end
    end
    
end

