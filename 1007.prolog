padre(juan, luis).
padre(luis, jaime).
hijo(Y,X) :- padre(X,Y).
abuelo(X,Y) :- padre(X,Z), padre(Z,Y).

?- abuelo(juan, W).