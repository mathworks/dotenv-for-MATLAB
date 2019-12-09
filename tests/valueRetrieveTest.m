% Copyright 2019-2019 The MathWorks, Inc.

function tests = valueRetrieveTest
tests = functiontests(localfunctions);
end


function testValidData(testCase)
d = Dotenv();
d.configure();
assert(d.env.DB_HOST == "localhost");
end


function testInvalidName(testCase)
d = Dotenv();
d.configure();
assert(d.env.DB_HOSED == ""); % doesn't exist
end
