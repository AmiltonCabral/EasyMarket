:- use_module(library(csv)).

% Retorna o ultimo elemento de uma lista.
last(X,[X]).
last(X,[_|Z]) :- last(X,Z).

% Retorna o ultimo id de compraDB.csv
getLastId(Id):-
   readCSV(File),
   last(row(X, _, _), File),
   (
      X == 'id' -> Id is 0;
      Id is X
   ).

% Fato dinâmico para gerar o id dos agentes
id(X) :- getLastId(LastId), X is LastId + 1.

% Lendo arquivo JSON puro
readCSV(File) :- csv_read_file('db/compraDB.csv', File).

% Regras para listar todos os produtos
printCompraAux([]).
printCompraAux([row(ID, Produto, Quantidade)|T]) :-
   write("ID:"), writeln(ID),
   write("Produto: "), writeln(Produto),
   write("Quantidade: "), writeln(Quantidade), nl, printCompraAux(T).

printCompras() :-
   readCSV([_|File]),
   printCompraAux(File),
   print("Digite qualquer tecla para voltar..."),
   read(_).

% Salvar em arquivo CSV
putCompra(Produto, Quantidade) :-
   id(ID),
   readCSV(File),
   append(File, [row(ID, Produto, Quantidade)], Saida),
   csv_write_file("db/compraDB.csv", Saida).

% Removendo um agente
removeCompraCSV([], _, []).
removeCompraCSV([row(Id, _, _)|T], Id, T).
removeCompraCSV([H|T], Id, [H|Out]) :- removeCompraCSV(T, Id, Out).

removeCompra(Id) :-
   readCSV(File),
   removeCompraCSV(File, Id, Saida),
   csv_write_file("db/compraDB.csv", Saida).
