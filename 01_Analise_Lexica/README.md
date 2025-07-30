# Lab 01 - Análise Léxica (Lexical Analysis)

Este laboratório implementa a primeira fase de um compilador: a **análise léxica** para a linguagem EZLang utilizando ANTLR4.

## 📋 Objetivo

Desenvolver um analisador léxico (lexer) que reconhece e classifica os tokens da linguagem EZLang, incluindo:
- Palavras-chave (keywords)
- Identificadores
- Literais (números, booleanos, strings)
- Operadores
- Delimitadores
- Comentários (que são descartados)

## 📁 Estrutura do Diretório

```
01_Analise_Lexica/
├── README.md                 # Este arquivo
├── Lab01.pdf                 # Especificação do laboratório
├── Lab01_Exemplos/           # Exemplos de gramáticas ANTLR
│   ├── Exemplo01.g
│   ├── Exemplo02.g
│   └── Exemplo03.g
├── Lab01_Solucao/            # Solução implementada
│   ├── EZLexer.g            # Gramática léxica da EZLang
│   ├── Makefile             # Automatização da compilação
│   └── gen_tests.sh         # Script para execução de testes
├── Lab01_Output/             # Saída gerada pelos testes
└── Lab01_Output_Expected/    # Saída esperada para comparação
```

## 🔧 Pré-requisitos

- **Java JDK 8+**
- **ANTLR 4.13.2** (incluído em `../../tools/antlr-4.13.2-complete.jar`)
- **Make** (para usar o Makefile)

## 🚀 Como Compilar e Executar

### 1. Compilação

```bash
cd Lab01_Solucao/
make all
```

Este comando:
- Executa o ANTLR para gerar o lexer Java a partir de `EZLexer.g`
- Compila os arquivos Java gerados

### 2. Execução Manual

Para testar um arquivo específico:

```bash
make run FILE=../../../Inputs_Labs/c01.ezl
```

### 3. Execução de Todos os Testes

Para executar todos os testes automaticamente:

```bash
./gen_tests.sh
```

Este script:
- Processa todos os arquivos `.ezl` em `../../Inputs_Labs/`
- Gera a saída em `../Lab01_Output/`
- Compara com a saída esperada em `../Lab01_Output_Expected/`

## 🧪 Arquivos de Teste

Os arquivos de teste estão localizados em `../../Inputs_Labs/`:

## 📊 Saída Esperada

Para cada arquivo de entrada `arquivo.ezl`, o lexer produz uma saída `arquivo.out` contendo:
- Lista de tokens identificados
- Tipo de cada token
- Posição no texto (linha e coluna)
- Mensagens de erro (se houver)

Exemplo de saída:
```
[@0,0:6='program',<'program'>,1:0]
[@1,8:9='id',<ID>,1:8]
[@2,10:10=';',<';'>,1:10]
[@3,12:16='begin',<'begin'>,1:12]
...
```

## 🛠️ Comandos do Makefile

- `make all` - Compila tudo (ANTLR + Java)
- `make antlr` - Apenas executa o ANTLR
- `make javac` - Apenas compila o Java
- `make run FILE=arquivo` - Executa o lexer em um arquivo
- `make clean` - Remove arquivos gerados

## 🐛 Solução de Problemas

### Erro: "cannot find symbol ANTLR"
Verifique se o caminho para `antlr-4.13.2-complete.jar` está correto no Makefile.

### Erro: "make: command not found"
Instale o Make: `sudo apt-get install build-essential`

### Erros de compilação Java
Verifique se tem Java JDK instalado: `java -version` e `javac -version`

---