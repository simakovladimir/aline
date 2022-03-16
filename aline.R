#! /usr/bin/env Rscript

# Line-by-Line Text Justification Tool
#
# Description
# aline  is primarily designed to be used along with Unix strfile utility. For a
# given  text file containing a list of "one-liners" separated with line breaks,
# it  produces  a new text file containing "multi-liners" separated with special
# character  (typically,  "%").  Each  "multi-liner"  in the new file represents
# corresponding word-wrapped and width aligned line from the initial file
#
# Dependencies
# r-base, getopt
#
# Usage
# R shell
#   aline.kernel(ipath, opath, affix, hitch, width)
# OS shell
#   aline.R [--ipath|-i <value>]
#           [--opath|-o <value>]
#           [--affix|-a <value>]
#           [--hitch|-h <value>]
#           [--width|-w <value>]
#
# Arguments
# ipath  specifies  either  connection  (in R environment) or path to a file (in
# both  R  and  OS  environments)  considered  as  an input stream (data will be
# catched  from  stdin  if  ipath is skipped); opath is the place where resulted
# text  will  be put, provided the same assumptions as for ipath (result will be
# piped  to stdout if opath is skipped); affix is a character string (typically,
# a  comment character) to be attached at the beginning of each line, by default
# is  skipped;  hitch  is  a  character  string  (typically, a single character)
# separating  final  "multi-liners"  from each other (by default, no symbols are
# being  inserted between resulting text blocks); width is an integer specifying
# the maximal line width for the resulted text (80 is default value)
#
# Value
# If  no  errors  occurred, aline.kernel returns character vector with processed
# lines invisibly, whereas aline.R returns zero exit code
#
# Example
# R shell
#   aline.kernel("./flashes", "", "./fortunes", "%", 70L)
# OS shell
#   aline.R -i ./flashes -o ./fortunes -h "%", -w 70
# In  both  cases,  this  will  convert a text file "./flashes" into the fortune
# cookie  file  "./fortunes", ready to be processed by strfile and used with the
# fortune program
#
# Author(s)
# Vladimir Simakov
#
# License
# MIT License

# Copyright 2017 Vladimir Simakov
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.

library(getopt)

