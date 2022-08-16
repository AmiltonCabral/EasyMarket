% Retorna o ultimo elemento de uma lista.
discontiguous last(X,[X]).
discontiguous last(X,[_|Z]) :- last(X,Z).