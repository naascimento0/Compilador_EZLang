# Lab 02 - Análise Sintática (Syntax Analysis)

Este laboratório implementa a segunda fase de um compilador: a **análise sintática** para a linguagem EZLang utilizando ANTLR4, construindo uma árvore de sintaxe abstrata (AST).

## 📋 Objetivo

Desenvolver um analisador sintático (parser) que:
- Reconhece a estrutura gramatical da linguagem EZLang
- Constrói uma árvore de sintaxe (parse tree)
- Detecta erros sintáticos
- Trabalha em conjunto com o lexer do Lab01

## 📁 Estrutura do Diretório

```
02_Analise_Sintatica/
├── README.md                 # Este arquivo
├── Lab02.pdf                 # Especificação do laboratório
├── Lab02_Exemplos/           # Exemplos de gramáticas ANTLR
│   ├── Exemplo01.g
│   ├── Exemplo02.g
│   └── Exemplo03.g
├── Lab02_Solucao/            # Solução implementada
│   ├── EZLexer.g            # Gramática léxica (do Lab01)
│   ├── EZParser.g           # Gramática sintática da EZLang
│   ├── Makefile             # Automatização da compilação
│   └── gen_tests.sh         # Script para execução de testes
├── Lab02_Output/             # Saída gerada pelos testes
└── Lab02_Output_Expected/    # Saída esperada para comparação
```

## 🔧 Pré-requisitos

- **Java JDK 8+**
- **ANTLR 4.13.2** (incluído em `../../tools/antlr-4.13.2-complete.jar`)
- **Make** (para usar o Makefile)
- Conhecimento do Lab01 (Análise Léxica)

## 🚀 Como Compilar e Executar

### 1. Compilação

```bash
cd Lab02_Solucao/
make all
```

Este comando:
- Executa o ANTLR para gerar lexer e parser Java
- Compila os arquivos Java gerados

### 2. Execução Manual

Para testar um arquivo específico:

```bash
make run FILE=../../../Inputs_Labs/c01.ezl
```

Para visualizar a árvore sintática:

```bash
make run-tree FILE=../../../Inputs_Labs/c01.ezl
```

Para ver apenas os tokens:

```bash
make run-text FILE=../../../Inputs_Labs/c01.ezl
```

### 3. Execução de Todos os Testes

Para executar todos os testes automaticamente:

```bash
./gen_tests.sh
```

## 🧪 Arquivos de Teste

Os arquivos de teste estão localizados em `../../Inputs_Labs/`:

## 📊 Saída Esperada

Para cada arquivo de entrada `arquivo.ezl`, o parser produz:

### Árvore Sintática (com -tree)
```
(program PROGRAM (ID exemplo) ; 
  (varssect VAR 
    (vardecl (typespec INT) (ID x) ;)) 
  (stmtsect BEGIN 
    (stmt (assignstmt (ID x) := (expr (term (factor (NUMBER 10)))) ;)) 
  END))
```

### Tokens (com -tokens)
Lista de tokens como no Lab01.

### Erros Sintáticos
```
line 3:0 mismatched input 'begin' expecting {'var', 'begin'}
```

## 🛠️ Comandos do Makefile

- `make all` - Compila tudo (ANTLR + Java)
- `make antlr` - Apenas executa o ANTLR
- `make javac` - Apenas compila o Java
- `make run FILE=arquivo` - Executa o parser com GUI
- `make run-text FILE=arquivo` - Mostra apenas tokens
- `make run-tree FILE=arquivo` - Mostra árvore sintática em texto
- `make clean` - Remove arquivos gerados

## 🔍 Características da Gramática

### Parser Grammar
- Utiliza `parser grammar EZParser`
- Referencia tokens definidos em `EZLexer`
- Implementa precedência de operadores
- Suporta recursão à esquerda (ANTLR4 resolve automaticamente)

## 🐛 Solução de Problemas

### Erro: "cannot find symbol EZLexer"
Certifique-se de que `EZLexer.g` está presente e foi compilado primeiro.

### Erro: "no viable alternative at input"
Erro sintático - verifique se o arquivo de entrada segue a gramática da EZLang.

### Erro: "mismatched input"
Token inesperado na posição - verifique a sintaxe do arquivo de entrada.

### GUI não abre
Verifique se tem ambiente gráfico disponível. Use `make run-tree` para versão texto.

## 📚 Conceitos Importantes

### Parse Tree vs AST
- **Parse Tree**: Representa exatamente a derivação gramatical
- **AST**: Versão condensada focando na estrutura semântica

### Precedência de Operadores
```
1. ( )           # Parênteses (maior precedência)
2. * /           # Multiplicação e divisão
3. + -           # Soma e subtração
4. < <= > >= = <> # Operadores relacionais
5. not           # Negação lógica
6. and           # E lógico
7. or            # OU lógico (menor precedência)
```

### Associatividade
- Operadores aritméticos: associatividade à esquerda
- Operadores lógicos: associatividade à esquerda

---
