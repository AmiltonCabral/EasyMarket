:- module(carrinho, [printCarrinho/0, putProdutoNoCarrinho/2, removeProdutoDoCarrinho/1]).
:- use_module(library(csv)).


% Retorna o ultimo elemento de uma lista.
last(X,[X]).
last(X,[_|Z]) :- last(X,Z).

% Retorna o ultimo id de carrinhoDB.csv
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
readCSV(File) :- csv_read_file('db/carrinhoDB.csv', File).

% Regras para listar todos os produtos
printCarrinhoAux([]).
printCarrinhoAux([row(ID, Produto, Quantidade)|T]) :-
   write("ID:"), writeln(ID),
   write("Produto: "), writeln(Produto),
   write("Quantidade: "), writeln(Quantidade), nl, printCarrinhoAux(T).

printCarrinho() :-
   readCSV([_|File]),
   printCarrinhoAux(File),
   print("Digite qualquer tecla para voltar..."),
   read(_).

% Salvar em arquivo CSV
putProdutoNoCarrinho(Produto, Quantidade) :-
   id(ID),
   readCSV(File),
   append(File, [row(ID, Produto, Quantidade)], Saida),
   csv_write_file("db/carrinhoDB.csv", Saida).

% Removendo um agente
removeProdutoDoCarrinhoCSV([], _, []).
removeProdutoDoCarrinhoCSV([row(Id, _, _)|T], Id, T).
removeProdutoDoCarrinhoCSV([H|T], Id, [H|Out]) :- removeProdutoDoCarrinhoCSV(T, Id, Out).

removeProdutoDoCarrinho(Id) :-
   readCSV(File),
   removeProdutoDoCarrinhoCSV(File, Id, Saida),
   csv_write_file("db/carrinhoDB.csv", Saida).
