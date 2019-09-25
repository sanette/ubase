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

Basechar.from_utf8_string nfc;;
 - : bytes = "San Vu Ngoc"

Basechar.from_utf8_string nfd;; 
- : bytes = "San Vu Ngoc"
```

## Usage

```ocaml
val from_utf8_string : ?malformed:string -> ?strip:string -> string -> string
(** Remove all diacritics on latin letters from a standard string containing
    UTF8 text. Any malformed UTF8 will be replaced by the [malformed] parameter
    (by default "?"). If the optional parameter [strip] is present, all
    non-ascii, non-latin unicode characters will be replaced by the [strip]
    string (which can be empty). *)
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

## Doc

```
dune build @doc
firefox /_build/default/_doc/_html/index.html
```
