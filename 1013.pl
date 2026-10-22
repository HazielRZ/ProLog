padre(jose).
padre(julio).
padre(luis).
padre(ramiro).
madre(maria).
madre(julia).
madre(guadalupe).
madre(liz).
madred(maria,pedro).
madred(maria,jose).
padred(julio,pedro).
padred(pedro,luis).
padred(jose,antonio).
abuelos(X,Y):-padred(X,Z), padred(Z,Y).
