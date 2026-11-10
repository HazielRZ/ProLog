eliza :-
	writeln('================================================================='),
	writeln('Hola, mi nombre es Eliza Doctora, tu chatbot Medico.'),
	writeln('Puedes consultar: sintomas, especialistas, medicamentos o diagnostico.'),
	writeln('Por favor ingresa tu consulta (solo minusculas sin . al final):'),
	    write('  ______ _      _____ ______          '), nl,
        write(' |  ____| |    |_   _|___  /   /\\     '), nl,
        write(' | |__  | |      | |    / /   /  \\    '), nl,
        write(' |  __| | |      | |   / /   / /\\ \\   '), nl,
        write(' | |____| |____ _| |_ / /__ / ____ \\  '), nl,
        write(' |______|______|_____/_____/_/    \\_\\ '), nl,
        write('                .-------.                '), nl,
        write('                !_______!                '), nl,
        write('               (((`\\\\\\ )))               '), nl,
        write('              (((_o_u_o_)))              '), nl,
        write('              ((!       !)''              '), nl,
        write('                !_______!                '), nl,
        write('                  l   l                  '), nl,
	writeln('================================================================='),
	readln(Input),
	eliza(Input), !.

% Condiciones de salida
eliza(Input) :- Input == ['Adios'],
	writeln('Adios. Espero haberte ayudado con tu consulta medica.'), !.
eliza(Input) :- Input == ['Adios', '.'],
	writeln('Adios. Espero haberte ayudado con tu consulta medica.'), !.
eliza(Input) :- Input == [adios],
	writeln('Adios. Espero haberte ayudado con tu consulta medica.'), !.
eliza(Input) :- Input == [adios, '.'],
	writeln('Adios. Espero haberte ayudado con tu consulta medica.'), !.


eliza(Input) :-
	template(Stim, Resp, IndStim),
	match(Stim, Input),
	replace0(IndStim, Input, 0, Resp, R),
	writeln(R),
	readln(Input1),
	eliza(Input1), !.


% =========================================================================
% 1. BASE DE CONOCIMIENTOS DEL SISTEMA EXPERTO MEDICO
% =========================================================================

% --- Declaraciones de enfermedades ---
enfermedad(diabetes).
enfermedad(meniere).
% Enfermedades adicionales base:
enfermedad(gripe).
enfermedad(rubeola).
enfermedad(malaria).
enfermedad(hepatitis).
enfermedad(tuberculosis).
enfermedad(anemia).
enfermedad(depresion).

% --- Alias de nombres de enfermedades para lenguaje natural ---
normalizar_enfermedad(diabetes, diabetes) :- !.
normalizar_enfermedad(meniere, meniere) :- !.
normalizar_enfermedad(enfermedad_de_meniere, meniere) :- !.
normalizar_enfermedad(sindrome_de_meniere, meniere) :- !.
normalizar_enfermedad(rubeola, rubeola) :- !.
normalizar_enfermedad(tubercolosis, tuberculosis) :- !.
normalizar_enfermedad(E, E).

% --- Declaraciones de sintomas segun enfermedad: sintomade(Sintoma, Enfermedad) ---

% Sintomas de Diabetes:
sintomade(polidipsia, diabetes).          % sed excesiva
sintomade(sed_excesiva, diabetes).        % sed excesiva (termino comun)
sintomade(sed, diabetes).                 % sed constante
sintomade(orinar, diabetes).              % orina constante
sintomade(poliuria, diabetes).            % miccion frecuente
sintomade(miccion_frecuente, diabetes).   % ganas frecuentes de orinar
sintomade(polifagia, diabetes).           % hambre excesiva
sintomade(hambre_excesiva, diabetes).     % aumento del apetito
sintomade(fatiga, diabetes).              % fatiga extrema
sintomade(cansancio, diabetes).           % cansancio constante
sintomade(vision_borrosa, diabetes).      % vista borrosa
sintomade(perdida_peso, diabetes).        % perdida de peso inexplicable
sintomade(hormigueo, diabetes).           % neuropatia / hormigueo en manos o pies
sintomade(heridas_lentas, diabetes).      % llagas o heridas de lenta cicatrizacion

% Sintomas de la Enfermedad de Meniere:
sintomade(vertigo, meniere).              % episodios de vertigo rotatorio
sintomade(mareo, meniere).                % mareos intensos
sintomade(tinnitus, meniere).             % zumbido en el oido
sintomade(zumbido, meniere).              % acufenos / timbre en el oido
sintomade(hipoacusia, meniere).           % perdida de audicion fluctuante
sintomade(perdida_auditiva, meniere).     % disminucion auditiva
sintomade(sordera, meniere).              % perdida auditiva progresiva
sintomade(presion_oido, meniere).         % sensacion de plenitud o taponamiento aural
sintomade(oido_tapado, meniere).          % sensacion de oido lleno
sintomade(perdida_equilibrio, meniere).   % inestabilidad postural
sintomade(nauseas, meniere).              % nauseas asociadas al vertigo
sintomade(vomito, meniere).               % vomitos durante crisis vertiginosa

