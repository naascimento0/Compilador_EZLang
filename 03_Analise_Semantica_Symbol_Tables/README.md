# Lab 03 - Análise Semântica: Tabelas de Símbolos (Semantic Analysis: Symbol Tables)

Este laboratório implementa a terceira fase de um compilador: a **análise semântica** com foco em **tabelas de símbolos** para a linguagem EZLang, utilizando o padrão Visitor do ANTLR4.

## 📋 Objetivo

Desenvolver um analisador semântico que:
- Constrói e gerencia tabelas de símbolos
- Verifica declaração e uso de variáveis
- Detecta redefinições e variáveis não declaradas
- Implementa escopo aninhado (nested scope)
- Valida regras semânticas da linguagem

## 📁 Estrutura do Diretório

```
03_Analise_Semantica_Symbol_Tables/
├── README.md                 # Este arquivo
├── Lab03.pdf                 # Especificação do laboratório
├── Lab03_Exemplos/           # Exemplos de implementação
│   ├── ex01/
│   ├── ex02a/
│   ├── ex02b/
│   └── ex02c/
├── Lab03_Solucao/            # Solução implementada
│   ├── EZLexer.g            # Gramática léxica
│   ├── EZParser.g           # Gramática sintática
│   ├── Main.java            # Classe principal
│   ├── Makefile             # Automatização da compilação
│   ├── gen_tests.sh         # Script para execução de testes
│   ├── checker/             # Verificador semântico
│   │   └── SemanticChecker.java
│   ├── tables/              # Implementação de tabelas de símbolos
│   └── typing/              # Sistema de tipos (para lab futuro)
├── Lab03_src/               # Códigos fonte de apoio
├── Lab03_Output/            # Saída gerada pelos testes
└── Lab03_Output_Expected/   # Saída esperada para comparação
```

## 🔧 Pré-requisitos

- **Java JDK 8+**
- **ANTLR 4.13.2** (incluído em `../../tools/antlr-4.13.2-complete.jar`)
- **Make** (para usar o Makefile)
- Conhecimento dos Labs 01 e 02 (Análise Léxica e Sintática)

## 🚀 Como Compilar e Executar

### 1. Compilação

```bash
cd Lab03_Solucao/
make all
```

Este comando:
- Executa o ANTLR com flag `-visitor` para gerar classes visitor
- Compila lexer, parser, checker e classes auxiliares
- Cria diretório `bin/` para organizar arquivos `.class`

### 2. Execução Manual

Para executar a análise semântica em um arquivo:

```bash
make run-main FILE=../../../Inputs_Labs/c01.ezl
```

Para debug com GUI do parser:

```bash
make run FILE=../../../Inputs_Labs/c01.ezl
```

### 3. Execução de Todos os Testes

Para executar todos os testes automaticamente:

```bash
./gen_tests.sh
```

## 📝 Funcionalidades Implementadas

### Tabela de Símbolos
- **Inserção**: Adiciona variáveis com tipo e escopo
- **Busca**: Localiza variáveis respeitando escopo aninhado
- **Escopo aninhado**: Suporte a blocos `if`, `while`, etc.
- **Verificação de redefinição**: Detecta variáveis já declaradas no mesmo escopo

### Verificações Semânticas

#### 1. Declaração de Variáveis
```ezlang
program exemplo;
var
  int x;        # ✓ Declaração válida
  bool x;       # ✗ Erro: redefinição de 'x'
```

#### 2. Uso de Variáveis
```ezlang
begin
  x := 10;      # ✗ Erro: 'x' não foi declarada
  y := x + 1;   # ✗ Erro: 'y' e 'x' não declaradas
end
```

#### 3. Escopo Aninhado
```ezlang
var int x;
begin
  if x > 0 then
    var int y;    # 'y' visível apenas neste bloco
    y := x;       # ✓ Válido
  end;
  y := 5;         # ✗ Erro: 'y' não visível aqui
end
```

## 📊 Saída Esperada

### Programa Correto
```
Análise semântica concluída com sucesso.
Tabela de Símbolos Final:
  x: int (linha 3)
  y: bool (linha 4)
```

### Programa com Erros
```
Erro semântico na linha 5: Variável 'z' não foi declarada
Erro semântico na linha 7: Redefinição da variável 'x' na linha 7
Análise semântica finalizada com 2 erro(s).
```

## 🛠️ Comandos do Makefile

- `make all` - Compila tudo (ANTLR + Java)
- `make antlr` - Executa ANTLR com flag `-visitor`
- `make javac` - Compila Java (cria `bin/` automaticamente)
- `make run-main FILE=arquivo` - Executa análise semântica
- `make run FILE=arquivo` - Debug com GUI do parser
- `make clean` - Remove arquivos gerados

## 🔍 Arquitetura do Sistema

### Padrão Visitor
```java
public class SemanticChecker extends EZParserBaseVisitor<Void> {
    @Override
    public Void visitProgram(ProgramContext ctx) {
        // Processa programa principal
    }
    
    @Override
    public Void visitVardecl(VardeclContext ctx) {
        // Processa declaração de variável
    }
}
```

### Classes Principais

#### Main.java
- Coordena lexer, parser e checker
- Gerencia entrada e saída
- Trata exceções e erros

#### SemanticChecker.java
- Implementa visitor pattern
- Gerencia tabelas de símbolos
- Realiza verificações semânticas

#### tables/ (package)
- Implementação de estruturas de dados para símbolos
- Gerenciamento de escopo aninhado

## 🧠 Conceitos Importantes

### Escopo (Scope)
- **Escopo Global**: Variáveis declaradas na seção `var`
- **Escopo Local**: Variáveis em blocos `if`, `while`
- **Regra de Visibilidade**: Variável é visível de sua declaração até o fim do escopo

### Tabela de Símbolos
- **Hash Table**: Para busca eficiente O(1)
- **Stack de Escopos**: Para gerenciar escopo aninhado
- **Informações armazenadas**: Nome, tipo, linha de declaração, escopo

### Visitor Pattern
- **Traversal automático**: ANTLR percorre a árvore
- **Métodos específicos**: Um método `visit` para cada regra gramatical
- **Controle de fluxo**: Decide quando visitar filhos da árvore

## 🐛 Solução de Problemas

### Erro: "cannot find symbol EZParserBaseVisitor"
O ANTLR não foi executado com flag `-visitor`. Execute `make clean` e `make all`.

### Erro: "SemanticChecker.java: method does not override"
Verifique se a gramática foi alterada e recompile com `make antlr`.

### Erro: ClassPath issues
Verifique se `bin/` foi criado e se CLASSPATH inclui ANTLR jar.

### Saída vazia ou incorreta
Verifique se `Main.java` está chamando `checker.visit(tree)` corretamente.

## 📚 Próximos Passos

Este lab prepara para:
- **Lab 04**: Verificação de tipos (type checking)
- **Lab 05**: Geração de código intermediário
- **Conceitos avançados**: Inferência de tipos, polimorfismo

---

**Autor**: Gabriel  
**Disciplina**: Compiladores  
**Laboratório**: 03 - Análise Semântica: Tabelas de Símbolos
