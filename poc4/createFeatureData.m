function [ data ] = createFeatureData( data, segmental, supraSegmental )
data.fundamentalFrequency = supraSegmental.fundamentalFrequency;
for j = 1:length(segmental)
    seg = segmental(j).Value;
    data.mfcc1(j) = seg.mfcc(1,1);
    data.mfcc2(j) = seg.mfcc(1,2);
    data.mfcc3(j) = seg.mfcc(1,3);
    data.mfcc4(j) = seg.mfcc(1,4);
    data.mfcc5(j) = seg.mfcc(1,5);
    data.mfcc6(j) = seg.mfcc(1,6);
    data.mfcc7(j) = seg.mfcc(1,7);
    data.energy(j) = seg.energy;
    data.fundamentalFrequency(j) = seg.fundamentalFrequency;
    data.formant1(j) = seg.formants(1,1);
    data.formant2(j) = seg.formants(1,2);
    data.formant3(j) = seg.formants(1,3);
    data.formant4(j) = seg.formants(1,4);
end
end