% Sintomas de la guia base:
sintomade(tos, gripe).
sintomade(cansancio, gripe).
sintomade(fiebre, gripe).
sintomade(dolorcabeza, gripe).
sintomade(nauseas, hepatitis).
sintomade(diarrea, hepatitis).
sintomade(ictericia, hepatitis).
sintomade(cansancio, anemia).
sintomade(apatia, anemia).
sintomade(nausea, anemia).
sintomade(tos, tuberculosis).
sintomade(cansancio, tuberculosis).
sintomade(fiebre, tuberculosis).
sintomade(escalofrios, tuberculosis).
sintomade(escalofrios, malaria).
sintomade(fiebre, malaria).
sintomade(diarrea, malaria).
sintomade(ictericia, malaria).
sintomade(fiebre, rubeola).
sintomade(jaqueca, rubeola).
sintomade(secrecion, rubeola).
sintomade(tristeza, depresion).
sintomade(deprimido, depresion).

% --- Declaraciones de medicamentos posibles: medicinade(Medicamento, Enfermedad) ---

% Medicamentos para Diabetes:
medicinade(metformina, diabetes).         % antidiabetico oral de primera linea (biguanida)
medicinade(insulina, diabetes).           % terapia hormonal sustitutiva
medicinade(glibenclamida, diabetes).      % sulfonilurea estimulante de insulina
medicinade(glimepirida, diabetes).        % sulfonilurea de segunda generacion
medicinade(sitagliptina, diabetes).       % inhibidor de DPP-4
medicinade(empagliflozina, diabetes).     % inhibidor de SGLT2
medicinade(semaglutida, diabetes).        % agonista del receptor GLP-1

% Medicamentos para la Enfermedad de Meniere:
medicinade(betahistina, meniere).         % vasodilatador laberintico para reducir el vertigo
medicinade(meclizina, meniere).           % antivertiginoso y antiemetico para crisis agudas
medicinade(diazepam, meniere).            % supresor vestibular para ataques severos
medicinade(prometazina, meniere).         % control de nauseas y vomitos
medicinade(hidroclorotiazida, meniere).   % diuretico para disminuir la presion endolinfatica
medicinade(diureticos, meniere).          % control de retencion de liquido en oido interno
medicinade(dexametasona, meniere).        % corticosteroide intratimpanico
medicinade(gentamicina, meniere).         % antibiotico intratimpanico para casos refractarios

% Medicamentos de la guia base :
medicinade(contrex, gripe).
medicinade(jarabe, gripe).
medicinade(pastillas, tuberculosis).
medicinade(vacuna, malaria).
medicinade(vacuna, rubeola).
medicinade(vitaminas, anemia).
medicinade(pastillas, hepatitis).
medicinade(ya_no_estes_triste, depresion).

% --- Declaraciones de especialistas recomendados: especialistade(Especialista, Enfermedad) ---

% Especialistas para Diabetes:
especialistade(endocrinologo, diabetes).
especialistade(nutricionista, diabetes).
especialistade(medico_internista, diabetes).
especialistade(oftalmologo, diabetes).
especialistade(nefrologo, diabetes).

% Especialistas para la Enfermedad de Meniere:
especialistade(otorrinolaringologo, meniere).
especialistade(otorrino, meniere).
especialistade(otoneurologo, meniere).
especialistade(audiologo, meniere).
especialistade(neurologo, meniere).

% Especialistas de la guia base (prolog.pdf):
especialistade(otorrino, gripe).
especialistade(nutricionista, anemia).
especialistade(endocrinologia, hepatitis).
especialistade(medicinageneral, rubeola).
especialistade(nutricionista, tuberculosis).
especialistade(medicinageneral, malaria).


% =========================================================================
% 2. REGLAS DEL SISTEMA EXPERTO (SEGUN GUIA PROLOG.PDF)
% =========================================================================

% Buscar coincidencias de sintomas para una enfermedad E:
buscar([], _, 0) :- !.
buscar(X, E, 1) :- atom(X), sintomade(X, E), !.
buscar(X, E, 0) :- atom(X), \+ sintomade(X, E), !.
buscar([X|Xs], E, P) :-
	enfermedad(E),
	buscar(X, E, S1),
	buscar(Xs, E, S2),
	P is S1 + S2.

% Cantidad total de sintomas registrados para la enfermedad E:
cantSint(E, C) :-
	findall(X, sintomade(X, E), L),
	length(L, R),
	C is R.

% Porcentaje de probabilidad de la enfermedad E dada una lista de sintomas [X|Xs]:
diagnostico([X|Xs], E, K) :-
	enfermedad(E),
	buscar([X|Xs], E, P),
	cantSint(E, T),
	T > 0,
	K is P * 100 / T.

% Receta medica segun sintoma:
recetade(M, S) :-
	sintomade(S, Z),
	medicinade(M, Z).

% Especialista que atiende segun sintoma :
atiende_especialista(E, S) :-
	sintomade(S, Z),
	especialistade(E, Z).

atiendeespecialista(E, S) :-
	atiende_especialista(E, S).

% Especialista y medicina recomendados para una enfermedad E:
mereceta(Es, M, E) :-
	medicinade(M, E),
	sintomade(S, E),
	atiendeespecialista(Es, S).


