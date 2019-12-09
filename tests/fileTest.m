% Copyright 2019-2019 The MathWorks, Inc.

function tests = fileTest
tests = functiontests(localfunctions);
end

function testFileNotFound(testCase)
try
    d = Dotenv('config/dotenv'); % dosen't exist
catch ME
    assert(string(ME.identifier) == 'DOTENV:CannotOpenFile');
end
end

function testDefaultLocation(testCase)
%% Opens default ./.env file
d = Dotenv();
assert(d.env.DB_HOST == "localhost");
end

function testNamedLocation(testCase)
%% Opens nested .env file
d = Dotenv('../config/.env');
assert(d.env.DB_HOST == "localhost");
end