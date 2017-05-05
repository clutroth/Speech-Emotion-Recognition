close all;
clear all;
import matlab.unittest.TestSuite;
addpath ../main/

modelPackage = TestSuite.fromPackage('model');
applicationPackage = TestSuite.fromPackage('application');
allTests = [modelPackage, applicationPackage];
run(allTests);

