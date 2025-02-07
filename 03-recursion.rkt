#lang racket

(require racket/trace) ; for dynamic function call traces

#|-----------------------------------------------------------------------------
;; Recursion

- what is a recursive function?
()  - a function that calls itself (directly or indirectly)
- what are some common "rules" for writing recursive functions?
-----------------------------------------------------------------------------|#

;; Factorial: n! = n * (n - 1) * (n - 2) * ... * 1
(define (factorial n)
  (void))

; (trace factorial)

;; Integer summation: m + (m + 1) + (m + 2) + ... + n
(define (sum-from-to m n)
  (void))

; (trace sum-from-to)

#|-----------------------------------------------------------------------------
 The above functions demonstrate *structural recursion*, because they recurse
 over the structure of the input data.
 
 We can represent natural numbers as self-referential structures to more
 explicitly demonstrate structural recursion.
-----------------------------------------------------------------------------|#

(struct Z () #:transparent)     ; zero
(struct S (pred) #:transparent) ; "successor" of pred

(define one   (S (Z)))
(define two   (S one))
(define three (S two))
(define four  (S three))

;; What is the general form of a structurally recursive function over the
;; natural numbers?
(define (nats-rec-form n)
  (void))

;; Add two natural numbers
;; add(m, n) = n, if m = 0
;;           = 1 + add(m-1, n), otherwise
(define (add-nats m n)
  (void))

#|-----------------------------------------------------------------------------
;; Proofs of correctness

- how can we prove that a structurally recursive function is correct?
  

- can we apply this to `factorial` and the other functions above?
-----------------------------------------------------------------------------|#

#|-----------------------------------------------------------------------------
;; Tail recursion and Accumulators

- what is tail recursion?

- what is an accumulator?

- why would we use these techniques?
-----------------------------------------------------------------------------|#

(define (factorial-tail n [acc 1])
(void)
  )

; (trace factorial-tail)

(define (sum-from-to-tail m n [acc 0])
  (if (> m n)
      acc
      (sum-from-to-tail (add1 m) n (+ m acc)))
  )
  ;; (trace sum-from-to-tail)

; (trace sum-from-to-tail)

(define (add-nats-tail m n [acc n])
  (void))

; (trace add-nats-tail)

#|-----------------------------------------------------------------------------
;; Structural recursion on lists
-----------------------------------------------------------------------------|#

;; length: the number of elements in a list
(define (length lst)
  (void))

;; concat: concatenate the elements of two lists
(define (concat l1 l2)
  (if (empty? l1)
      l2
      (cons (first l1)
            (concat (rest l1) l2))))

(trace concat)


;; count-elements: count the number of elements in a tree (a nested list)
(define (count-elements tree)
  (cond  ; recursive case ; base case
        [(empty? tree) 0]
        [(not (pair? tree)) 1]
        [else (+  (count-elements (car tree))
                  (count-elements (cdr tree)))]))

(trace count-elements)

;; repeat: create a list of n copies of x
(define (repeat n x)
  (if (= n 0) 
      '()
      (cons x (repeat (sub1 n) x))))

(trace repeat)

(define (repeat-list n lst)
  (if (= n 0)
      '()
      (concat lst (repeat-list (sub1 n) lst))) ;concat itself is linear to get to the end to get to the end of the list each time in order to concat it
)

;; reverse: reverse the elements of a list
(define (reverse lst)
  (if (empty? lst)
      '()
      (concat (reverse (rest lst)) 
              (cons (first lst) '())))) ;; runtime O(n^2)

(trace reverse) 

(define (reverse-tail lst [acc '()])
  (if (empty? lst)
      acc
      (reverse-tail (rest lst)
                    (cons (first lst) acc)))) ;;linear time reverse

(trace reverse-tail)
#|-----------------------------------------------------------------------------
;; Generative recursion aka. "algorithm"

- what is generative recursion, and how does it differ from structural 
  recursion?
-----------------------------------------------------------------------------|#

(define (gcd m n)
  (cond
    [(= m 0) n]
    [(= n 0) m]
    [else (gcd n (remainder m n))]))

(trace gcd)