aline.kernel <- function(ipath = "stdin",
                         opath = "",
                         affix = "",
                         hitch = character(0L),
                         width = 80L) {
  invisible(
    forceAndCall(
      2L,
      as.function(
        alist(
          check = ,
          result = ,
          forceAndCall(
            1L,
            as.function(
              alist(
                display = ,
                result)),
            cat(
              result,
              file = opath,
              sep = "\n")))),
      stopifnot(
        `==`(
          length(ipath),
          1L),
        `==`(
          length(opath),
          1L),
        `==`(
          length(affix),
          1L),
        `<=`(
          length(hitch),
          1L),
        `==`(
          length(width),
          1L),
        is.character(affix),
        is.character(hitch),
        is.numeric(width),
        `>=`(
          width,
          1L),
        `<`(
          nchar(affix),
          width),
        `<=`(
          nchar(hitch),
          width)),
      sapply(
        readLines(ipath),
        as.function(
          alist(
            entry = ,
            forceAndCall(
              1L,
              as.function(
                alist(
                  splitted = ,
                  forceAndCall(
                    2L,
                    as.function(
                      alist(
                        chief = ,
                        trail = ,
                        paste0(
                          c(
                            paste0(
                              affix,
                              c(
                                chief,
                                trail)),
                            hitch),
                          collapse = "\n"))),
                    as.character(
                      sapply(
                        head(
                          splitted,
                          `-`(1L)),
                        as.function(
                          alist(
                            a.line = ,
                            `if`(
                              `==`(
                                length(a.line),
                                1L),
                              a.line,
                              forceAndCall(
                                2L,
                                as.function(
                                  alist(
                                    size = ,
                                    times = ,
                                    forceAndCall(
                                      2L,
                                      as.function(
                                        alist(
                                          regular = ,
                                          remainder = ,
                                          paste0(
                                            a.line,
                                            c(
                                              sapply(
                                                `+`(
                                                  rep_len(
                                                    regular,
                                                    times),
                                                  c(
                                                    rep_len(
                                                      1L,
                                                      remainder),
                                                    rep_len(
                                                      0L,
                                                      `-`(
                                                        times,
                                                        remainder)))),
                                                as.function(
                                                  alist(
                                                    n = ,
                                                    paste0(
                                                      rep(
                                                        " ",
                                                        n),
                                                      collapse = ""))),
                                                USE.NAMES = FALSE),
                                              ""),
                                            collapse = ""))),
                                      `%/%`(
                                        size,
                                        times),
                                      `%%`(
                                        size,
                                        times)))),
                                `-`(
                                  `-`(
                                    width,
                                    sum(nchar(a.line))),
                                  nchar(affix)),
                                `-`(
                                  length(a.line),
                                  1L))))),
                        USE.NAMES = FALSE)),
                    paste0(
                      unlist(
                        tail(
                          splitted,
                          1L),
                        FALSE,
                        FALSE),
                      collapse = " ")))),
              forceAndCall(
                1L,
                as.function(
                  alist(
                    structurize = ,
                    lapply(
                      structurize(
                        lapply(
                          lapply(
                            lapply(
                              lapply(
                                lapply(
                                  unlist(
                                    strsplit(
                                      entry,
                                      "\\s+"),
                                    FALSE,
                                    FALSE),
                                  strsplit,
                                  ""),
                                unlist,
                                FALSE,
                                FALSE),
                              structurize,
                              list(),
                              ""),
                            unlist,
                            FALSE,
                            FALSE),
                          paste0,
                          collapse = ""),
                        list(),
                        " "),
                      unlist,
                      FALSE,
                      FALSE))),
                as.function(
                  alist(
                    entries = ,
                    ret = ,
                    glue = ,
                    forceAndCall(
                      1L,
                      as.function(
                        alist(
                          indexes = ,
                          `if`(
                            `==`(
                              length(entries),
                              0L),
                            ret,
                            forceAndCall(
                              3L,
                              sys.function(
                                `-`(1L)),
                              `[`(
                                entries,
                                `-`(indexes)),
                              c(
                                ret,
                                list(
                                  `[`(
                                    entries,
                                    indexes))),
                              glue)))),
                      forceAndCall(
                        1L,
                        as.function(
                          alist(
                            acc.entries = ,
                            seq(
                              tail(
                                which(
                                  `<=`(
                                    nchar(acc.entries),
                                    `-`(
                                      width,
                                      nchar(affix)))),
                                1L)))),
                        Reduce(
                          as.function(
                            alist(
                              foo = ,
                              bar = ,
                              paste(
                                foo,
                                bar,
                                sep = glue))),
                          entries,
                          accumulate = TRUE))))))))),
        USE.NAMES = FALSE)))
}

generic.frontend <- function(backend) {
  invisible(
    forceAndCall(
      7L,
      as.function(
        alist(
          type.complex = ,
          type.double = ,
          type.integer = ,
          type.logical = ,
          type.numeric = ,
          type.default = ,
          type = ,
          forceAndCall(
            1L,
            as.function(
              alist(
                sig = ,
                forceAndCall(
                  1L,
                  as.function(
                    alist(
                      spec = ,
                      do.call(
                        backend,
                        tail(
                          getopt(spec),
                          `-`(1L))))),
                  cbind(
                    names(sig),
                    substr(
                      names(sig),
                      1L,
                      1L),
                    1L,
                    sapply(
                      sapply(
                        sig,
                        eval,
                        USE.NAMES = FALSE),
                      as.function(
                        alist(
                          entry = ,
                          type(entry))),
                      USE.NAMES = FALSE),
                    deparse.level = 0L)))),
            formals(backend)))),
      as.function(
        alist(
          foo = ,
          "complex")),
      as.function(
        alist(
          foo = ,
          "double")),
      as.function(
        alist(
          foo = ,
          "integer")),
      as.function(
        alist(
          foo = ,
          "logical")),
      as.function(
        alist(
          foo = ,
          "double")),
      as.function(
        alist(
          foo = ,
          "character")),
      as.function(
        alist(
          foo = ,
          UseMethod("type")))))
}

`if`(
  `!`(
    interactive()),
  generic.frontend(aline.kernel))