% =========================================================================
% 3. TEMPLATES CONVERSACIONALES DE ELIZA (MEDICOS + GENERALES)
% =========================================================================

% --- Saludos y presentacion ---
template([hola, mi, nombre, es, s(_), '.'], ['Hola', 0, 'como', estas, tu, '?', 'En', que, puedo, ayudarte, hoy, '?'], [4]).
template([buendia, mi, nombre, es, s(_), '.'], ['Buen', dia, 0, 'como', estas, tu, '?'], [4]).
template([hola, ',', mi, nombre, es, s(_), '.'], ['Hola', 0, 'como', estas, tu, '?'], [5]).
template([buendia, ',', mi, nombre, es, s(_), '.'], ['Buendia', 'como', estas, tu, 0, '?'], [5]).
template([hola, mi, nombre, es, s(_)], ['Hola', 0, 'como', estas, tu, '?', 'En', que, puedo, ayudarte, '?'], [4]).
template([hola, _], ['Hola', 'como', estas, tu, '?', 'Preguntame', sobre, tus, dolencias,  '.'], []).
template([hola], ['Hola', 'como', estas, tu, '?', 'Preguntame', sobre, diabetes, o, enfermedades, '.'], []).
template([buendia, _], ['Buendia', 'Como', estas, tu, '?'], []).
template([buendia], ['Buendia', 'Como', estas, tu, '?'], []).
template([como, estas, tu, '?'], [yo, estoy, bien, ',', gracias, por, preguntar, '.'], []).
template([como, estas], [yo, estoy, bien, ',', lista, para, orientarte, sobre, sintomas, y, enfermedades,  '.'], []).

% --- Consultas combinadas (Especialista + Medicamento, Consulta 5 de la guia) ---
template([si, _, tiene, enfermedad, de, la, s(_), que, especialista, lo, atiende, y, que, medicina, le, recetan], [flagMereceta], [6]).
template([si, _, tiene, enfermedad, de, s(_), que, especialista, lo, atiende, y, que, medicina, le, recetan], [flagMereceta], [5]).
template([si, _, tiene, la, enfermedad, de, s(_), que, especialista, lo, atiende, y, que, medicina, le, recetan], [flagMereceta], [6]).
template([si, _, tiene, s(_), que, especialista, lo, atiende, y, que, medicina, le, recetan], [flagMereceta], [3]).
template([que, especialista, y, que, medicina, me, recetan, para, la, enfermedad, de, s(_)], [flagMereceta], [11]).
template([que, especialista, y, que, medicina, me, recetan, para, la, s(_)], [flagMereceta], [9]).
template([que, especialista, y, que, medicina, me, recetan, para, s(_)], [flagMereceta], [8]).
template([tratamiento, completo, para, la, enfermedad, de, s(_)], [flagMereceta], [6]).
template([tratamiento, completo, para, la, s(_)], [flagMereceta], [4]).
template([tratamiento, completo, para, s(_)], [flagMereceta], [3]).

% --- Consultas de Sintomas de una Enfermedad ---
template([cuales, son, los, sintomas, de, la, enfermedad, de, s(_)], [flagSintomas], [8]).
template([cuales, son, los, sintomas, del, sindrome, de, s(_)], [flagSintomas], [7]).
template([cuales, son, los, sintomas, de, la, s(_)], [flagSintomas], [6]).
template([cuales, son, los, sintomas, del, s(_)], [flagSintomas], [5]).
template([cuales, son, los, sintomas, de, s(_)], [flagSintomas], [5]).
template([que, sintomas, tiene, la, enfermedad, de, s(_)], [flagSintomas], [6]).
template([que, sintomas, tiene, la, s(_)], [flagSintomas], [4]).
template([que, sintomas, tiene, el, s(_)], [flagSintomas], [4]).
template([que, sintomas, tiene, s(_)], [flagSintomas], [3]).
template([que, sintomas, presenta, la, enfermedad, de, s(_)], [flagSintomas], [6]).
template([que, sintomas, presenta, la, s(_)], [flagSintomas], [4]).
template([que, sintomas, presenta, s(_)], [flagSintomas], [3]).
template([dime, los, sintomas, de, la, enfermedad, de, s(_)], [flagSintomas], [7]).
template([dime, los, sintomas, de, la, s(_)], [flagSintomas], [5]).
template([dime, los, sintomas, de, s(_)], [flagSintomas], [4]).
template([sintomas, de, la, enfermedad, de, s(_)], [flagSintomas], [5]).
template([sintomas, de, la, s(_)], [flagSintomas], [3]).
template([sintomas, de, s(_)], [flagSintomas], [2]).

