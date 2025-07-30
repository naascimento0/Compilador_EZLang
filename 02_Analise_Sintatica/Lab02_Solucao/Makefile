# Comando do compilador Java
JAVAC=javac
# Comando da JVM
JAVA=java
# ROOT é a raiz do Laboratório
ROOT=$(shell pwd)
# PROJECT_ROOT é o diretório raiz do projeto
PROJECT_ROOT=$(shell dirname $(shell dirname $(ROOT)))
# Caminho para o JAR do ANTLR em labs/tools
ANTLR_PATH=$(PROJECT_ROOT)/tools/antlr-4.13.2-complete.jar
# Opção de configuração do CLASSPATH para o ambiente Java
CLASSPATH=.:$(ANTLR_PATH)
# Configuração do comando de compilação do ANTLR
ANTLR4=$(JAVA) -jar $(ANTLR_PATH)
# Nome da gramática (prefixo comum)
GRAMMAR_PREFIX=EZ
# Arquivos das gramáticas
GRAMMARS=EZLexer.g EZParser.g
# Diretório para aonde vão os arquivos gerados
GEN_PATH=parser
OUTPUT_DIR=$(shell dirname $(ROOT))/Lab02_Output

# Executa o ANTLR e o compilador Java
all: antlr javac
	@echo "Compilação concluída."

# Executa o ANTLR para compilar as gramáticas
antlr: $(GRAMMARS)
	$(ANTLR4) -no-listener -o $(GEN_PATH) $(GRAMMARS)

# Executa o javac para compilar os arquivos gerados
javac:
	$(JAVAC) -cp $(CLASSPATH) $(GEN_PATH)/*.java

# Executa o parser. Comando: $ make run FILE=arquivo_de_teste
run:
ifeq ($(strip $(FILE)),)
	cd $(GEN_PATH) && $(JAVA) -cp $(CLASSPATH) org.antlr.v4.gui.TestRig $(GRAMMAR_PREFIX) program
else
	cd $(GEN_PATH) && $(JAVA) -cp $(CLASSPATH) org.antlr.v4.gui.TestRig $(GRAMMAR_PREFIX) program -gui ../$(FILE)
endif

# Executa o parser sem GUI (versão texto). Comando: $ make run-text FILE=arquivo_de_teste
run-text:
ifeq ($(strip $(FILE)),)
	@echo "Erro: É necessário especificar um arquivo. Use: make run-text FILE=../Lab02_Input/c01.ezl"
else
	cd $(GEN_PATH) && $(JAVA) -cp $(CLASSPATH) org.antlr.v4.gui.TestRig $(GRAMMAR_PREFIX) program -tokens ../$(FILE)
endif

# Executa o parser mostrando a árvore (versão texto). Comando: $ make run-tree FILE=arquivo_de_teste
run-tree:
ifeq ($(strip $(FILE)),)
	@echo "Erro: É necessário especificar um arquivo. Use: make run-tree FILE=../Lab02_Input/c01.ezl"
else
	cd $(GEN_PATH) && $(JAVA) -cp $(CLASSPATH) org.antlr.v4.gui.TestRig $(GRAMMAR_PREFIX) program -tree ../$(FILE)
endif

# Remove os arquivos gerados pelo ANTLR
clean:
	@rm -rf $(GEN_PATH)
	@rm -f $(OUTPUT_DIR)/*