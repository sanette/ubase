# Basechar

Ocaml library for removing diacritics (accents, etc.) from Latin
letters in UTF8 string.

It should work for all utf8 strings, regardless of normalization NFC,
NFD, NFKD, NFKC.

__Please__ don't use this library to store your strings without
accents! On the contrary, store them in full UTF8 encoding, and use
this library to simplify searching and comparison.

## Example

```ocaml
let nfc = "San V\197\169 Ng\225\187\141c";; 
let nfd = "San Vu\204\131 Ngo\204\163c";;

print_endline nfc;; 
San Vũ Ngọc

print_endline nfd;; 
San Vũ Ngọc

utf8_string_to_base nfc;;
 - : bytes = "San Vu Ngoc"

utf8_string_to_base nfd;; 
- : bytes = "San Vu Ngoc"
```

## Install

Basechar depends on [uutf].

Download the repository, and

```
dune build
opam install .
```

## Testing

Download the repository, and

```
dune utop
```