% --- Consultas de Especialistas Recomendados ---
template([si, _, tiene, la, enfermedad, de, s(_), que, especialista, lo, atiende], [flagEspecialista], [6]).
template([si, _, tiene, enfermedad, de, s(_), que, especialista, lo, atiende], [flagEspecialista], [5]).
template([si, _, tiene, s(_), que, especialista, lo, atiende], [flagEspecialista], [3]).
template([que, especialista, atiende, la, enfermedad, de, s(_)], [flagEspecialista], [6]).
template([que, especialista, atiende, la, s(_)], [flagEspecialista], [4]).
template([que, especialista, atiende, el, s(_)], [flagEspecialista], [4]).
template([que, especialista, atiende, s(_)], [flagEspecialista], [3]).
template([que, especialista, trata, la, enfermedad, de, s(_)], [flagEspecialista], [6]).
template([que, especialista, trata, la, s(_)], [flagEspecialista], [4]).
template([que, especialista, trata, s(_)], [flagEspecialista], [3]).
template([que, especialistas, recomiendas, para, la, enfermedad, de, s(_)], [flagEspecialista], [7]).
template([que, especialistas, recomiendas, para, la, s(_)], [flagEspecialista], [5]).
template([que, especialistas, recomiendas, para, s(_)], [flagEspecialista], [4]).
template([que, medico, atiende, la, enfermedad, de, s(_)], [flagEspecialista], [6]).
template([que, medico, atiende, la, s(_)], [flagEspecialista], [4]).
template([que, medico, atiende, s(_)], [flagEspecialista], [3]).
template([a, que, especialista, debo, ir, por, s(_)], [flagEspecialista], [6]).
template([a, que, especialista, voy, si, tengo, s(_)], [flagEspecialista], [6]).
template([especialista, para, la, enfermedad, de, s(_)], [flagEspecialista], [5]).
template([especialista, para, la, s(_)], [flagEspecialista], [3]).
template([especialista, para, s(_)], [flagEspecialista], [2]).
template([especialistas, de, s(_)], [flagEspecialista], [2]).

% --- Consultas de Medicamentos por Enfermedad  ---
template([si, tengo, la, enfermedad, de, s(_), que, medicamento, debo, tomar], [flagMedicina], [5]).
template([si, tengo, enfermedad, de, la, s(_), que, medicamento, debo, tomar], [flagMedicina], [5]).
template([si, tengo, enfermedad, de, s(_), que, medicamento, debo, tomar], [flagMedicina], [4]).
template([si, tengo, la, s(_), que, medicamento, debo, tomar], [flagMedicina], [3]).
template([si, tengo, s(_), que, medicamento, debo, tomar], [flagMedicina], [2]).
template([que, medicamento, debo, tomar, para, la, enfermedad, de, s(_)], [flagMedicina], [8]).
template([que, medicamento, debo, tomar, para, la, s(_)], [flagMedicina], [6]).
template([que, medicamento, debo, tomar, para, s(_)], [flagMedicina], [5]).
template([que, medicamentos, se, usan, para, la, enfermedad, de, s(_)], [flagMedicina], [8]).
template([que, medicamentos, se, usan, para, la, s(_)], [flagMedicina], [6]).
template([que, medicamentos, se, usan, para, s(_)], [flagMedicina], [5]).
template([que, medicamentos, hay, para, la, enfermedad, de, s(_)], [flagMedicina], [7]).
template([que, medicamentos, hay, para, la, s(_)], [flagMedicina], [5]).
template([que, medicamentos, hay, para, s(_)], [flagMedicina], [4]).
template([que, medicina, debo, tomar, para, la, enfermedad, de, s(_)], [flagMedicina], [8]).
template([que, medicina, debo, tomar, para, la, s(_)], [flagMedicina], [6]).
template([que, medicina, debo, tomar, para, s(_)], [flagMedicina], [5]).
template([que, medicamentos, recomiendas, para, la, enfermedad, de, s(_)], [flagMedicina], [7]).
template([que, medicamentos, recomiendas, para, la, s(_)], [flagMedicina], [5]).
template([que, medicamentos, recomiendas, para, s(_)], [flagMedicina], [4]).
template([medicamentos, para, la, enfermedad, de, s(_)], [flagMedicina], [5]).
template([medicamentos, para, la, s(_)], [flagMedicina], [3]).
template([medicamentos, para, s(_)], [flagMedicina], [2]).
template([medicina, para, s(_)], [flagMedicina], [2]).

% --- Consultas de Receta Medica por Sintoma ---
template([si, tengo, sintoma, de, s(_), que, medicina, debo, tomar], [flagReceta], [4]).
template([si, tengo, el, sintoma, de, s(_), que, medicina, debo, tomar], [flagReceta], [5]).
template([si, tengo, sintoma, de, s(_), que, medicamento, debo, tomar], [flagReceta], [4]).
template([que, medicina, debo, tomar, si, tengo, s(_)], [flagReceta], [6]).
template([que, me, recetan, para, el, sintoma, s(_)], [flagReceta], [6]).
template([que, me, recetan, para, s(_)], [flagReceta], [4]).
template([receta, para, el, sintoma, s(_)], [flagReceta], [4]).
template([receta, para, s(_)], [flagReceta], [2]).

