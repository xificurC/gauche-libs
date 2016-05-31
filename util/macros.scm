(define-module util.macros
  (export with-gensyms))

(select-module util.macros)

(define-macro (with-gensyms glist . body)
  `(let ,(map (^ (x) `(,x (gensym (symbol->string ,x))))
              glist)
     ,@body))
