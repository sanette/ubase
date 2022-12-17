(lang dune 2.7)
(name ubase)
(version "0.10")
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
  (ocaml (>= 4.14.0))
))
