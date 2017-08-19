close all
clear all
parpool(8)
addpath ./lib/voicebox/

a = analysis.SpeechAnalysis();
aghCorpus = a.analyse(AghDescriptor());
save(strcat('working_dir/agh_features_statistics-', datestr(datetime)),'aghCorpus');