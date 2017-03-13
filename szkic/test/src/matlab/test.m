close all;
clear all;
import matlab.unittest.TestSuite;
% tested code
addpath '../../../main/src/matlab';
% voicebox library
addpath '../../../main/lib/voicebox';
% test resources
addpath '../../../test/resources';
% create test suite
empatorPackage = TestSuite.fromPackage('empator');

allTests = [empatorPackage];

run(allTests);
