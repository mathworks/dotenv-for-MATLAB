% Copyright 2019-2019 The MathWorks, Inc.

function tests = fileTest
tests = functiontests(localfunctions);
end

function testFileNotFound(testCase)
   d = Dotenv('config/dotenv'); % dosen't exist 
   assertError(testCase, @()d.configure(), 'DOTENV:CannotOpenFile');
end

function testDefaultLocation(testCase)
%% Opens default ./.env file
d = Dotenv();
d.configure();
assert(d.env.DB_HOST == "localhost");
end

function testNamedLocation(testCase)
%% Opens nested .env file
d = Dotenv('../config/.env');
d.configure();
assert(d.env.DB_HOST == "localhost");
end