% --- Consultas de Diagnostico por Sintomas del Paciente ---
template([tengo, los, sintomas, s(_), ',', s(_), y, s(_)], [flagDiagnostico3], [3, 5, 7]).
template([tengo, los, sintomas, s(_), s(_), y, s(_)], [flagDiagnostico3], [3, 4, 6]).
template([tengo, s(_), ',', s(_), y, s(_)], [flagDiagnostico3], [1, 3, 5]).
template([tengo, s(_), s(_), y, s(_)], [flagDiagnostico3], [1, 2, 4]).
template([presento, s(_), ',', s(_), y, s(_)], [flagDiagnostico3], [1, 3, 5]).
template([presento, s(_), s(_), y, s(_)], [flagDiagnostico3], [1, 2, 4]).
template([siento, s(_), ',', s(_), y, s(_)], [flagDiagnostico3], [1, 3, 5]).
template([siento, s(_), s(_), y, s(_)], [flagDiagnostico3], [1, 2, 4]).

template([tengo, los, sintomas, s(_), y, s(_)], [flagDiagnostico2], [3, 5]).
template([tengo, s(_), y, s(_)], [flagDiagnostico2], [1, 3]).
template([presento, s(_), y, s(_)], [flagDiagnostico2], [1, 3]).
template([siento, s(_), y, s(_)], [flagDiagnostico2], [1, 3]).
template([padezco, s(_), y, s(_)], [flagDiagnostico2], [1, 3]).

template([tengo, la, enfermedad, de, s(_)], [flagMereceta], [4]).
template([tengo, enfermedad, de, s(_)], [flagMereceta], [3]).
template([tengo, el, sintoma, de, s(_)], [flagDiagnostico1], [4]).
template([tengo, sintoma, de, s(_)], [flagDiagnostico1], [3]).
template([tengo, s(_)], [flagDiagnostico1], [1]).
template([siento, s(_)], [flagDiagnostico1], [1]).
template([presento, s(_)], [flagDiagnostico1], [1]).
template([padezco, de, la, enfermedad, de, s(_)], [flagMereceta], [5]).
template([padezco, de, s(_)], [flagDiagnostico1], [2]).
template([padezco, s(_)], [flagDiagnostico1], [1]).
template([que, enfermedad, produce, s(_)], [flagDiagnostico1], [3]).
template([a, que, enfermedad, pertenece, el, sintoma, s(_)], [flagDiagnostico1], [6]).
template([a, que, enfermedad, pertenece, s(_)], [flagDiagnostico1], [4]).

% --- Verificar si un sintoma pertenece a una enfermedad especifica ---
template([es, s(_), un, sintoma, de, la, enfermedad, de, s(_)], [flagVerificarSintoma], [1, 8]).
template([es, s(_), un, sintoma, de, la, s(_)], [flagVerificarSintoma], [1, 6]).
template([es, s(_), un, sintoma, de, s(_)], [flagVerificarSintoma], [1, 5]).
template([el, sintoma, s(_), es, de, s(_)], [flagVerificarSintoma], [2, 5]).

% --- Informacion general de una enfermedad ---
template([que, es, la, enfermedad, de, s(_)], [flagInfoEnfermedad], [5]).
template([que, es, la, s(_)], [flagInfoEnfermedad], [3]).
template([que, es, el, s(_)], [flagInfoEnfermedad], [3]).
template([hablame, de, la, enfermedad, de, s(_)], [flagInfoEnfermedad], [5]).
template([hablame, de, la, s(_)], [flagInfoEnfermedad], [3]).
template([hablame, de, s(_)], [flagInfoEnfermedad], [2]).
template([informacion, de, la, enfermedad, de, s(_)], [flagInfoEnfermedad], [5]).
template([informacion, de, s(_)], [flagInfoEnfermedad], [2]).


template([yo, s(_), yo, soy, s(_), '.'], [por, que, 0, eres, 1, '?'], [1, 4]).
template([yo, s(_), tu, '.'], [why, do, you, 0, me, '?'], [1]).
template([yo, soy, s(_), '.'], [porque, eres, tu, 0, '?'], [2]).

% Pregunta algo que le gusta a Eliza
template([te, gustan, las, s(_), _], [flagLike], [3]).
template([te, gustan, los, s(_), _], [flagLike], [3]).

% Pregunta algo que hace Eliza
template([tu, eres, s(_), _], [flagDo], [2]).

% Pregunta algo que es Eliza
template([que, eres, tu, s(_)], [flagIs], [2]).
template([eres, s(_), '?'], [flagIs], [2]).

template([yo, pienso, que, _], [bueno, esa, es, tu, opinion], []).
template([porque, _], [esa, no, es, una, buena, razon, '.'], []).
template([i, have, s(_), with, s(_), '.'], ['You', have, to, deal, with, your, 0, and, your, 1, in, a, mature, way, '.'], [2, 4]).
template([i, s(_), _], [i, can, recommend, you, a, book, about, that, issue], []).
template([please, s(_), _], ['No', i, can, not, help, ',', i, am, just, a, machine], []).
template([tell, me, a, s(_), _], ['No', i, can, not, ',', i, am, bad, at, that], []).

% Template por defecto
template(_, ['Por', favor, explica, un, poco, mas, tu, consulta, '(puedes', preguntar, por, sintomas, ',', especialistas, o, medicamentos, de, diabetes, o, meniere, ').'], []).


% =========================================================================
% 4. RESPUESTAS DE FLAGS DEL SISTEMA EXPERTO Y DE ELIZA
% =========================================================================

