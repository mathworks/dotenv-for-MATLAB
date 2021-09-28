# Config files

## [.env](.env)

Shows basic functionality including the ability to comment out entries.

## [blanklines.env](blanklines.env)

Blank lines should be skipped.

## [bottomcomment.env](bottomcomment.env)

Comments should be ignored even if they're they last entry.

## [empty.env](empty.env)

A key doesn't have to have a value. `MYHOST=` should resolve to a kv pair of `'MYHOST': ''`

## [equalPassword.env](equalPassword.env)

If there is more than one `=` in an entry the kv pair splits on the first `=`.

`DB_PASS=s1mpl3=123` resolves to a kv pair of `DB_PASS:s1mpl3=123`. **Not**  `DB_PASS=s1mpl3: 123`

## [middleComment.env](middleComment.env)

Comments in the middle of a set of entries have no effect. Tests to ensure that succeeding entries still get processed.

## [single.env](single.env)

To test functonality for a single entry.

## [specialchars.env](specialchars.env)

Values with a space preserve the space. `DB_HOST=some server` becomes `DB_HOST:'some server'`.

## [topcomment.env](topcomment.env)

Comments should have no effect. Tests functionality if the first entry is commented out.

## [whitespace.env](whitespace.env)

Whitespace is ignored.
