(define-module util.define
  (use util.match)
  (export define-match))

(select-module util.define)

;; (define-match foo
;;   [(bar baz) (list bar baz)]
;;   [(x y "const") (list 'const x y)]
;;   [(1 (2 3) x) (list x)])
;; -->
;; (define foo
;;   (match-lambda*
;;     [(bar baz) (list bar baz)]
;;     [(x y "const") (list 'const x y)]
;;     [(1 (2 3) x) (list x)]))

(define-macro (define-match name . pats)
  `(define ,name
     (match-lambda* ,@pats)))
