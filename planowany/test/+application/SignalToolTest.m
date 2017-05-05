classdef SignalToolTest < matlab.unittest.TestCase
    properties
        tool;
    end
    methods(TestMethodSetup)
        function setUp(tc)
            tc.tool = business.SignalTool;
        end
    end
    methods(Test)
        function test2HzfrequencySampleSplit(tc)
            sig = model.Signal([1 2 3], 2);
            actual = tc.tool.split(sig, 1000);
            tc.assertEqual(actual, ...
                [model.Signal([1 2],2),...
                model.Signal([3 0],2)]);
        end
        function testSplitTo3(tc)
            sig = model.Signal([1 2 3 4 5], 1);
            actual = tc.tool.split(sig, 3000);
            tc.assertEqual(actual, ...
                [model.Signal([1 2 3],1),...
                model.Signal([4 5 0],1)]);
        end
        function test1HzfrequencySampleSplit(tc)
            sig = model.Signal([1 2 3 4], 1);
            actual = tc.tool.split(sig, 1000);
            tc.assertEqual(actual, ...
                [model.Signal(1,1),...
                model.Signal(2,1),...
                model.Signal(3,1),...
                model.Signal(4,1)]);
        end
    end
end

