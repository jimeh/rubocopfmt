# rubocopfmt [![Gem Version](https://badge.fury.io/rb/rubocopfmt.svg)](https://badge.fury.io/rb/rubocopfmt) [![Build Status](https://api.travis-ci.org/jimeh/rubocopfmt.svg)](https://travis-ci.org/jimeh/rubocopfmt)

Easy formatting of Ruby code
using [RuboCop](https://github.com/bbatsov/rubocop). Analogous
to [`gofmt`](https://golang.org/cmd/gofmt/).

Currently the main focus is to provide a simple way to format Ruby code on save
in various editors. As such the feature set is very minimal for the time being.

## Installation

```
gem install rubocopfmt --pre
```

## Usage

```
Usage: rubocopfmt [options] [path ...]

Reads from STDIN if no path is given.

Options:
  -d, --diff               Display diffs instead of rewriting files
  -l, --list               List files whose formatting is incorrect
  -w, --write              Write result to (source) file instead of STDOUT
  -i, --interactive        Disable cops that cause confusion in text editors
  -F, --src-file=<s>       Specify filename when providing input via STDIN
  -D, --diff-format=<s>    Display diffs using format: unified, rcs, context

  -v, --version            Print version and exit
  -h, --help               Show this message
```

## Configure

Please refer to
RuboCop's [Documentation](http://rubocop.readthedocs.io/en/latest/).

## Editor Integration

- Emacs: https://github.com/jimeh/rubocopfmt-emacs
- _More coming soon!_

## Interactive Mode

When called from an editor on save, there's a few of Cops that causes
confusion when run against half-finished code. Interactive mode disables those
cops and should be used by all editor plugins.

Cops disabled in Interactive mode:

- `Lint/Debugger`: Removes `debugger` statements. Not helpful when you need to
  debug something.
- `Lint/UnusedBlockArgument`: Don't prefix unused block variable names with
  `_`. This causes issues if you save after defining a block, but before you use
  all arguments of the block.
- `Lint/UnusedMethodArgument`: Don't prefix unused method variable names with
  `_`. This causes issues if you save after defining a method, but before you
  use all arguments of the method.

## Todo

- More editor integrations!
- "Stable" release
- Improve tests

## License

(The MIT license)

Copyright (c) 2017 Jim Myhrberg.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
