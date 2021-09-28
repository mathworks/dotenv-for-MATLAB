% Copyright 2019-2019 The MathWorks, Inc.

function tests = fileTest
tests = functiontests(localfunctions);
end

function testFileNotFound(testCase)
testCase.verifyError(@() dotenv('config/dotenv'), 'DOTENV:CannotOpenFile', ...
    'Should error properly for file that doesn''t exist');
end

function testDefaultLocation(testCase)
%% Opens default ./.env file
d = dotenv();
testCase.verifyEqual(d.env.DB_HOST, "localhost");
end

function testNamedLocation(testCase)
%% Opens nested .env file
d = dotenv('../config/.env');
testCase.verifyEqual(d.env.DB_HOST, "localhost");
end