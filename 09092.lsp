(car '(1 2 3 4 5))

;; a) (1 2 3 4 5 6 7 8 9 10) -> 6 , 8 , 10
;; 6
(cadr (cddddr '(1 2 3 4 5 6 7 8 9 10)))

;; 8
(cadddr (cddddr '(1 2 3 4 5 6 7 8 9 10)))

;; 10
(cadr (cddddr (cddddr '(1 2 3 4 5 6 7 8 9 10))))


;; b)((1 2 (3 4))(A B C D)) -> D, C, 4, 2, A

;; D
(cadddr (cadr '((1 2 (3 4)) (A B C D))))

;; C
(caddr (cadr '((1 2 (3 4)) (A B C D))))

;; 4
(cadar (cddar '((1 2 (3 4)) (A B C D))))

;; 2
(cadar '((1 2 (3 4)) (A B C D)))

;; A
(caadr '((1 2 (3 4)) (A B C D)))


;; c) ((A B C)(R(T X)(Z W))) -> w z t r x a
;; W
(cadar (cddr (cadr '((A B C) (R (T X) (Z W))))))

;; Z
(caar (cddr (cadr '((A B C) (R (T X) (Z W))))))

;; T
(caadr (cadr '((A B C) (R (T X) (Z W)))))

;; R
(caadr '((A B C) (R (T X) (Z W))))

;; X
(cadar (cdadr '((A B C) (R (T X) (Z W)))))

;; A
(caar '((A B C) (R (T X) (Z W))))


;; d) ((((a b) (c d)(f g)))) -> a b c d f g

;; a
(caaar (car '((((a b) (c d) (f g))))))

;; b
(cadar (caar '((((a b) (c d) (f g))))))

;; c
(caadr (caar '((((a b) (c d) (f g))))))

;; d tentativo
(cadar (cdar (caar '((((a b) (c d) (f g))))))))

;; f
(caaddr (caar '((((a b) (c d) (f g))))))

;; g tentativo
(cadar (cddar (caar '((((a b) (c d) (f g)))))))

