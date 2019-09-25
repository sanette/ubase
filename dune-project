(lang dune 1.11)
(name basechar)
(version "0.01")
(generate_opam_files true)
(license GPL2)
(maintainers "Vu Ngoc San <san.vu-ngoc@laposte.net>")
(authors "Vu Ngoc San <san.vu-ngoc@laposte.net>")
(source (github sanette/basechar))

(package
 (name basechar)
 (synopsis "Remove diacritics from latin utf8 strings")
 (tags ("utf8"))
 (depends
  (uutf (>= 1.0.1))
  (dune (>= 1.10))
))
