(define-module util.threading
  (use srfi-1) ;; list library
  (export -> ->> -%> -%>>))

(select-module util.threading)

(define-macro (->> x . forms)
  (if (null? forms)
      x
      (if (list? (car forms))
          `(->> (,@(car forms) ,x) ,@(cdr forms))
          `(->> (,(car forms) ,x) ,@(cdr forms)))))

(define-macro (-> x . forms)
  (if (null? forms)
      x
      (if (list? (car forms))
          `(-> (,(caar forms) ,x ,@(cdar forms)) ,@(cdr forms))
          `(-> (,(car forms) ,x) ,@(cdr forms)))))


(define-macro (-%>> x . forms)
  (if (null? forms)
      x
      (let [(head (car forms))
            (rest (cdr forms))]
        (if (list? head)
            (if-let1 idx (list-index (^ (s) (eq? s '%)) head)
                     `(-%>> ,(begin (set! (~ head idx) x) head) ,@rest)
                     `(-%>> (,@head ,x) ,@rest))
            `(-%>> (,head ,x) ,@rest)))))

(define-macro (-%> x . forms)
  (if (null? forms)
      x
      (let [(head (car forms))
            (rest (cdr forms))]
        (if (list? head)
            (if-let1 idx (list-index (^ (s) (eq? s '%)) head)
                     `(-%> ,(begin (set! (~ head idx) x) head) ,@rest)
                     `(-%> (,(car head) ,x ,@(cdr head)) ,@rest))
            `(-%> (,head ,x) ,@rest)))))
