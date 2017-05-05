fclose all;
clear all;
import matlab.unittest.TestSuite;
% tested code
addpath '../../../main/src/matlab';
% voicebox library
addpath '../../../main/lib/voicebox';
% test resources
RESOURCES = '../../../test/resources/audio';
addpath(RESOURCES);
% create test suite
empatorPackage = TestSuite.fromPackage('empator');
featurePackage = TestSuite.fromPackage('feature');
allTests = [empatorPackage, featurePackage];

run(allTests);
