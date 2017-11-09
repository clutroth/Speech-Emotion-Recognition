clear all

addpath ./lib/voicebox/
% emocje IR NE RA SM ST ZD ZL
% mówca AKA AKL HKR JMI MCH MGR MIG MMA MPO PJU PKE
% wypowiedzi C P T Z
%% Params
% filename=@(s,e,t)(strcat( '/home/wdk/uczelnia/mgr/materiały/agh/Emotive Korpus/',e,'/',s,'_',e,'_',t,'.wav'));
% AKL_RA_T = filename('AKL','RA','T');
% JMI_ST_C = filename('JMI','ST','C');
% JMI_ST_T = filename('JMI','ST','T');
% AKL_RA_C = filename('AKL','RA','C');


toolkit.audioFilePresentation(toolkit.filename('RA', 'AKL', 'T'))
