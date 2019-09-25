let test_viet () =
  print_endline "Vietnamese test...";
  let b = Basechar.from_utf8_string "Vũ Ngọc Phan (1902-1987) là nhà văn, nhà nghiên cứu văn học hiện đại và văn học dân gian Việt Nam. Trong những năm đầu cầm bút, ông còn có bút danh là Chỉ Qua Thị."
  =
  "Vu Ngoc Phan (1902-1987) la nha van, nha nghien cuu van hoc hien dai va van hoc dan gian Viet Nam. Trong nhung nam dau cam but, ong con co but danh la Chi Qua Thi." in
  assert b;
  print_endline "OK."

let test_french () =
  print_endline "French test...";
  let b = Basechar.from_utf8_string "Cette princesse était belle, quoiqu’elle eût passé la première jeunesse ; elle aimait la grandeur, la magnificence et les plaisirs. Le roi l’avait épousée lorsqu’il était encore duc d’Orléans, et qu’il avait pour aîné le dauphin, qui mourut à Tournon, prince que sa naissance et ses grandes qualités destinaient à remplir dignement la place du roi François premier, son père."
  =
  "Cette princesse etait belle, quoiqu'elle eut passe la premiere jeunesse ; elle aimait la grandeur, la magnificence et les plaisirs. Le roi l'avait epousee lorsqu'il etait encore duc d'Orleans, et qu'il avait pour aine le dauphin, qui mourut a Tournon, prince que sa naissance et ses grandes qualites destinaient a remplir dignement la place du roi Francois premier, son pere." in
  assert b;
  print_endline "OK."

let () =
  test_viet ();
  test_french ()
