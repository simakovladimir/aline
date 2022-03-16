# Line-by-Line Text Justification Tool

## Summary

`aline` is primarily designed to be used along with Unix `strfile` utility. For a
given  text file containing a list of "one-liners" separated with line breaks,
it  produces  a new text file containing "multi-liners" separated with special
character  (typically,  "%").  Each  "multi-liner"  in the new file represents
corresponding word-wrapped and width aligned line from the initial file

## Usage

The tool may be used as both R-function and Unix commandline utility (provided that R
suite is installed and visible within the system). In the second case, make sure the
file `aline.R` to be symlinked into PATH-recognizable `*/bin/` directory under the name
`aline` and flagged with "executable" attribute

### R Shell:

```
source("./aline.R")
aline.kernel(ipath, opath, affix, hitch, width)
```

### Unix Shell:

```
aline [--ipath|-i <value>] \
      [--opath|-o <value>] \
      [--affix|-a <value>] \
      [--hitch|-h <value>] \
      [--width|-w <value>]
```

## Arguments

`ipath` specifies either  connection  (in R environment) or path to a file (in
both  R  and  OS  environments)  considered  as  an input stream (data will be
catched  from  `stdin`  if  `ipath` is skipped); `opath` is the place where resulted
text  will  be put, provided the same assumptions as for `ipath` (result will be
piped  to `stdout` if `opath` is skipped); `affix` is a character string (typically,
a  comment character) to be attached at the beginning of each line, by default
is  skipped;  `hitch`  is  a  character  string  (typically, a single character)
separating  final  "multi-liners"  from each other (by default, no symbols are
being  inserted between resulting text blocks); `width` is an integer specifying
the maximal line width for the resulted text (80 is default value)

## Value

If  no  errors  occurred, `aline.kernel()` returns character vector with processed
lines invisibly, whereas `aline.R` returns zero exit code

## Example

To convert a text file `./flashes` into the fortune cookie file `./fortunes`,
ready to be processed by `strfile` and used with the fortune program, use
the following code

### R Shell:

```
aline.kernel("./flashes", "", "./fortunes", "%", 70L)
```

### Unix Shell:

```
aline -i ./flashes -o ./fortunes -h "%", -w 70
```

## License

MIT License
