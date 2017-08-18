classdef AghDescriptor
    properties
        corpusLocation,
        emotions,
    end
% IR - ironia
% NE - stan neutralny
% RA - radość
% SM - smutek
% ST - strach
% ZD - zdziwienie
% ZL - złość
    methods
        function obj = AghDescriptor()
            obj.emotions = containers.Map();
            obj.emotions('IR')='ironia';
            obj.emotions('NE')='stan neutralny';
            obj.emotions('RA')='radość';
            obj.emotions('SM')='smutek';
            obj.emotions('ST')='strach';
            obj.emotions('ZD')='zdziwienie';
            obj.emotions('ZL')='złość';
            obj.corpusLocation='../materiały/agh/Emotive Korpus/*/';
        end
    end
    methods
        function files = listFilenames(obj)
            list = dir(obj.corpusLocation);
            files = cell(sum(~[list.isdir]),1);
            k=1;
            for j = 1:length(list)
                f = list(j);
                if(~(f.isdir))
                    files{k} = strcat(f.folder, filesep, f.name);
                    k = k+1;
                end
            end
        end
        function emotion = decodeEmotion(obj,filename)
            emotion = obj.emotions(filename(end-7:end-6));
        end
        function files = listFiles(obj)
            fileNames = obj.listFilenames();
            files = cell(length(fileNames),1);
            for j = 1:length(fileNames)
                filename = fileNames{j};
                files{j} = model.EmotionalFile( filename,...
                    obj.decodeEmotion(filename));
            end
        end
    end
    
end

