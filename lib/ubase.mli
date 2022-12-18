(** Conversion from UTF8 latin letters to their base character.

    Use this to remove diacritics (accents, etc.) from Latin letters in UTF8
   string.

    Depends on [uutf].  It should work for all utf8 strings, regardless of
   normalization NFC, NFD, NFKD, NFKC.


    PLEASE don't use this library to store your strings without accents! On the
   contrary, store them in full UTF8 encoding, and use this library to simplify
   searching and comparison.

   {{:https://github.com/sanette/ubase}Source on github}

    @author San Vu Ngoc, 2019-2020

*)

(** {1 Example}

{[
let nfc = "V\197\169 Ng\225\187\141c Phan";;
let nfd = "Vu\204\131 Ngo\204\163c Phan";;

print_endline nfc;;
Vũ Ngọc Phan

print_endline nfd;;
Vũ Ngọc Phan

from_utf8 nfc;;
 - : string = "Vu Ngoc Phan"

from_utf8 nfd;;
- : string = "Vu Ngoc Phan"
]}

*)

(** {1 Removing accents} *)

val from_utf8 : ?malformed:string -> ?strip:string -> string -> string
(** Remove all diacritics on Latin letters from a standard string containing
   UTF8 text. Any malformed UTF8 will be replaced by the [malformed] parameter
   (by default "?"). If the optional parameter [strip] is present, all
   non-ASCII, non-Latin unicode characters will be replaced by the [strip]
   string (which can be empty). If both [malformed] and [strip] contain only
   ASCII characters, then the result of [from_utf8] is guaranteed to contain
   only ASCII characters. *)

val from_utf8_string : ?malformed:string -> ?strip:string -> string -> string
(** Deprecated. Same as {!from_utf8}. *)

val uchar_replacement : Uchar.t -> string option
(** [uchar_replacement u] returns the replacement string for [u], representing
   its base letter without accent or diacritics, but only if [u] admits such a
   replacement.

    A number of other conversions are performed, which are not about finding the
   base letter, but an ascii equivalent of some non-ascii utf8 characters: for
   instance, single quotation marks/apostrophes (U+2018, U+2019) and double
   quotation marks (U+201c, U+201d).

    The returned string is guaranteed to be represented by a char that is
   different from [u].  *)

val uchar_to_char : ?unknown:char -> Uchar.t -> char
(** Convert a Uchar to a single char representing its base letter, without
   diacritics. For this, some simplifications have to be made. Unusual letters
   will be replaced by [unknown] (which defaults to '?').  *)

(** {1 Utilities} *)

val isolatin_to_utf8 : ?control:int -> string -> string
(** Convert an ISO_8859_1 string to a UTF8 string. ISO_8859_1 chars in the range
    ''0x80..0x9F' are supposed to encode 'controls', and will be rendered by the
    UTF8 symbol whose integer code is given by the [control] parameter (defaults
    to [0x0080]) *)

val cp1252_to_utf8 : ?undefined:int -> string -> string
(** Convert a cp1252 string (also known as "windows-1252") to a UTF8 string. The
    5 unassigned codes will be rendered by the UTF8 symbol whose integer code is
    given by the [undefined] parameter (defaults to [0xFFFD]). *)

val is_space : Uchar.t -> bool
(** Return true if the character is considered as a white space (this includes
   tab and newline). *)
