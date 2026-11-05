% 1. Longitud de una lista: tamano(Lista, N)
tamano([], 0).
tamano([_|Cola], N) :-
    tamano(Cola, N1),
    N is N1 + 1.

% 2. Último elemento de una lista: ultimo(Lista, Elemento)
ultimo([X], X).
ultimo([_|Cola], X) :-
    ultimo(Cola, X).

% 3. Pertenencia en una lista: miembro(Elemento, Lista)
miembro(X, [X|_]).
miembro(X, [_|Cola]) :-
    miembro(X, Cola).

% 4. Concatenación de dos listas: concatenar(L1, L2, Resultado)
concatenar([], L, L).
concatenar([Cabeza|Cola1], L2, [Cabeza|ColaResultado]) :-
    concatenar(Cola1, L2, ColaResultado).

% 5. Sumatoria de una lista numérica: suma_lista(Lista, Total)
suma_lista([], 0).
suma_lista([Cabeza|Cola], Total) :-
    suma_lista(Cola, Subtotal),
    Total is Cabeza + Subtotal.
