(lang dune 2.7)
(name ubase)
(version "0.05")
(generate_opam_files true)
(license LGPL-3.0-or-later)
(maintainers "Vu Ngoc San <san.vu-ngoc@laposte.net>")
(authors "Vu Ngoc San <san.vu-ngoc@laposte.net>")
(source (github sanette/ubase))

(package
 (name ubase)
 (synopsis "Remove diacritics from latin utf8 strings")
 (tags ("utf8"))
 (depends
  (uutf (>= 1.0.1))
  (ocaml (>= 4.05.0))	
))
