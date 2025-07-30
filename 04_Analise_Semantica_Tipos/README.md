# Lab 04 - Análise Semântica: Verificação de Tipos (Semantic Analysis: Type Checking)

Este laboratório implementa a quarta fase de um compilador: a **análise semântica** com foco em **verificação de tipos** para a linguagem EZLang, estendendo o trabalho do Lab03 com sistema de tipos robusto.

## 📋 Objetivo

Desenvolver um analisador semântico que:
- Verifica compatibilidade de tipos em expressões
- Implementa sistema de tipos para EZLang (int, real, bool, string)
- Detecta erros de tipo em operações e atribuições
- Realiza conversões implícitas quando apropriado
- Valida tipos em estruturas de controle (if, while)

## 📁 Estrutura do Diretório

```
04_Analise_Semantica_Tipos/
├── README.md                 # Este arquivo
├── Lab04.pdf                 # Especificação do laboratório
├── Lab04_Solucao/            # Solução implementada
│   ├── EZLexer.g            # Gramática léxica
│   ├── EZParser.g           # Gramática sintática
│   ├── Main.java            # Classe principal
│   ├── Makefile             # Automatização da compilação
│   ├── gen_tests.sh         # Script para execução de testes
│   ├── checker/             # Verificador semântico
│   │   └── SemanticChecker.java
│   ├── tables/              # Implementação de tabelas de símbolos
│   └── typing/              # Sistema de tipos
│       └── Type.java        # Enumeração e operações de tipos
├── Lab04_Output/            # Saída gerada pelos testes
└── Lab04_Output_Expected/   # Saída esperada para comparação
```

## 🔧 Pré-requisitos

- **Java JDK 8+**
- **ANTLR 4.13.2** (incluído em `../../tools/antlr-4.13.2-complete.jar`)
- **Make** (para usar o Makefile)
- Conhecimento dos Labs 01, 02 e 03 (Análise Léxica, Sintática e Tabelas de Símbolos)

## 🚀 Como Compilar e Executar

### 1. Compilação

```bash
cd Lab04_Solucao/
make all
```

Este comando:
- Executa o ANTLR com flag `-visitor` para gerar classes visitor
- Compila lexer, parser, checker, tipos e classes auxiliares
- Cria diretório `bin/` para organizar arquivos `.class`

### 2. Execução Manual

Para executar a verificação de tipos em um arquivo:

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

## 📝 Sistema de Tipos Implementado

### Tipos Primitivos
```java
public enum Type {
    INT_TYPE,    // Números inteiros: 42, -10, 0
    REAL_TYPE,   // Números reais: 3.14, -2.5, 0.0
    BOOL_TYPE,   // Booleanos: true, false
    STR_TYPE,    // Strings: "hello", "world"
    NO_TYPE      // Tipo inválido/erro
}
```

### Verificações de Tipos

#### 1. Operações Aritméticas
```ezlang
var int x; real y; bool z;
begin
  x := 10 + 5;        # ✓ int + int = int
  y := 3.14 + x;      # ✓ real + int = real (conversão implícita)
  z := x + true;      # ✗ Erro: int + bool inválido
end
```

#### 2. Operações Relacionais
```ezlang
var bool result;
begin
  result := 10 > 5;         # ✓ int > int = bool
  result := 3.14 > 2;       # ✓ real > int = bool
  result := "a" > "b";      # ✓ string > string = bool
  result := 10 > true;      # ✗ Erro: int > bool inválido
end
```

#### 3. Operações Lógicas
```ezlang
var bool x, y, result;
begin
  result := x and y;        # ✓ bool and bool = bool
  result := not x;          # ✓ not bool = bool
  result := x and 10;       # ✗ Erro: bool and int inválido
end
```

#### 4. Atribuições
```ezlang
var int x; real y;
begin
  x := 42;          # ✓ int := int
  y := x;           # ✓ real := int (conversão implícita)
  x := y;           # ✗ Erro: int := real (perda de precisão)
end
```

#### 5. Estruturas de Controle
```ezlang
var int x;
begin
  if x > 0 then     # ✓ Condição deve ser bool
    x := x + 1;
  end;
  
  if x then         # ✗ Erro: condição deve ser bool, não int
    x := 0;
  end;
end
```

## 📊 Saída Esperada

### Programa Correto
```
Análise semântica (tipos) concluída com sucesso.
Tabela de Símbolos Final:
  x: int (linha 3)
  y: real (linha 4)
  result: bool (linha 5)
```

### Programa com Erros de Tipo
```
Erro de tipo na linha 5: Operação '+' não suportada entre 'int' e 'bool'
Erro de tipo na linha 7: Atribuição incompatível: 'int' := 'real'
Erro de tipo na linha 9: Condição do 'if' deve ser 'bool', encontrado 'int'
Análise semântica finalizada com 3 erro(s) de tipo.
```

