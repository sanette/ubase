## 0.20 (2022/12/18) Remove uutf dependency

* `isolatin_to_utf8` now uses an included table based on
http://www.unicode.org/Public/MAPPINGS/VENDORS/MICSFT/WINDOWS/CP1252.TXT

* add `cp1252_to_utf8`

## 0.10 (2022/12/17) Faster

* 25% Faster thanks to the use `String.get_utf_8_uchar` instead of
  uutf. This requires a lower bound for ``ocaml` `>= 4.14.0`.

* add a few chars "LATIN SMALL LETTER xxx WITH MID-HEIGHT LEFT HOOK"
(from upstream uucp)

## 0.05 (2022/01/10) Last version for ocaml < 4.14

## 0.04 (2020-08-22)

add ligatures that do not contain "LETTER" in their names, like 0x0153
(reported by @reynir)

## 0.03 (2020-07-18)

update tables.
First OPAM version.
See https://discuss.ocaml.org/t/ann-ubase-0-03/6115/16


## 0.02 (2019-10-18)

Quite faster (replace exceptions by find_opt)
See https://discuss.ocaml.org/t/simplify-roman-utf8/4398/39

## 0.01 (2019-09-18)

first version
