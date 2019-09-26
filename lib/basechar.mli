(** Conversion from UTF8 latin letters to their base character.

Use this to remove diacritics (accents, etc.) from Latin letters in UTF8 string.

Depends on uutf.

It should work for all utf8 strings, regardless of normalization NFC, NFD, NFKD,
   NFKC.

   example:

{[
let nfc = "V\197\169 Ng\225\187\141c Phan";; 
let nfd = "Vu\204\131 Ngo\204\163c Phan";;

print_endline nfc;; 
Vũ Ngọc Phan

print_endline nfd;; 
Vũ Ngọc Phan

from_utf8_string nfc;;
 - : string = "Vu Ngoc Phan"

from_utf8_string nfd;; 
- : string = "Vu Ngoc Phan"
]}

   PLEASE don't use this library to store your strings without accents! On the
   contrary, store them in full UTF8 encoding, and use this library to simplify
   searching and comparison.

@author San Vu Ngoc, 2019

*)


val uchar_to_string : Uchar.t -> string
(** Convert a latin utf8 char to a string which represents is base equivalent.
   For instance, for the letter "é", [uchar_to_string (Uchar.of_int 0xe8) =
   "e"].

    [uchar_to_string u] and [u] exactly represent the same char if and only if
   [u] is ascii (code < 127).

    @raise [Not_found] if the uchar is not recognized as a latin letter with
   diacritic.

    A number of other conversions are performed, which are not about finding the
   base letter, but an ascii equivalent of some non-ascii utf8 characters: for
   instance, single quotation marks/apostrophes (U+2018, U+2019) and double
   quotation marks (U+201c, U+201d). *)

val uchar_to_char : ?unknown:char -> Uchar.t -> char
(** Similar to {!uchar_to_string} except that it returns a char. Thus, some
    simplifications have to be made. Unusual letters will be replaced by
    [unknown] (which defaults to '?').  *)
  
val from_utf8_string : ?malformed:string -> ?strip:string -> string -> string
(** Remove all diacritics on latin letters from a standard string containing
    UTF8 text. Any malformed UTF8 will be replaced by the [malformed] parameter
    (by default "?"). If the optional parameter [strip] is present, all
    non-ascii, non-latin unicode characters will be replaced by the [strip]
    string (which can be empty). *)
