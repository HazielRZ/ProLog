
eliza:-	writeln('Hola , mi nombre es  Eliza tu  chatbot,
	por favor ingresa tu consulta,
	usar solo minúsculas sin . al final:'),
	readln(Input),
	eliza(Input),!.
eliza(Input):- Input == ['Adios'],
	writeln('Adios. espero poder verte ayudado.'), !.
eliza(Input):- Input == ['Adios', '.'],
	writeln('Adios. espero poder verte ayudado.'), !.
eliza(Input) :-
	template(Stim, Resp, IndStim),
	match(Stim, Input),
	% si he llegado aquí es que he
	% hallado el template correcto:
	replace0(IndStim, Input, 0, Resp, R),
	writeln(R),
	readln(Input1),
	eliza(Input1), !.

template([hola, mi, nombre, es, s(_), '.'], ['Hola', 0, 'Como', estas, tu, '?'], [4]).
template([buendia, mi, nombre, es, s(_), '.'], ['buen dia', 'Como', estas, tu, 0, '?'], [4]).

template([hola, ',', mi, nombre, es, s(_), '.'], ['Hola', 0, 'Como', estas, tu, '?'], [5]).
template([buendia, ',', mi, nombre, es, s(_), '.'], ['Buendia', 'Como', estas, tu, 0, '?'], [5]).

template([hola, _], ['Hola', 'como', estas, tu, '?'], []).
template([buendia, _], ['Buendia', 'Como', estas, tu, '?'], []).

template([yo, s(_), yo, soy, s(_),'.'], [por, que, 0, eres, 1, '?'], [1, 4]).
template([yo, s(_), tu, '.'], [why, do, you, 0, me ,'?'], [1]).
template([yo, soy, s(_),'.'], [porque, eres, tu, 0, '?'], [2]).

% pregunta algo que le gusta a eliza
template([te, gustan, las, s(_), _], [flagLike], [3]).
template([te, gustan, los, s(_), _], [flagLike], [3]).

		 % pregunta algo que hace eliza
template([tu, eres, s(_), _], [flagDo], [2]).
% pregunta algo que es eliza
template([que, eres, tu, s(_)], [flagIs], [2]).
template([eres, s(_), '?'], [flagIs], [2]).

template([como, estas, tu, '?'], [yo, estoy, bien, ',', gracias, por, preguntar, '.'], []).

template([yo, pienso, que, _], [bueno, esa, es, tu, opinion], []).
template([porque, _], [esa, no, es, una, buena, razon, '.'], []).
template([i, have, s(_), with, s(_), '.'], ['You', have, to, deal, with, your, 0, and, your, 1, in, a, mature, way, '.'], [2, 4]).
template([i, s(_),  _], [i, can, recommend, you, a, book, about, that, issue], []).
template([please, s(_), _], ['No', i, can, not, help, ',', i, am, just, a, machine], []). 
		 template([tell, me, a, s(_), _], ['No', i, can, not, ',', i, am, bad, at, that], []).

				  
template(_, ['Please', explain, a, little, more, '.'], []). 
% Lo que le gusta a eliza : flagLike
elizaLikes(X, R):- likes(X), R = ['Yeah', i, like, X].
elizaLikes(X, R):- \+likes(X), R = ['Nope', i, do, not, like, X].
likes(apples).
likes(ponies).
likes(zombies).
likes(manzanas).
likes(computadoras).
likes(carros).
likes(caballos).


% lo que hace eliza: flagDo
elizaDoes(X, R):- does(X), R = ['Yes', i, X, and, i, love, it].
elizaDoes(X, R):- \+does(X), R = ['No', i, do, not, X ,'.', it, is, too, hard, for, me].
does(study).
does(cook).
does(work).

% lo que es eliza: flagIs
elizaIs(X, R):- is0(X), R = ['Yes', yo, soy, X].
elizaIs(X, R):- \+is0(X), R = ['No', i, am, not, X].
is0(dumb).
is0(weird).
is0(nice).
is0(fine).
is0(happy).
is0(redundant).

match([],[]).
match([], _):- true.

match([S|Stim],[I|Input]) :-
	atom(S), % si I es un s(X) devuelve falso
	S == I,
	match(Stim, Input),!.

match([S|Stim],[_|Input]) :-
% I es un s(X), lo ignoro y continúo con el resto de la lista
	\+atom(S),
	match(Stim, Input),!.

replace0([], _, _, Resp, R):- append(Resp, [], R),!.

% Eliza likes:
replace0([I|_], Input, _, Resp, R):-
	nth0(I, Input, Atom),
	nth0(0, Resp, X),
	X == flagLike,
	elizaLikes(Atom, R).

% Eliza does:
replace0([I|_], Input, _, Resp, R):-
	nth0(I, Input, Atom),
	nth0(0, Resp, X),
	X == flagDo,
	elizaDoes(Atom, R).

% Eliza is:
replace0([I|_], Input, _, Resp, R):-
	nth0(I, Input, Atom),
	nth0(0, Resp, X),
	X == flagIs,
	elizaIs(Atom, R).

replace0([I|Index], Input, N, Resp, R):-
	length(Index, M), M =:= 0,
	nth0(I, Input, Atom),
	select(N, Resp, Atom, R1), append(R1, [], R),!.

replace0([I|Index], Input, N, Resp, R):-
	nth0(I, Input, Atom),
	length(Index, M), M > 0,
	select(N, Resp, Atom, R1),
	N1 is N + 1,
	replace0(Index, Input, N1, R1, R),!.

	% =========================================================================
    % 1. PLANTILLAS (Agregar antes del template comodín final)
    % =========================================================================

    % Consultas de paradigma (Índice 4: [que, paradigma, tiene, el, s(_), '?'])
    template([que, paradigma, tiene, s(_), '?'], [flagParadigma], [3]).
    template([que, paradigma, tiene, s(_)], [flagParadigma], [3]).

    % Consultas de creador (Índice 2: [quien, creo, s(_), '?'])
    template([quien, creo, s(_), '?'], [flagCreador], [2]).
    template([quien, creo, s(_)], [flagCreador], [2]).

    % Consultas de tipado (Índice 3: [que, tipado, tiene, s(_), '?'])
    template([que, tipado, tiene, s(_), '?'], [flagTipado], [3]).
    template([que, tipado, tiene, s(_)], [flagTipado], [3]).

    % Consultas de propósito/uso (Índice 3: [para, que, sirve, s(_), '?'])
    template([para, que, sirve, s(_), '?'], [flagUso], [3]).
    template([para, que, sirve, s(_)], [flagUso], [3]).
    
    template(_, ['Please', explain, a, little, more, '.'], []).


    % =========================================================================
    % 2. BASE DE CONOCIMIENTOS: LENGUAJES DE PROGRAMACIÓN
    % =========================================================================

    % paradigma(Lenguaje, Paradigma)
    paradigma(prolog, logico_y_declarativo).
    paradigma(lisp, multiparadigma_y_funcional).
    paradigma(haskell, funcional_puro).
    paradigma(python, multiparadigma_orientado_a_objetos).
    paradigma(c, imperativo_y_estructurado).
    paradigma(cpp, multiparadigma_y_orientado_a_objetos).
    paradigma(java, orientado_a_objetos).
    paradigma(rust, multiparadigma_y_concurrente).

    % creador(Lenguaje, Autor)
    creador(prolog, 'Alain Colmerauer y Philippe Roussel').
    creador(lisp, 'John McCarthy').
    creador(haskell, 'Simon Peyton Jones y el comite Haskell').
    creador(python, 'Guido van Rossum').
    creador(c, 'Dennis Ritchie').
    creador(cpp, 'Bjarne Stroustrup').
    creador(java, 'James Gosling').
    creador(rust, 'Graydon Hoare').

    % tipado(Lenguaje, Tipo)
    tipado(prolog, dinamico_y_no_tipado).
    tipado(lisp, dinamico_y_fuerte).
    tipado(haskell, estatico_fuerte_e_inferido).
    tipado(python, dinamico_y_fuerte).
    tipado(c, estatico_y_debil).
    tipado(cpp, estatico_y_fuerte).
    tipado(java, estatico_y_fuerte).
    tipado(rust, estatico_fuerte_y_afin).

    % uso(Lenguaje, Dominio)
    uso(prolog, 'inteligencia artificial, sistemas expertos y procesamiento de lenguaje natural').
    uso(lisp, 'computacion simbolica, macros y desarrollo de IA').
    uso(haskell, 'compiladores, analisis formal y sistemas financieros de alta fiabilidad').
    uso(python, 'ciencia de datos, aprendizaje automatico y desarrollo backend').
    uso(c, 'sistemas operativos, sistemas embebidos y programacion de bajo nivel').
    uso(cpp, 'motores de videojuegos, sistemas de tiempo real y alto rendimiento').
    uso(java, 'aplicaciones empresariales y desarrollo Android').
    uso(rust, 'programacion de sistemas segura en memoria sin recolector de basura').


    % =========================================================================
    % 3. PREDICADOS DE RESOLUCIÓN
    % =========================================================================

    elizaParadigma(Lang, R) :-
        paradigma(Lang, P),
        R = ['El', lenguaje, Lang, sigue, el, paradigma, P, '.'], !.
    elizaParadigma(Lang, R) :-
        \+ paradigma(Lang, _),
        R = ['No', tengo, registrado, el, paradigma, de, Lang, en, mi, base, de, conocimiento, '.'].

    elizaCreador(Lang, R) :-
        creador(Lang, C),
        R = [Lang, fue, creado, por, C, '.'], !.
    elizaCreador(Lang, R) :-
        \+ creador(Lang, _),
        R = ['Desconozco', quien, creo, el, lenguaje, Lang, '.'].

    elizaTipado(Lang, R) :-
        tipado(Lang, T),
        R = ['El', sistema, de, tipos, de, Lang, es, T, '.'], !.
    elizaTipado(Lang, R) :-
        \+ tipado(Lang, _),
        R = ['No', tengo, datos, sobre, el, tipado, de, Lang, '.'].

    elizaUso(Lang, R) :-
        uso(Lang, U),
        R = [Lang, se, utiliza, principalmente, para, U, '.'], !.
    elizaUso(Lang, R) :-
        \+ uso(Lang, _),
        R = ['No', dispongo, de, informacion, sobre, los, usos, de, Lang, '.'].



    % =========================================================================

    replace0([], _, _, Resp, R) :- append(Resp, [], R), !.

    replace0([I|_], Input, _, Resp, R) :-
        nth0(I, Input, Atom),
        nth0(0, Resp, X),
        X == flagParadigma,
        elizaParadigma(Atom, R), !.

    replace0([I|_], Input, _, Resp, R) :-
        nth0(I, Input, Atom),
        nth0(0, Resp, X),
        X == flagCreador,
        elizaCreador(Atom, R), !.

    replace0([I|_], Input, _, Resp, R) :-
        nth0(I, Input, Atom),
        nth0(0, Resp, X),
        X == flagTipado,
        elizaTipado(Atom, R), !.

    replace0([I|_], Input, _, Resp, R) :-
        nth0(I, Input, Atom),
        nth0(0, Resp, X),
        X == flagUso,
        elizaUso(Atom, R), !.


    replace0([I|Index], Input, N, Resp, R) :-
        length(Index, M), M =:= 0,
        nth0(I, Input, Atom),
        select(N, Resp, Atom, R1), append(R1, [], R), !.

    replace0([I|Index], Input, N, Resp, R) :-
        nth0(I, Input, Atom),
        length(Index, M), M > 0,
        select(N, Resp, Atom, R1),
        N1 is N + 1,
        replace0(Index, Input, N1, R1, R), !.
