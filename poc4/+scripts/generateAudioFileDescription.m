close all
clear all
files = dir('/home/wdk/uczelnia/mgr/materiały/agh/Emotive Korpus/*/');
for n=3:size(files,1) % bez . i ..
    fig = figure(1);
    filename = files(n).name;
    fullname = strcat(files(n).folder, '/', filename);
    file = toolkit.File(fullname);
    properties = toolkit.AudioFileProperties(file.signal);
    plot(file.signal)
    axis([0 inf -2 2])  
    print(fig,strcat('/tmp/', filename, '.png'),'-dpng')
end