% --- Flag: Sintomas de una enfermedad ---
elizaSintomas(EnfRaw, R) :-
	normalizar_enfermedad(EnfRaw, Enf),
	enfermedad(Enf),
	findall(S, sintomade(S, Enf), ListaSintomas),
	ListaSintomas \= [], !,
	append(['Los', sintomas, registrados, de, Enf, son, ':'], ListaSintomas, R).
elizaSintomas(EnfRaw, R) :-
	R = ['Lo', siento, ',', no, tengo, sintomas, registrados, para, EnfRaw, '.', 'Consulta', por, diabetes, o, meniere, '.'].

% --- Flag: Especialistas recomendados (acepta enfermedad o sintoma) ---
elizaEspecialista(TermRaw, R) :-
	normalizar_enfermedad(TermRaw, Enf),
	enfermedad(Enf),
	findall(Esp, especialistade(Esp, Enf), ListaRaw),
	sort(ListaRaw, ListaEsp),
	ListaEsp \= [], !,
	append(['Los', especialistas, recomendados, para, tratar, Enf, son, ':'], ListaEsp, R).
elizaEspecialista(Sintoma, R) :-
	findall(Esp, atiende_especialista(Esp, Sintoma), ListaRaw),
	sort(ListaRaw, ListaEsp),
	ListaEsp \= [], !,
	append(['Para', el, sintoma, Sintoma, se, recomienda, acudir, con, ':'], ListaEsp, R).
elizaEspecialista(TermRaw, R) :-
	R = ['No', encontre, especialistas, asociados, a, TermRaw, '.', 'Intenta', con, diabetes, ',', meniere, o, un, sintoma, especifico, '.'].

% --- Flag: Medicamentos posibles para una enfermedad (o sintoma) ---
elizaMedicina(TermRaw, R) :-
	normalizar_enfermedad(TermRaw, Enf),
	enfermedad(Enf),
	findall(Med, medicinade(Med, Enf), ListaRaw),
	sort(ListaRaw, ListaMed),
	ListaMed \= [], !,
	append(['Los', medicamentos, posibles, para, Enf, son, ':'], ListaMed, R).
elizaMedicina(Sintoma, R) :-
	findall(Med, recetade(Med, Sintoma), ListaRaw),
	sort(ListaRaw, ListaMed),
	ListaMed \= [], !,
	append(['Para', el, sintoma, Sintoma, los, medicamentos, posibles, son, ':'], ListaMed, R).
elizaMedicina(TermRaw, R) :-
	R = ['No', encontre, medicamentos, registrados, para, TermRaw, '.', 'Intenta', consultar, por, diabetes, o, meniere, '.'].

% --- Flag: Receta medica segun sintoma ---
elizaReceta(Sintoma, R) :-
	findall(Med, recetade(Med, Sintoma), ListaRaw),
	sort(ListaRaw, ListaMed),
	ListaMed \= [],
	findall(Enf, sintomade(Sintoma, Enf), EnfRaw),
	sort(EnfRaw, ListaEnf), !,
	append(['El', sintoma, Sintoma, se, asocia, con], ListaEnf, Parte1),
	append(Parte1, ['y', los, medicamentos, posibles, son, ':'], Parte2),
	append(Parte2, ListaMed, R).
elizaReceta(Topic, R) :-
	normalizar_enfermedad(Topic, Enf),
	enfermedad(Enf), !,
	elizaMedicina(Enf, R).
elizaReceta(Sintoma, R) :-
	R = ['No', tengo, el, sintoma, Sintoma, en, mi, base, de, conocimientos, '.'].

% --- Flag: Consulta combinada ---
elizaMereceta(TermRaw, R) :-
	normalizar_enfermedad(TermRaw, Enf),
	enfermedad(Enf),
	findall(Es, especialistade(Es, Enf), EspRaw),
	sort(EspRaw, ListaEsp),
	findall(M, medicinade(M, Enf), MedRaw),
	sort(MedRaw, ListaMed), !,
	append(['Para', Enf, '-> Especialistas recomendados:'], ListaEsp, P1),
	append(P1, ['| Medicamentos posibles:'], P2),
	append(P2, ListaMed, R).
elizaMereceta(TermRaw, R) :-
	R = ['No', tengo, informacion, combinada, de, especialista, y, receta, para, TermRaw, '.'].

% --- Flag: Diagnostico con 1 sintoma (o nombre de enfermedad) ---
elizaDiagnostico1(Sintoma, R) :-
	findall(Enf, sintomade(Sintoma, Enf), EnfRaw),
	sort(EnfRaw, ListaEnf),
	ListaEnf \= [],
	findall(Esp, atiende_especialista(Esp, Sintoma), EspRaw),
	sort(EspRaw, ListaEsp),
	findall(Med, recetade(Med, Sintoma), MedRaw),
	sort(MedRaw, ListaMed), !,
	append(['El', sintoma, Sintoma, corresponde, a, ':'], ListaEnf, P1),
	append(P1, ['| Especialistas recomendados:'], P2),
	append(P2, ListaEsp, P3),
	append(P3, ['| Medicamentos posibles:'], P4),
	append(P4, ListaMed, R).
