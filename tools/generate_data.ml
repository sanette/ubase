#require "unix";;
#require "str";;
#require "uucp";;
#require "uutf";;

let default o d =
  match o with
  | None -> d
  | Some x -> x
    
let rec print_names first last =
  let name = Uucp.Name.name first in
  print_endline name;
  if not (Uchar.equal first last)
  then print_names (Uchar.succ first) last

let uchar_to_string u : string  =
  let b = Buffer.create 3 in
  Uutf.Buffer.add_utf_8 b u;
  Buffer.to_bytes b
    
let is_latin ?name u =
  let name = default name (Uucp.Name.name u) in
  Uucp.Script.script u = `Latn ||
  try let _ = Str.search_forward (Str.regexp "\\bLATIN\\b") name 0 in
    true with
  | Not_found -> false

let rec dump_latin first last =
  let name = Uucp.Name.name first in
  if is_latin ~name first
  then Printf.sprintf "%s = %i = %s"
      (uchar_to_string first) (Uchar.to_int first) name
       |> print_endline;
  if not (Uchar.equal first last)
  then dump_latin (Uchar.succ first) last

let is_diacritical_or_combining u name =
  (* Almost all diacritical have "COMBINING" in their name, but not quite
     all... *)
  let dia = Uucp.Block.block u in
  dia = `Diacriticals
  || dia = `Diacriticals_Ext
  || (try let _ = Str.search_forward (Str.regexp "\\COMBINING\\b") name 0 in
        true with
     | Not_found -> false)
     && not
       (try  let _ = Str.search_forward (Str.regexp "\\LETTER\\b") name 0 in
          true with
       | Not_found -> false)

let unwanted_adjectives = [
  "TURNED"; "REVERSED"; "CLOSED"; "OPEN"; "GLOTTAL"; "SMALL"; "SHARP"; "DOTLESS"; "LONG"; "TONE"; "AFRICAN"; "SIDEWAYS"; "DIAERESIZED"; "INSULAR"; "BOTTOM HALF"; "TOP HALF"; "BARRED"; "DENTAL"; "LATERAL"; "ALVEOLAR"; "PHARYNGEAL"; "BILABIAL"; "INVERTED"; "CAPITAL"; "SCRIPT"; "ARCHAIC"; "BASELINE"; "BLACKLETTER"; "FLATTENED"; "IOTIFIED"; "ANGLICANA"; "DOUBLE"; "STIRRUP"; "LIGATURE"; "SINOLOGICAL"; "LENIS"; "RETROFLEX"; "VOLAPUK"; "VISIGOTHIC"; "BROKEN"; "EGYPTOLOGICAL"; "MIDDLE-WELSH"; "HALF"; "TAILLESS"; "VOICED LARYNGEAL"; "STRETCHED"
]

let unwanted_adjectives_regexp =
  unwanted_adjectives
  |> List.map (fun w -> "\\(" ^ w ^ " \\)")
  |> String.concat "\\|"
  |> Str.regexp;;

(* We keep "ALEF" because it's almost a common name. We keep "CON", "DUM",
   "RUM", "TUM" because they are abbreviations. *)
let letter_replacement = [
  "ALPHA", "A";
  "BETA", "B";
  "DELTA", "D";
  "GAMMA", "G";
  "IOTA", "I";
  "LAMBDA", "L";
  "UPSILON", "U";
  "CHI", "X";
  "OMEGA", "O";
  "ETH", "D";
  "THORN", "TH";
  "ENG", "NG";
  "ESH", "SH";
  "EZH", "Z";
  "STOP", "TS";
  "WYNN", "W";
  "SCHWA", "E";
  "HWAIR", "HW";
  "YOGH", "GH";
  "AIN", "O";
  "HENG", "H";
  "CLICK", "|";
  "RUM", "R";
  "VEND", "V";
  "TRESILLO", "3";
  "CUATRILLO", "4";
  "TWO", "2";
  "FIVE", "5";
  "SIX", "6";
  "SALTILLO", "'";
  "DOT", ":"  
]


let cleanup_name name =
  Str.global_replace unwanted_adjectives_regexp "" name

(* Convert a latin Uchar to a string containing its base letter. Uchar that
   don't have a latin base letter are kept unmodified.  *)
let latin_to_base ?name u =
  let name = default name (Uucp.Name.name u) in
  if is_diacritical_or_combining u name
  then ""
  else
  if not (is_latin ~name u) then uchar_to_string u
  else
    let name = cleanup_name name in
    try
      let _ = Str.search_forward
          (Str.regexp "\\bLETTER \\([A-Z]+\\)\\b") name 0 in
      let letter = Str.matched_group 1 name in
      let letter = default (List.assoc_opt letter letter_replacement) letter in
      if Uucp.Case.is_lower u then String.lowercase_ascii letter else letter
    with
    | Not_found -> uchar_to_string u

(* Convert a Uchar to a its base character (char), or the unknown char *)
(* note that the "ae" letter => 'a', "oe" => 'o', etc. *)
let latin_to_char ?(unknown='?') u =
  let s = latin_to_base u in
  if String.length s > 2 then unknown
  else s.[0]

let dump_all_latin_to_base ?(channel = stdout) () =
  let rec loop u =
    let name = Uucp.Name.name u in
    let s = latin_to_base ~name u in
    let t = uchar_to_string u in
    if s <> t then begin
      Printf.fprintf channel
        "0x%04x, \"%s\"; (* \"%s\" = %s *)\n" (Uchar.to_int u) s t name;
    end;
    if not (Uchar.equal u Uchar.max) then loop (Uchar.succ u)
  in
  loop Uchar.min;;
    
let t = Unix.gettimeofday () in
begin
  let file = Filename.temp_file "utf8-" "" in
  let channel = open_out file in
  print_endline "Generating table, please wait...";
  dump_all_latin_to_base ~channel ();
  print_endline (Printf.sprintf "Time = %f" (Unix.gettimeofday () -. t));
  close_out channel;
  print_endline ("Saved in " ^file)
end;;


let rec dump_combining first last =
  let name = Uucp.Name.name first in
  let has_combining = try
      let _ = Str.search_forward (Str.regexp "\\bCOMBINING\\b") name 0 in
      true with
  | Not_found -> false in
  let is_dia = Uucp.Block.block first = `Diacriticals
             || Uucp.Block.block first = `Diacriticals_Ext in
  if has_combining || is_dia then
    Printf.sprintf "%s = %i = %s, Diacriticals = %b"
      (uchar_to_string first) (Uchar.to_int first) name is_dia
    |> print_endline;
  if not (Uchar.equal first last)
  then dump_combining (Uchar.succ first) last
