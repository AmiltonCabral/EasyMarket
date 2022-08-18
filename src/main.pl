:- use_module(produto, [printProdutos/0, putProduto/3, removeProduto/1, getProduto/2]).
:- use_module(carrinho, [printCarrinho/0, putProdutoNoCarrinho/4, removeProdutoDoCarrinho/1, clearCarrinho/0]).
:- use_module(compra, [putCompra/0, printCompras/0]).
:- use_module(library(csv)).

main():-
    write('\e[2J'),

    writeln('        +-+-+-+-+ +-+-+-+-+-+-+'),
    writeln('        |E|a|s|y| |M|a|r|k|e|t|'),
    writeln('        +-+-+-+-+ +-+-+-+-+-+-+'),
    writeln(' ===================================== '),
    writeln('          1- CLIENTE                   '),
    writeln('          2- ADMINISTRADOR             '),
    writeln('          0- SAIR                      '),
    writeln(' ===================================== '),nl,

    write('Digite sua opcao: '),
    read(Option),
    mainOption(Option),
    main().

mainOption(1):- user().
mainOption(2):- admin().
mainOption(0):- halt(0).


% User ----------------------------
user():-
    write('\e[2J'),
    writeln('             +-+-+-+-+-+-+-+'),
    writeln('             |C|L|I|E|N|T|E|'),
    writeln('             +-+-+-+-+-+-+-+'),nl,
    writeln(' ===================================== '),
    writeln('      1- LISTAGEM DE PRODUTOS          '),
    writeln('      2- LISTAGEM DE CARRINHO          '),
    writeln('      3- ADD PRODUTO CARRINHO          '),
    writeln('      4- REMOVER PRODUTO DO CARRINHO   '),
    writeln('      5- REALIZAR COMPRA               '),
    writeln('      6- LISTAR COMPRA                 '),
    writeln('      0- SAIR                          '),
    writeln(' ===================================== '),nl,
    write('Digite sua opcao: '),
    read(Option),
    userOption(Option),
    user().

userOption(1):- printProdutos().
userOption(2):- printCarrinho().
userOption(3):-
    print('Digite o ID:'),nl,
    read(Id),
    print('Digite a quantidade:'),nl,
    read(Quantidade),
    getProduto(Id, row(_, Nome, Preco, Categoria)),
    putProdutoNoCarrinho(Nome, Preco, Categoria, Quantidade).
userOption(4):-
    print('Digite o ID:'),nl,
    read(Id),
    removeProdutoDoCarrinho(Id).
userOption(5):-
    putCompra(),
    clearCarrinho().
userOption(6):- printCompras().
userOption(0):- main().
% ---------------------------------

% Admin ---------------------------
admin():-
    write('\e[2J'),
    writeln('                 +-+-+-+               '),
    writeln('                 |A|D|M|               '),
    writeln('                 +-+-+-+               '),nl,
    writeln(' ===================================== '),
    writeln('      1- CADASTRAR PRODUTO             '),
    writeln('      2- EXCLUIR PRODUTO               '),
    writeln('      3- LISTAR PRODUTOS               '),
    writeln('      0- SAIR                          '),
    writeln(' ===================================== '),nl,
    write('Digite sua opcao: '),

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