elizaDiagnostico1(TermRaw, R) :-
	normalizar_enfermedad(TermRaw, Enf),
	enfermedad(Enf), !,
	elizaMereceta(Enf, R).
elizaDiagnostico1(Sintoma, R) :-
	R = ['No', reconozco, el, sintoma, Sintoma, '.', 'Ejemplos:', polidipsia, ',', poliuria, ',', polifagia, ',', fatiga, ',', vertigo, ',', tinnitus, ',', hipoacusia, ',', presion_oido, '.'].

% --- Auxiliar para formatear porcentaje de coincidencia en diagnostico ---
calcular_resumen_prob([], _, []).
calcular_resumen_prob([E|Es], ListaS, [E, '(', Pct, '%', ')'|Resto]) :-
	diagnostico(ListaS, E, K),
	Pct is round(K),
	calcular_resumen_prob(Es, ListaS, Resto).

% --- Flag: Diagnostico con 2 sintomas ---
elizaDiagnostico2(S1, S2, R) :-
	findall(E, (enfermedad(E), buscar([S1, S2], E, P), P > 0), EnfRaw),
	sort(EnfRaw, ListaEnf),
	ListaEnf \= [],
	calcular_resumen_prob(ListaEnf, [S1, S2], ResumenProb),
	findall(Esp, (member(E, ListaEnf), especialistade(Esp, E)), EspRaw),
	sort(EspRaw, ListaEsp),
	findall(Med, (member(E, ListaEnf), medicinade(Med, E)), MedRaw),
	sort(MedRaw, ListaMed), !,
	append(['Con', los, sintomas, S1, y, S2, '-> Posibles enfermedades y coincidencia:'], ResumenProb, P1),
	append(P1, ['| Especialistas:'], P2),
	append(P2, ListaEsp, P3),
	append(P3, ['| Medicamentos posibles:'], P4),
	append(P4, ListaMed, R).
elizaDiagnostico2(S1, S2, R) :-
	R = ['Ninguna', enfermedad, registrada, coincide, con, los, sintomas, S1, y, S2, '.'].

% --- Flag: Diagnostico con 3 sintomas ---
elizaDiagnostico3(S1, S2, S3, R) :-
	findall(E, (enfermedad(E), buscar([S1, S2, S3], E, P), P > 0), EnfRaw),
	sort(EnfRaw, ListaEnf),
	ListaEnf \= [],
	calcular_resumen_prob(ListaEnf, [S1, S2, S3], ResumenProb),
	findall(Esp, (member(E, ListaEnf), especialistade(Esp, E)), EspRaw),
	sort(EspRaw, ListaEsp),
	findall(Med, (member(E, ListaEnf), medicinade(Med, E)), MedRaw),
	sort(MedRaw, ListaMed), !,
	append(['Con', los, sintomas, S1, ',', S2, y, S3, '-> Posibles enfermedades y coincidencia:'], ResumenProb, P1),
	append(P1, ['| Especialistas:'], P2),
	append(P2, ListaEsp, P3),
	append(P3, ['| Medicamentos posibles:'], P4),
	append(P4, ListaMed, R).
elizaDiagnostico3(S1, S2, S3, R) :-
	R = ['Ninguna', enfermedad, registrada, coincide, con, los, sintomas, S1, ',', S2, y, S3, '.'].

% --- Flag: Verificar si un sintoma pertenece a una enfermedad ---
elizaVerificarSintoma(Sintoma, EnfRaw, R) :-
	normalizar_enfermedad(EnfRaw, Enf),
	sintomade(Sintoma, Enf), !,
	R = ['Si', ',', Sintoma, es, un, sintoma, caracteristico, de, Enf, '.'].
elizaVerificarSintoma(Sintoma, EnfRaw, R) :-
	normalizar_enfermedad(EnfRaw, Enf),
	R = ['No', ',', Sintoma, no, esta, registrado, como, sintoma, de, Enf, '.'].

% --- Flag: Informacion general sobre Diabetes y Enfermedad de Meniere ---
elizaInfoEnfermedad(EnfRaw, R) :-
	normalizar_enfermedad(EnfRaw, diabetes), !,
	R = ['La', diabetes, es, una, enfermedad, metabolica, cronica, caracterizada, por, niveles, elevados, de, glucosa, en, sangre, '(sintomas:', polidipsia, ',', poliuria, ',', polifagia, ',', fatiga, ',', vision_borrosa, ';', especialista, ':', endocrinologo, ').'].
elizaInfoEnfermedad(EnfRaw, R) :-
	normalizar_enfermedad(EnfRaw, meniere), !,
	R = ['La', enfermedad, de, meniere, es, un, trastorno, del, oido, interno, causado, por, acumulacion, de, liquido, endolinfatico, '(sintomas:', vertigo, ',', tinnitus, ',', hipoacusia, ',', presion_oido, ';', especialista, ':', otorrinolaringologo, ').'].
elizaInfoEnfermedad(EnfRaw, R) :-
	normalizar_enfermedad(EnfRaw, Enf),
	enfermedad(Enf), !,
	elizaMereceta(Enf, R).
