classdef AudioFileDescription
    %AUDIOFILEDESCRIPTION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        emotion;
        sex;
        actor;
        symbol;
        type;
        filename;
        speaker;
    end
    
    methods
        function obj = AudioFileDescription(filename)
            nameSegments = strsplit(filename(1:end-4),'_');
            author = cell2mat(nameSegments(1));
            emotion = cell2mat(nameSegments(2));
            type = cell2mat(nameSegments(3));
            obj.filename = filename;
            obj.speaker = author;
            switch emotion
                case 'IR'
                    obj.emotion = 'ironia';
                case 'NE'
                    obj.emotion = 'stan neutralny';
                case 'RA'
                    obj.emotion = 'radosc';
                case 'SM'
                    obj.emotion = 'smutek';
                case 'ST'
                    obj.emotion = 'strach';
                case 'ZD'
                    obj.emotion = 'zdziwienie';
                case 'ZL'
                    obj.emotion = 'zlosc';
            end
            
            switch author
                case 'AKA'
                    obj.sex = 'K';
                    obj.actor = 'A';
                case 'AKL'
                    obj.sex = 'K';
                    obj.actor = 'A';
                case 'HKR'
                    obj.sex = 'K';
                    obj.actor = 'N';
                case 'MMA'
                    obj.sex = 'K';
                    obj.actor = 'A';
                case 'MIG'
                    obj.sex = 'K';
                    obj.actor = 'N';
                case 'BTO'
                    obj.sex = 'K';
                    obj.actor = 'N';
                case 'JMI'
                    obj.sex = 'M';
                    obj.actor = 'A';
                case 'MCH'
                    obj.sex = 'M';
                    obj.actor = 'A';
                case 'MGR'
                    obj.sex = 'M';
                    obj.actor = 'A';
                case 'MPO'
                    obj.sex = 'M';
                    obj.actor = 'N';
                case 'PJU'
                    obj.sex = 'M';
                    obj.actor = 'N';
                case 'PKE'
                    obj.sex = 'M';
                    obj.actor = 'A';
            end
            switch type
                case 'C'
                    obj.type = 'cyfry';
                case 'P'
                    obj.type = 'polecenia';
                case 'T'
                    obj.type = 'tekst ciagly';
                case 'Z'
                    obj.type = 'zdania';
            end
        end
    end
    
end

