close all
clear all
working_dir = '../working_dir/audio_files_summary/';
mkdir(working_dir);
files = dir('/home/wdk/uczelnia/mgr/materiały/agh/Emotive Korpus/*/');
for n=1:size(files,1) 
%     for n=1:size(files,1) 
    fig = figure(1);
    filename = files(n).name;
    if (strcmp(filename, '.') || strcmp(filename, '..'))
        continue
    end
    fullname = strcat(files(n).folder, '/', filename);
    file = toolkit.File(fullname);
    
%     %% opis nagrania
%     description = toolkit.AudioFileDescription(filename);
%     save(strcat(working_dir, filename, '-description.mat'), 'description');
%     %% opis właściwości pliku
%     properties = toolkit.AudioFileProperties(file.signal);
%     save(strcat(working_dir, filename, '-properties.mat'), 'properties');
    %% wykres
    plot(file.signal);
    title(filename, 'Interpreter', 'none');
    axis([0 inf -2 2]);
    print(fig,strcat(working_dir, filename, '-plot.png'),'-dpng');
end
