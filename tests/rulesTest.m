% Copyright 2019-2019 The MathWorks, Inc.

function tests = rulesTest()
%Rules Test tests expected behavoir of .env config
%   See https://github.com/motdotla/dotenv#rules
tests = functiontests(localfunctions);
end

function testTopComment(testCase)
% Tests that lines starting with # are skipped
% specifically tests first line comment
d = dotenv('../config/topcomment.env');
assert(numel(fieldnames(d.env)) == 3);
end

function testMiddleComment(testCase)
% Tests that lines starting with # are skipped
% specifically tests interior comment
d = dotenv('../config/middlecomment.env');
assert(numel(fieldnames(d.env)) == 3);
end

function testBottomComment(testCase)
% Tests that lines starting with # are skipped
% specifically tests last line comment
d = dotenv('../config/bottomcomment.env');
assert(numel(fieldnames(d.env)) == 3);
end

function testBlankLines(testCase)
d = dotenv('../config/blanklines.env');
assert(numel(fieldnames(d.env)) == 4);
end

function testEqualsInPassword(testCase)
d = dotenv('../config/equalPassword.env');
assert("s1mpl3=123" == d.env.DB_PASS);
end

function testWhitespaceValue(testCase)
d = dotenv('../config/whitespace.env');
assert("localhost server" == d.env.DB_HOST);
end

function testEmptyValue(testCase)
d = dotenv('../config/empty.env');
assert("" == d.env.DB_HOST);
end

function testUnquotedWhitespace(testCase)
% D.configure should trim leading and trailing whitespace for whitespace values
d = dotenv('../config/whitespace.env');
assert("george" == d.env.DB_USER);
end

function testQuotedValues(testCase)
d = dotenv('../config/whitespace.env');
assert('" mypass "' == d.env.DB_PASS);
end

function testSingleValue(testCase)
d = dotenv('../config/single.env');
assert("localhost" == d.env.DB_HOST);
end