elizaInfoEnfermedad(EnfRaw, R) :-
	R = ['No', cuento, con, una, descripcion, detallada, para, EnfRaw, '.', 'Pregunta', por, diabetes, o, meniere, '.'].

% --- Flags originales de la plantilla de Eliza ---
% Lo que le gusta a Eliza: flagLike
elizaLikes(X, R) :- likes(X), R = ['Yeah', i, like, X].
elizaLikes(X, R) :- \+likes(X), R = ['Nope', i, do, not, like, X].
likes(apples).
likes(ponies).
likes(zombies).
likes(manzanas).
likes(computadoras).
likes(carros).
likes(caballos).

% Lo que hace Eliza: flagDo
elizaDoes(X, R) :- does(X), R = ['Yes', i, X, and, i, love, it].
elizaDoes(X, R) :- \+does(X), R = ['No', i, do, not, X, '.', it, is, too, hard, for, me].
does(study).
does(cook).
does(work).

% Lo que es Eliza: flagIs
elizaIs(X, R) :- is0(X), R = ['Yes', yo, soy, X].
elizaIs(X, R) :- \+is0(X), R = ['No', i, am, not, X].
is0(dumb).
is0(weird).
is0(nice).
is0(fine).
is0(happy).
is0(redundant).


% =========================================================================
% 5. MOTOR DE EMPAREJAMIENTO (MATCH) Y REEMPLAZO (REPLACE0)
% =========================================================================

match([], []).
match([], _) :- true.

match([S|Stim], [I|Input]) :-
	atom(S), % Si S es un s(X) devuelve falso
	S == I,
	match(Stim, Input), !.

match([S|Stim], [_|Input]) :-
	% S es un s(X) o variable anonima, lo ignoro y continuo con el resto de la lista
	\+atom(S),
	match(Stim, Input), !.

replace0([], _, _, Resp, R) :- append(Resp, [], R), !.

% --- Reemplazos de Flags de 3 parametros (Diagnostico de 3 sintomas) ---
replace0([I1, I2, I3|_], Input, _, Resp, R) :-
	nth0(0, Resp, X),
	X == flagDiagnostico3,
	nth0(I1, Input, Atom1),
	nth0(I2, Input, Atom2),
	nth0(I3, Input, Atom3),
	elizaDiagnostico3(Atom1, Atom2, Atom3, R), !.

% --- Reemplazos de Flags de 2 parametros ---
replace0([I1, I2|_], Input, _, Resp, R) :-
	nth0(0, Resp, X),
	X == flagDiagnostico2,
	nth0(I1, Input, Atom1),
	nth0(I2, Input, Atom2),
	elizaDiagnostico2(Atom1, Atom2, R), !.

replace0([I1, I2|_], Input, _, Resp, R) :-
	nth0(0, Resp, X),
	X == flagVerificarSintoma,
	nth0(I1, Input, Atom1),
	nth0(I2, Input, Atom2),
	elizaVerificarSintoma(Atom1, Atom2, R), !.

% --- Reemplazos de Flags de 1 parametro del Sistema Experto ---
replace0([I|_], Input, _, Resp, R) :-
	nth0(I, Input, Atom),
	nth0(0, Resp, X),
	X == flagSintomas,
	elizaSintomas(Atom, R), !.

replace0([I|_], Input, _, Resp, R) :-
	nth0(I, Input, Atom),
	nth0(0, Resp, X),
	X == flagEspecialista,
	elizaEspecialista(Atom, R), !.

replace0([I|_], Input, _, Resp, R) :-
	nth0(I, Input, Atom),
	nth0(0, Resp, X),
	X == flagMedicina,
	elizaMedicina(Atom, R), !.

replace0([I|_], Input, _, Resp, R) :-
	nth0(I, Input, Atom),
	nth0(0, Resp, X),
	X == flagReceta,
	elizaReceta(Atom, R), !.

replace0([I|_], Input, _, Resp, R) :-
	nth0(I, Input, Atom),
	nth0(0, Resp, X),
	X == flagMereceta,
	elizaMereceta(Atom, R), !.

replace0([I|_], Input, _, Resp, R) :-
	nth0(I, Input, Atom),
	nth0(0, Resp, X),
	X == flagDiagnostico1,
	elizaDiagnostico1(Atom, R), !.

replace0([I|_], Input, _, Resp, R) :-
	nth0(I, Input, Atom),
	nth0(0, Resp, X),
	X == flagInfoEnfermedad,
	elizaInfoEnfermedad(Atom, R), !.

% --- Reemplazos de Flags originales de Eliza ---
% Eliza likes:
replace0([I|_], Input, _, Resp, R) :-
	nth0(I, Input, Atom),
	nth0(0, Resp, X),
	X == flagLike,
	elizaLikes(Atom, R), !.

% Eliza does:
replace0([I|_], Input, _, Resp, R) :-
	nth0(I, Input, Atom),
	nth0(0, Resp, X),
	X == flagDo,
	elizaDoes(Atom, R), !.

% Eliza is:
replace0([I|_], Input, _, Resp, R) :-
	nth0(I, Input, Atom),
	nth0(0, Resp, X),
	X == flagIs,
	elizaIs(Atom, R), !.

% --- Reemplazo posicional estandar de Eliza ---
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
