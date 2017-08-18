close all
clear all

a = analysis.SpeechAnalysis();
aghCorpus = a.analyse(AghDescriptor());
save('aghCorpus.dat','aghCorpus');