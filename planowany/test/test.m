close all;
clear all;
import matlab.unittest.TestSuite;
addpath ../main/

modelPackage = TestSuite.fromPackage('model');
businessPackage = TestSuite.fromPackage('business');
businessFeaturePackage = TestSuite.fromPackage('business.feature');
allTests = [modelPackage, businessPackage, businessFeaturePackage];
run(allTests);

