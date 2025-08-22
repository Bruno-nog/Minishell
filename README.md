# minishell

**Resumo**

minishell é uma implementação simples de um interpretador de comandos (shell) feita como projeto educacional. O objetivo é entender a lógica de um shell: parsing, execução de processos, pipes, redirecionamentos, builtins e tratamento de sinais.

---

## Índice

* [Sobre](#sobre)
* [Funcionalidades suportadas](#funcionalidades-suportadas)
* [Compilação](#compilação)
* [Uso](#uso)
* [Builtins implementados](#builtins-implementados)
* [Pipes e redirecionamentos](#pipes-e-redirecionamentos)
* [Sinais](#sinais)
* [Exemplos de execução](#exemplos-de-execução)
* [Estrutura do projeto](#estrutura-do-projeto)
* [Testes / Casos de uso](#testes--casos-de-uso)
* [Autores](#autores)

---

## Sobre

Este repositório contém uma versão didática de um shell reduzido. É indicado para aprendizado de conceitos de sistemas operacionais e programação de baixo nível: forks, exec, pipes, redirecionamentos, manipulação de strings e sinais.

## Funcionalidades suportadas

* Execução de comandos externos (`/bin/ls`, `cat`, etc.)
* `PATH` lookup para localizar executáveis
* Builtins (ver seção específica)
* Pipes (`|`) encadeados
* Redirecionamentos de entrada/saída (`>`, `>>`, `<`)
* Heredoc (`<<`) — implementação básica
* Tratamento de sinais (SIGINT, SIGQUIT) no modo interativo
* Expansão de variáveis de ambiente (`$VAR`)
* Retorno de status dos comandos (exit status)

## Compilação

No diretório do projeto, rode:

```sh
make
```

## Uso

Execute o binário gerado:

```sh
./minishell
```

Exemplo de prompt:

```
minishell> ls -la | grep src > out.txt
minishell> cat < out.txt
```

Para sair do shell, use `exit` (builtin) ou `Ctrl+D` (EOF).

## Builtins implementados

* `cd [dir]` — muda diretório (atualiza `PWD`/`OLDPWD` quando aplicável)
* `echo [-n] [args...]` — imprime argumentos
* `pwd` — mostra diretório atual
* `export [NAME[=VALUE] ...]` — define variável de ambiente
* `unset NAME` — remove variável de ambiente
* `env` — mostra variáveis de ambiente
* `exit [n]` — encerra o shell com código `n`


## Pipes e redirecionamentos

* Suporta múltiplos pipes encadeados. Cada segmento entre pipes é executado em processo separado.
* Redirecionamentos tratam `>`, `>>` (append) e `<`.
* Heredoc `<<` implementado de forma básica; limitações podem existir quanto ao EOF e expansion.

**Exemplo combinado:**

```sh
minishell$ grep TODO < source.c | sort | uniq > todos.txt
```

## Sinais

* `SIGINT (Ctrl+C)`: deve interromper o processo em execução e retornar ao prompt sem fechar o minishell.
* `SIGQUIT (Ctrl+\)`: comportamento pode variar — normalmente ignorado no prompt.


## Exemplos de execução

```sh
# executar um comando externo
minishell> /bin/ls -l /tmp

# usar PATH para localizar executável
minishell> ls -la

# builtins
minishell> cd ..
minishell> pwd

# pipes e redirecionamentos
minishell> cat file.txt | grep hello > out.txt

# heredoc
minishell> cat << EOF
> linha 1
> linha 2
> EOF
linha 1
linha 2
```

## Estrutura do projeto

```
minishell/
├── includes/         # headers (.h)
├── srcs/             # fontes (.c)
│   ├── main.c
│   ├── parser/
│   ├── built-in/
│   └── utils.c
├── obj/
├── libft/
├── Makefile
└── README.md
```

## Testes / Casos de uso

* Teste simples: executar `ls`, `echo`, `pwd`.
* Teste de pipes: `ls -la | grep minishell | wc -l`.
* Teste de redirecionamento: `echo "hi" > file && cat < file`.
* Teste de heredoc com variáveis e sem variáveis.

## Autores

* Bruno Nogueira de Queiroz — brunogue
* Paulo Vitor Lopes Meira — pvitor-l

---

### Histórico

Utilizei um arquivo .txt como uma lista de afazeres, esse foi todo o histórico durante os 2 meses de minishell.

```

💬

27/5
brunogue - list.txt
brunogue - libft atualizada, criando a type_correct e inicializando os types.

pvitor-l token corrigido tinha alguns erros nas funcoes criadas para token foram corrigidos
tambem fix o ft_print_token agora temos o token de redirect pipe word e append. funcionais  
devemos procurar inicalizar a struct e procurar erros nesta parte tambem organizar as funcoes em seus respectivos arquivos corretos ja norminetadas
devemos pensar no parsem de forma forma possivel e comecarmos a entender o EOF vulgo heredoc

28/5
brunogue - suprimido os leaks da readline e addhistory;
leaks do token corrigidos pela função free_token_list;
feito o clear, mas ta errado

30/5
brunogue - arrumado a tokenization, agora esta lendo caracter por caracter. Só falta refatorar ela, mas está mto tarde kk

4/6
brunogue - feito o refatoramento da tokenization e arrumado o makefile para que ele ignore a saida do minishell.

8/6
brunogue - juntado as builtins com os parsings do token. Tirei a flag -Werror do makefile da lib para poder compilar no wsl. ******************** LEMBRETE PARA RECOLOCAR A  FLAG ************************************

17/6
brunogue - variavel de ambiente, $$ e saida das builtins

23/6
brunogue - objs organizados e variavel de ambiente concluida, somente faltando o tratamento certo do parsing, pois passando o comando tudo junto, ele n funcionais
ex: echo $$$HOME 

24/6
brunogue - fazer o cd ~ e echo $?

26/6
brunogue - expansao de variavel de ambiente corretas, agr fazer o exit status

3/7
brunogue - arrumei os still reachables restantes e o exit status que tinha parado de funcionar, so que agr o unico problema é o pipe que ta dando double free. 
fazer aspas no value do export

17/7
brunogue -lembrete: tirei o ft_calloc da appent token e coloquei malloc. se algo der leak, verificar ai 
```