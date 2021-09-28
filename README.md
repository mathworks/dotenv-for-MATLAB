# dotenv for MATLAB

> A MATLAB implementation of dotenv

Storing [configuration in the environment](https://12factor.net/config) is one of the tenets of a [12-factor app](https://12factor.net/). dotenv for MATLAB&reg; lets you store configuration data (passwords, API keys, server names, etc.) outside of your code. This lets you share your code without sharing your configuration data.

![screenshot](config/dotenv-compare.png "MATLAB Screenshot")

[![mathworks](https://circleci.com/gh/mathworks/dotenv-for-MATLAB.svg?style=shield)](https://circleci.com/gh/mathworks/dotenv-for-MATLAB)

[![View dotenv-for-MATLAB on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/73988-dotenv-for-matlab)

## Installation

Put `dotenv.m` somewhere on your [search path](https://www.mathworks.com/help/matlab/ref/path.html).

## Usage Example

`dotenv()` will try and load a file named `.env` from the current working folder. Alternatively, you can specify the path with `dotenv('path/to/file.env')`.

`.env`

```perl
# Obligatory XKCD https://xkcd.com/936/
password=correct-horse-battery-staple 
```

`file.m`

```matlab
d = dotenv();
opts = weboptions('HeaderField', ["accept", "any"; "authorization", d.env.password])
url = "https://myurl.com"
response = webread(url, opts);
```

Common places you may need to do this are [`weboptions()`](https://www.mathworks.com/help/matlab/ref/weboptions.html), [working with remote data like S3 buckets](https://www.mathworks.com/help/matlab/import_export/work-with-remote-data.html), the [Database Toolbox](https://www.mathworks.com/help/database/ug/database.odbc.connection.html), or [`ftp()`](https://www.mathworks.com/help/matlab/ref/ftp.html).

## Rules

The parsing engine currently supports the following rules:

* empty lines are skipped
* lines beginning with `#` are treated as comments
* empty values become empty strings (`DB_HOST=` becomes `DBHOST: ''`)
* whitespace is removed from both ends of unquoted values (`DB_HOST=some server` becomes `DB_HOST:'some server'`)
* quoted values are escaped (`DB_PASS=" some password "` becomes `DB_PASS:' some password '`)

Examples are in the [config](config/) directory.

## FAQ

### Should I commit my `.env` file?

No. You should put `*.env` in your `.gitignore` file. [MATLAB.gitignore](https://github.com/github/gitignore/blob/master/Global/MATLAB.gitignore) plus `*.env` is a good start.

## Development Setup

Clone the repository. You can run `runtests('tests')` from the project root to run the [unit test suite](tests/).

## Bugs?

I would love to hear if this breaks on any weird strings or doesn't work the way you expected.
