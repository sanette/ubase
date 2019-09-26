(* This file is part of Basechar *)

(* This list is manually created and overrides the automatically generated list
   [latin_uchar_to_base_alist]. Please add your own. *)
let misc_to_ascii_alist = [
  0x00a0, " "; (* NO-BREAK SPACE *)
  0x00c5, "AA"; (* "Å" = LATIN CAPITAL LETTER A WITH RING ABOVE *)
  0x00df, "ss";  (* "ß" = LATIN SMALL LETTER SHARP S *)
  0x2010, "-"; (* HYPHEN *)
  0x2013, "-"; (* EN DASH *)
  0x2014, "-"; (* EM DASH *)
  0x2018, "'"; (* LEFT SINGLE QUOTATION MARK *)
  0x2019, "'"; (* RIGHT SINGLE QUOTATION MARK *)
  0x201c, "\""; (* LEFT DOUBLE QUOTATION MARK *)
  0x201d, "\""; (* RIGHT DOUBLE QUOTATION MARK *)
  0x2026, "..."; (* HORIZONTAL ELLIPSIS *)
  0x202f, " "; (* NARROW NO-BREAK SPACE *)
  0x2212, "-"; (* MINUS SIGN *)
]
