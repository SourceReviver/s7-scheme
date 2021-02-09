(define size 1000000)
(set! (*s7* 'safety) -1)
(set! (*s7* 'heap-size) (* 4 1024000))

(define symbols (make-vector size 'a symbol?))
(define e (inlet))

(define (make-symbols)
  (do ((e1 e)
       (syms symbols)
       (i 0 (+ i 1)))
      ((= i size))
    (varlet e1 (vector-set! syms i (symbol "a-" (number->string i))) i)))
(make-symbols)

(define (add)
  (let ((sum 0)
	(e1 e))
    (for-each
     (lambda (x)
       (set! sum (+ sum (let-ref e1 x))))
     symbols)
    sum))

(define (subtract)
  (let ((sum 0)
	(e1 e))
    (for-each
     (lambda (x)
       (set! sum (- sum (let-ref e1 x))))
     (reverse! symbols))
    sum))

(define (whatever)
  (let ((sum 0))
    (do ((i 0 (+ i 1)))
	((= i size))
      (set! sum (+ sum (let-ref e (vector-ref symbols (random i))))))
    sum))

(format *stderr* "~A ~A ~A ~A~%" (/ (- (* size size) size) 2) (add) (subtract) (whatever))

(define (in-e)
  (with-let (sublet e :symbols symbols :size size)
    (let ((sum1 0.0)
	  (sum2 0.0)
	  (sum3 0.0)
	  (inc 0.0))
      (do ((i 0 (#_+ i 1)))
	  ((#_= i size))
	(set! inc (#_symbol->value (#_vector-ref symbols i)))
	(set! sum1 (#_+ sum1 inc))
	(set! sum2 (#_- sum2 inc))
	(set! sum3 (#_+ sum3 (#_symbol->value (#_vector-ref symbols (#_random i))))))
      (format *stderr* "~A ~A ~A ~A~%" (/ (- (* size size) size) 2) sum1 sum2 sum3))))
(in-e)

;;; --------------------------------------------------------------------------------
(define include-let #t)
(define include-let* #t)
(define include-letrec #t)
(define include-letrec* #t)
(define include-with-let #t)
(define include-let-temporarily #t)
(define include-named-let #t)
(define include-named-let* #t)

(set! size 100000)

(when include-let
  (define (f31 a)
    (let ((x 21)
	  (y (+ a 1))
	  (z (lambda () 21))
	  (xx (* a 2))
	  (yy (- a 1))
	  (zz (lambda () 22)))
      (+ x y (z) xx yy (zz))))
  (define (test31)
    (unless (= (f31 5) 84) (format *stderr* "(f31 5): ~S (expected ~S)~%" (f31 5) 84))
    (do ((i 0 (+ i 1)))
	((= i size))
      (f31 i)))
  (test31)

  (define (f32 a)
    (let ((x (+ a 1)))
      (* x 2)))
  (define (test32)
    (unless (= (f32 5) 12) (format *stderr* "(f32 5): ~S (expected ~S)~%" (f32 5) 12))
    (do ((i 0 (+ i 1)))
	((= i size))
      (f32 i)))
  (test32)

  (define (f33 a)
    (let ((x (+ a 1)))
      (let ((y (+ x 1)))
	(let ((z (+ x y)))
	  (+ x y z)))))
  (define (test33)
    (unless (= (f33 5) 26) (format *stderr* "(f33 5): ~S (expected ~S)~%" (f33 5) 26))
    (do ((i 0 (+ i 1)))
	((= i size))
      (f33 i)))
  (test33)
  )

(when include-let*
  (define (f41 a)
    (let* ((x 21)
	   (y (+ a 1))
	   (z (lambda () 21))
	   (xx (* a 2))
	   (yy (- a 1))
	   (zz (lambda () 22)))
      (+ x y (z) xx yy (zz))))
  (define (test41)
    (unless (= (f41 5) 84) (format *stderr* "(f41 5): ~S (expected ~S)~%" (f41 5) 84))
    (do ((i 0 (+ i 1)))
	((= i size))
      (f41 i)))
  (test41)

  (define (f42 a)
    (let ((x (+ a 1)))
      (* x 2)))
  (define (test42)
    (unless (= (f42 5) 12) (format *stderr* "(f42 5): ~S (expected ~S)~%" (f42 5) 12))
    (do ((i 0 (+ i 1)))
	((= i size))
      (f42 i)))
  (test42)
  )

(when include-letrec
  (define (f11 a)
    (letrec ((x 21)
	     (y (+ a 1))
	     (z (lambda () 21))
	     (xx (* a 2))
	     (yy (- a 1))
	     (zz (lambda () 22)))
      (+ x y (z) xx yy (zz))))
  (define (test11)
    (unless (= (f11 5) 84) (format *stderr* "(f11 5): ~S (expected ~S)~%" (f11 5) 84))
    (do ((i 0 (+ i 1)))
	((= i size))
      (f11 i)))
  (test11)

  (define (f12 a)
    (letrec ((x (+ a 1)))
      (* x 2)))
  (define (test12)
    (unless (= (f12 5) 12) (format *stderr* "(f12 5): ~S (expected ~S)~%" (f12 5) 12))
    (do ((i 0 (+ i 1)))
	((= i size))
      (f12 i)))
  (test12)
  )

(when include-letrec*
  (define (f21 a)
    (letrec* ((x 21)
	      (y (+ a 1))
	      (z (lambda () 21))
	      (xx (* a 2))
	      (yy (- a 1))
	      (zz (lambda () 22)))
      (+ x y (z) xx yy (zz))))
  (define (test21)
    (unless (= (f21 5) 84) (format *stderr* "(f21 5): ~S (expected ~S)~%" (f21 5) 84))
    (do ((i 0 (+ i 1)))
	((= i size))
      (f21 i)))
  (test21)

  (define (f22 a)
    (letrec* ((x (+ a 1)))
      (* x 2)))
  (define (test22)
    (unless (= (f22 5) 12) (format *stderr* "(f22 5): ~S (expected ~S)~%" (f22 5) 12))
    (do ((i 0 (+ i 1)))
	((= i size))
      (f22 i)))
  (test22)
  )

(when include-with-let
  (define (f51 a)
    (with-let (inlet 'x 21
		     'y (+ a 1)
                     'z (lambda () 21)
		     'xx (* a 2)
		     'yy (- a 1)
		     'zz (lambda () 22))
    (#_+ x y (z) xx yy (zz))))
  (define (test51)
    (unless (= (f51 5) 84) (format *stderr* "(f51 5): ~S (expected ~S)~%" (f51 5) 84))
    (do ((i 0 (+ i 1)))
	((= i size))
      (f51 i)))
  (test51)

  (define (f52 a)
    (with-let (inlet 'x (+ a 1))
      (#_* x 2)))
  (define (test52)
    (unless (= (f52 5) 12) (format *stderr* "(f52 5): ~S (expected ~S)~%" (f52 5) 12))
    (do ((i 0 (+ i 1)))
	((= i size))
      (f52 i)))
  (test52)
  )

(when include-let-temporarily
  (let ((x #f)
	(y #f)
	(z #f)
	(xx #f)
	(yy #f)
	(zz #f))
    (define (f61 a)
      (let-temporarily ((x 21)
			(y (+ a 1))
			(z (lambda () 21))
			(xx (* a 2))
			(yy (- a 1))
			(zz (lambda () 22)))
	(+ x y (z) xx yy (zz))))
    (define (test61)
      (unless (= (f61 5) 84) (format *stderr* "(f61 5): ~S (expected ~S)~%" (f61 5) 84))
      (when (or x y z xx yy zz) (format *stderr* "let-temporary f61, all should be #f: ~S ~S ~S ~S ~S ~S~%" x y z xx yy zz))
      (do ((i 0 (+ i 1)))
	  ((= i size))
	(f61 i)))
    (test61)
    
    (define (f62 a)
      (let-temporarily ((x (+ a 1)))
	(* x 2)))
    (define (test62)
      (unless (= (f62 5) 12) (format *stderr* "(f62 5): ~S (expected ~S)~%" (f62 5) 12))
      (do ((i 0 (+ i 1)))
	  ((= i size))
	(f62 i)))
    (test62)
    ))

(when include-named-let
  (define (f71 a)
    (let loop ((x 21)
	       (y (+ a 1))
	       (z (lambda () 21))
	       (xx (* a 2))
	       (yy (- a 1))
	       (zz (lambda () 22)))
      (if (= x 21)
	  (loop (- x 1) y z xx yy zz)
	  (+ x y (z) xx yy (zz)))))
  (define (test71)
    (unless (= (f71 5) 83) (format *stderr* "(f71 5): ~S (expected ~S)~%" (f71 5) 83))
    (do ((i 0 (+ i 1)))
	((= i size))
      (f71 i)))
  (test71)

  (define (f72 a)
    (let loop ((x (+ a 1)))
      (if (> x a)
	  (loop (- x 1))
	  (* x 2))))
  (define (test72)
    (unless (= (f72 5) 10) (format *stderr* "(f72 5): ~S (expected ~S)~%" (f72 5) 10))
    (do ((i 0 (+ i 1)))
	((= i size))
      (f72 i)))
  (test72)
  )

(when include-named-let*
  (define (f81 a)
    (let* loop ((x 21)
	       (y (+ a 1))
	       (z (lambda () 21))
	       (xx (* a 2))
	       (yy (- a 1))
	       (zz (lambda () 22)))
      (if (= x 21)
	  (loop (- x 1) y z xx yy zz)
	  (+ x y (z) xx yy (zz)))))
  (define (test81)
    (unless (= (f81 5) 83) (format *stderr* "(f81 5): ~S (expected ~S)~%" (f81 5) 83))
    (do ((i 0 (+ i 1)))
	((= i size))
      (f81 i)))
  (test81)

  (define (f82 a)
    (let* loop ((x (+ a 1)))
      (if (> x a)
	  (loop (- x 1))
	  (* x 2))))
  (define (test82)
    (unless (= (f82 5) 10) (format *stderr* "(f82 5): ~S (expected ~S)~%" (f82 5) 10))
    (do ((i 0 (+ i 1)))
	((= i size))
      (f82 i)))
  (test82)
  )

(when (> (*s7* 'profile) 0)
  (show-profile 200))
(exit)