## 🛠️ Comandos do Makefile

- `make all` - Compila tudo (ANTLR + Java)
- `make antlr` - Executa ANTLR com flag `-visitor`
- `make javac` - Compila Java (cria `bin/` automaticamente)
- `make run-main FILE=arquivo` - Executa verificação de tipos
- `make run FILE=arquivo` - Debug com GUI do parser
- `make clean` - Remove arquivos gerados

## 🔍 Arquitetura do Sistema

### Classe Type.java
```java
public enum Type {
    INT_TYPE, REAL_TYPE, BOOL_TYPE, STR_TYPE, NO_TYPE;
    
    // Tabelas de unificação para operadores
    private static Type plus[][] = { ... };
    private static Type times[][] = { ... };
    private static Type comp[][] = { ... };
    
    public static Type unifyPlus(Type left, Type right) {
        return plus[left.ordinal()][right.ordinal()];
    }
}
```

### SemanticChecker.java Estendido
```java
public class SemanticChecker extends EZParserBaseVisitor<Type> {
    @Override
    public Type visitExpr(ExprContext ctx) {
        Type leftType = visit(ctx.left);
        Type rightType = visit(ctx.right);
        return Type.unifyPlus(leftType, rightType);
    }
    
    @Override
    public Type visitAssignstmt(AssignstmtContext ctx) {
        Type varType = getVariableType(ctx.ID());
        Type exprType = visit(ctx.expr());
        if (!Type.isAssignable(varType, exprType)) {
            reportTypeError(ctx, varType, exprType);
        }
        return Type.NO_TYPE;
    }
}
```

### Classes Principais

#### Main.java
- Coordena todo o pipeline de compilação
- Gerencia análise léxica, sintática e semântica
- Reporta erros de tipo de forma organizada

#### Type.java
- Define sistema de tipos da linguagem
- Implementa tabelas de unificação de tipos
- Fornece operações para verificação de compatibilidade

#### SemanticChecker.java
- Herda funcionalidades do Lab03 (tabelas de símbolos)
- Adiciona verificação de tipos para todas as construções
- Implementa visitor que retorna tipos (Visitor<Type>)

## 🧠 Conceitos Importantes

### Sistema de Tipos
- **Tipos Primitivos**: int, real, bool, string
- **Verificação Estática**: Erros detectados em tempo de compilação
- **Conversões Implícitas**: int → real permitida automaticamente
- **Type Safety**: Prevenção de operações inválidas

### Tabelas de Unificação
```java
// Operador '+': int + real = real
private static Type plus[][] = {
    { INT_TYPE,  REAL_TYPE, NO_TYPE,   STR_TYPE  },  // int    + ...
    { REAL_TYPE, REAL_TYPE, NO_TYPE,   STR_TYPE  },  // real   + ...
    { NO_TYPE,   NO_TYPE,   NO_TYPE,   NO_TYPE   },  // bool   + ...
    { STR_TYPE,  STR_TYPE,  NO_TYPE,   STR_TYPE  }   // string + ...
};
```

### Visitor Pattern com Tipos
- **Visitor<Type>**: Cada visit() retorna o tipo da expressão
- **Type Propagation**: Tipos propagam pela árvore sintática
- **Error Handling**: NO_TYPE indica erro de tipo

### Regras de Conversão
1. **int → real**: Sempre permitida (widening)
2. **real → int**: Não permitida (narrowing)
3. **Operações mistas**: Resultado promovido ao tipo mais geral
4. **String concatenation**: Strings podem ser "somadas"

## 🐛 Solução de Problemas

### Erro: "cannot resolve symbol Type"
Verifique se o package `typing` foi compilado corretamente.

### Erro: "method does not override" em visitExpr
Certifique-se de que SemanticChecker extends `EZParserBaseVisitor<Type>`, não `<Void>`.

### Tipos sempre retornam NO_TYPE
Verifique se as tabelas de unificação estão corretas e se os índices dos enums estão certos.

### Conversões não funcionam
Verifique se `isAssignable()` e `canConvert()` estão implementados corretamente.

## 📚 Próximos Passos

Este lab prepara para:
- **Lab 05**: Geração de código intermediário
- **Conceitos avançados**: Inferência de tipos, polimorfismo, generics
- **Otimizações**: Constant folding, dead code elimination

## 🔗 Relação com Labs Anteriores

- **Lab01**: Usa o lexer para reconhecer literais tipados
- **Lab02**: Usa o parser para construir árvore de expressões
- **Lab03**: Estende tabelas de símbolos com informações de tipo
- **Lab04**: Adiciona verificação completa do sistema de tipos

---
