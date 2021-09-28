% Copyright 2019-2019 The MathWorks, Inc.

function tests = valueRetrieveTest
tests = functiontests(localfunctions);
end


function testValidData(testCase)
d = dotenv();
testCase.verifyEqual(d.env.DB_HOST,"localhost");
end


function testInvalidName(testCase)
d = dotenv();
testCase.verifyEqual(d.env.DB_HOSED, "", 'DB_HOSED variable doesn''t exist');
end
