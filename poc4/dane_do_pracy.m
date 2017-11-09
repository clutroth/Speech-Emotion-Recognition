%% Analiza korpusu

filename=@(s,e,t)(strcat( '/home/wdk/uczelnia/mgr/materiały/agh/Emotive Korpus/',e,'/',s,'_',e,'_',t,'.wav'));
standarized = @(f)(toolkit.AudioFileProperties(zscore(f.signal)));

AKL_RA_T = filename('AKL','RA','T')
AKL_RA_T_F = toolkit.File(AKL_RA_T)
AKL_RA_T_N = toolkit.AudioFileProperties(AKL_RA_T_F.signal)
AKL_RA_T_S = standarized(AKL_RA_T_F)