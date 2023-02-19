# Ubase

Ubase is a command-line [program](#the-ubase-program), a [javascript](#ubase.js-the-javascript-executable) executable, and an Ocaml
library for removing diacritics (accents, etc.) from Latin letters in
UTF8 string.

It should work for all utf8 strings, regardless of normalization NFC,
NFD, NFKD, NFKC.

__Please__ don't use this library to store your strings without
accents! On the contrary, store them in full UTF8 encoding, and use
this library to simplify searching and comparison.

# Ubase OCaml library

## Example

```ocaml
let nfc = "V\197\169 Ng\225\187\141c Phan";;
let nfd = "Vu\204\131 Ngo\204\163c Phan";;

print_endline nfc;;
Vũ Ngọc Phan

print_endline nfd;;
Vũ Ngọc Phan

Ubase.from_utf8 nfc;;
- : string = "Vu Ngoc Phan"

Ubase.from_utf8 nfd;;
- : string = "Vu Ngoc Phan"
```

## Usage

```ocaml
val from_utf8 : ?malformed:string -> ?strip:string -> string -> string
(** Remove all diacritics on Latin letters from a standard string containing
   UTF8 text. Any malformed UTF8 will be replaced by the [malformed] parameter
   (by default "?"). If the optional parameter [strip] is present, all
   non-ASCII, non-Latin unicode characters will be replaced by the [strip]
   string (which can be empty). If both [malformed] and [strip] contain only
   ASCII characters, then the result of [from_utf8] is guaranteed to
   contain only ASCII characters. *)
```

If your accented string is encoded in isolatin (8859-1), you first have to
convert it to utf8 using `isolatin_to_utf8 mystring`.


## Install

`ubase` is available on `opam`:
```
opam install ubase
```
That's it!

If you prefer to build a local version, download the repository, move
into the `ubase` directory, and

```
dune build
opam install .
```

Ubase versions >= 10 have no dependency, apart from ocaml >= 4.14.
Previous versions depend on `uutf` but work with older ocamls.

## Quick test

### Before installing

From the `ubase` directory:

```
dune utop
```

### From the command line

Once you have installed the library, you can execute the `ubase`
[program](#the-ubase-program) from a terminal.

## Doc

Documentation and API are available
[here](https://sanette.github.io/ubase/docs).

Manually building the docs, from the `ubase` directory:

```
dune build @doc
firefox ./_build/default/_doc/_html/ubase/Ubase/index.html
```

## Using Ubase for accent-insensitive searching

Have a look at [Ufind](https://github.com/sanette/ufind), a small
search engine based on Ubase.

# The `ubase` program

If you installed the library, the `ubase` program is automatically
installed.  If you don't need the library, you may directly download
the binary from the
[Releases](https://github.com/sanette/ubase/releases) page, or here:

* [linux binary](https://github.com/sanette/ubase/releases/download/0.20/ubase-binary-ubuntu.zip)
* [mac os binary](https://github.com/sanette/ubase/releases/download/0.20/ubase-binary-macos.zip)

You can execute the `ubase` program from a terminal. Its usage is
straighforward:

```
$ ubase Déjà vu !
Deja vu !

$ ubase "Bøǹĵöůɍ"
Bonjour

$ ubase Anh xin lỗi các em bé vì đã đề tặng cuốn sách này cho một ông người lớn.
Anh xin loi cac em be vi da de tang cuon sach nay cho mot ong nguoi lon.

```

# `ubase.js`, the javascript executable

The standalone javascript version of ubase is [`ubase.js`](https://github.com/sanette/ubase/releases/download/0.20/ubase-js.zip). You can test it with `node`:

```
$ node ubase.js Bøǹĵöůɍ
Bonjour

```

The javascript version was automatically produced from the OCaml
library using
[`js-of-ocaml`](https://ocsigen.org/js_of_ocaml/latest/manual/overview)
