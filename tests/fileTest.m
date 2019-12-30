% Copyright 2019-2019 The MathWorks, Inc.

function tests = fileTest
tests = functiontests(localfunctions);
end

function testFileNotFound(testCase)
try
    d = dotenv('config/dotenv'); % dosen't exist
catch ME
    assert(string(ME.identifier) == 'DOTENV:CannotOpenFile');
end
end

function testDefaultLocation(testCase)
%% Opens default ./.env file
d = dotenv();
assert(d.env.DB_HOST == "localhost");
end

function testNamedLocation(testCase)
%% Opens nested .env file
d = dotenv('../config/.env');
assert(d.env.DB_HOST == "localhost");
end