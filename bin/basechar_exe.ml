let default o x = match o with
  | None -> x
  | Some y -> y

let () =

  (* Reading command-line arguments *)
  let text = Buffer.create 100 in
  let malformed = ref "" in
  let strip = ref None in
  let set_strip s = strip := Some s in
  let speclist =
    ["-m", Arg.Set_string malformed,
     "replace malformed utf8 by the given string (default \"?\")";
     "-s", Arg.String set_strip,
     "replace other utf8 characters by the given string"]
  in
  let anon_func s =
    if Buffer.length text <> 0
    then Buffer.add_string text " ";
    Buffer.add_string text s in
  let usage_msg = "Remove all accents and diacritics from latin letters in the \
                   given text.\nThe text has to be encoded in utf8.\n\n"
    ^ "   Usage:" ^ Sys.argv.(0) ^ " [-m malformed] [-s strip] text\n"
  in
  Arg.parse speclist anon_func usage_msg;

  (* Executing command *)
  let out = Basechar.from_utf8_string ~malformed:!malformed ?strip:!strip
      (Buffer.to_bytes text) in
  print_endline out;;

