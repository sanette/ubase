(* Conversion from UTF8 latin letters to their base character. *)
(* San Vu Ngoc, 2019 *)

(* Obviously it's even better here:
   https://metacpan.org/pod/Text::Unaccent::PurePerl

   They have 4013 bindings (including 1239 that return ascii), because they
   handle other alphabets like greek, cyrillic, and chars like 1/2, 1/4,
   etc... Our list has "only" 1908 bindings.

   There is also;
   https://metacpan.org/release/Text-Transliterator/source/lib/Text/Transliterator/Unaccent.pm
   They use a fully automatically generated map based on decomposed
   normalization, hence they miss some letters like "Đ" ==> "D", because "Đ"
   decomposes to itself. *)


module Int = struct type t = int let compare : int -> int -> int = compare end
module Imap = Map.Make(Int)
      
let latin_uchar_to_base_map =
  let add map (k, v) = Imap.add k v map in
  let map1 = List.fold_left add Imap.empty Ubase_data.latin_uchar_to_base_alist in
  List.fold_left add map1 Ubase_custom.misc_to_ascii_alist    
  
let uchar_to_string u =
  let x = Uchar.to_int u in
  if x <= 126 then Char.chr x |> String.make 1
  else Imap.find (Uchar.to_int u) latin_uchar_to_base_map

let string_to_char ?(unknown='?') s = 
  if String.length s > 2 then unknown
  else s.[0]

(* Convert a Uchar to its base character (char), or the [unknown] char *)
(* note that the "ae" letter => 'a', "oe" => 'o', etc. *)
let uchar_to_char  ?(unknown='?') u =
  string_to_char ~unknown (uchar_to_string u)
      
let from_utf8_string ?(malformed="?") ?strip s =
  let b = Buffer.create (String.length s) in
  let folder () _ = function
    | `Malformed  _ -> Buffer.add_string b malformed
    | `Uchar u ->
      try Buffer.add_string b (uchar_to_string u)
      with Not_found -> match strip with
        | None -> Uutf.Buffer.add_utf_8 b u (* or [Buffer.add_utf_8_uchar b u]
                                               for ocaml >*= 4.0.6 *)
        | Some strip ->  Buffer.add_string b strip
  in
  Uutf.String.fold_utf_8 folder () s;
  Buffer.to_bytes b


