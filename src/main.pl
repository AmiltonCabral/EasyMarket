% :- include('produto.pl').
% :- include('carrinho.pl').
:- use_module(produto, [printProdutos/0, putProduto/3, removeProduto/1, getProduto/2]).
:- use_module(carrinho, [printCarrinho/0, putProdutoNoCarrinho/4, removeProdutoDoCarrinho/1]).

main():-
    write('\e[2J'),
    print('1 - User'),nl,
    print('2 - Admin'),nl,
    print('0 - Sair'),nl,
    read(Option),
    mainOption(Option),
    main().

mainOption(1):- user().
mainOption(2):- admin().
mainOption(0):- halt(0).



% User ----------------------------
user():-
    write('\e[2J'),
    print('1 - Listar Produtos.'),nl,
    print('2 - Adicionar produto no carrinho.'),nl,
    print('3 - Remover produto do carrinho.'),nl,
    print('0 - Voltar para a tela inicial.'),nl,
    read(Option),
    userOption(Option),
    user().

userOption(1):- printProdutos().
userOption(2):-
    print('Digite o ID:'),nl,
    read(Id),
    print('Digite a quantidade:'),nl,
    read(Quantidade),
    getProduto(Id, row(_, Nome, Preco, Categoria)),
    putProdutoNoCarrinho(Nome, Preco, Categoria, Quantidade).
userOption(3):-
    print('Digite o ID:'),nl,
    read(Id),
    removeProdutoDoCarrinho(Id).
userOption(0):- main().
% ---------------------------------

% Admin ---------------------------
admin():-
    write('\e[2J'),
    print('1 - Cadastrar Produto.'),nl,
    print('2 - Excluir Produto.'),nl,
    print('3 - Listar Produtos.'),nl,
    print('0 - Voltar para a tela inicial.'),nl,
    read(Option),
    adminOption(Option),
    admin().

adminOption(1):-
    write('\e[2J'),
    print('Digite o nome do produto:'),nl,
    read(Nome),
    print('Digite o preço do produto:'),nl,
    read(Preco),
    print('Digite a categoria do produto:'),nl,
    read(Categoria),
    putProduto(Nome, Preco, Categoria).
adminOption(2):-
    write('\e[2J'),
    print('Digite o id do produto que deseja excluir:'),nl,
    read(Id),
    removeProduto(Id).
adminOption(3):- printProdutos().
adminOption(0):- main().
