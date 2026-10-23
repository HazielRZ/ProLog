%==============================
%    Informe Residencial
%==============================
% ------------------------------------------------------------------------------
% MISIÓN 1 — El Dominio de la Calle
% Hechos de dominio: átomos en minúsculas para personas, colores, bebidas y mascotas
% ------------------------------------------------------------------------------

% Personas (persona/1)
persona(ana).
persona(beto).
persona(carla).
persona(diego).

% Colores de las casas (color/1)
color(blanca).
color(verde).
color(roja).
color(azul).

% Bebidas (bebida/1)
bebida(agua).
bebida(cafe).
bebida(leche).
bebida(te).

% Mascotas (mascota/1)
mascota(gato).
mascota(perro).
mascota(pez).
mascota(loro).

% ------------------------------------------------------------------------------
% MISIÓN 2 y MISIÓN 4 — Hechos del Expediente (Pistas Directas + Deducción)
% Predicados obligatorios: vive_en/2, color_casa/2, bebe/2, tiene/2
% ------------------------------------------------------------------------------

% vive_en(Persona, NumeroCasa)
vive_en(ana, 1).        % [Misión 2 - Hecho directo] Pista 1: Ana vive en la casa 1.
vive_en(beto, 2).       % [Misión 4 - Deducción] Pistas 3, 5, 4, 9 y 12: Beto vive en la casa verde (2).
vive_en(carla, 3).      % [Misión 4 - Deducción] Pista 6 y descarte de casas 1, 2 y 4: Carla vive en la casa 3.
vive_en(diego, 4).      % [Misión 4 - Deducción] Pistas 9, 12, 4 y 2: Diego vive en la casa azul (4).

% color_casa(NumeroCasa, Color)
color_casa(1, blanca).  % [Misión 4 - Deducción inmediata] Pistas 1 y 2: Ana vive en la casa 1 y en la blanca.
color_casa(2, verde).   % [Misión 4 - Deducción] Pistas 4, 5, 12 y 9: La verde está a la izq. de la roja (2 y 3).
color_casa(3, roja).    % [Misión 4 - Deducción] Pista 4: La casa roja está inmediatamente a la der. de la verde.
color_casa(4, azul).    % [Misión 4 - Deducción] Pistas 9, 12 y 4: La casa 4 no puede ser verde ni roja, es azul.

% bebe(Persona, Bebida)
bebe(ana, agua).        % [Misión 4 - Deducción] Pistas 3, 6, 12 y 8: Por descarte de bebidas, Ana bebe agua.
bebe(beto, cafe).       % [Misión 2 - Hecho directo] Pista 3: Beto bebe café.
bebe(carla, leche).     % [Misión 2 - Hecho directo] Pista 6: Carla bebe leche.
bebe(diego, te).        % [Misión 4 - Deducción] Pista 12 y ubicación de Diego en casa 4: Diego bebe té.

% tiene(Persona, Mascota)
tiene(ana, gato).       % [Misión 4 - Deducción] Pista 8: Quien tiene el gato bebe agua (Ana).
tiene(beto, perro).     % [Misión 4 - Deducción] Descarte de mascotas y verificación con Pista 7 (vecino de Ana).
tiene(carla, pez).      % [Misión 2 - Hecho directo] Pista 11: Carla tiene el pez.
tiene(diego, loro).     % [Misión 4 - Deducción] Pista 10: Quien tiene el loro bebe té (Diego).

% ------------------------------------------------------------------------------
% MISIÓN 3 — La Fábrica de Reglas
% ------------------------------------------------------------------------------

% 1. dueno_del_pez(P) — P tiene el pez.
dueno_del_pez(P) :-
    tiene(P, pez).

% 2. color_de(Persona, Color) — une vive_en con color_casa mediante la variable compartida N.
color_de(Persona, Color) :-
    vive_en(Persona, N),
    color_casa(N, Color).

% 3. vecinos(P1, P2) — viven en casas cuya diferencia de número es 1.
vecinos(P1, P2) :-
    vive_en(P1, N1),
    vive_en(P2, N2),
    abs(N1 - N2) =:= 1.

% 4. bebe_en_casa(N, B) — en la casa N se bebe B (vía la persona que vive ahí).
bebe_en_casa(N, B) :-
    vive_en(P, N),
    bebe(P, B).

% 5. perfil(P, N, Color, Bebida, Mascota) — los cinco datos de una persona.
perfil(P, N, Color, Bebida, Mascota) :-
    persona(P),
    vive_en(P, N),
    color_casa(N, Color),
    bebe(P, Bebida),
    tiene(P, Mascota).