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
OUTPUT_DIR=$(shell dirname $(ROOT))/Lab04_Output

# Diretório para os arquivos .class
BIN_PATH=bin

# Executa o ANTLR e o compilador Java
all: antlr javac
	@echo "Compilação concluída."

# Executa o ANTLR para compilar as gramáticas
antlr: $(GRAMMARS)
	$(ANTLR4) -no-listener -visitor -o $(GEN_PATH) $(GRAMMARS)

# Executa o javac para compilar os arquivos gerados
javac: antlr
	rm -rf $(BIN_PATH)
	mkdir $(BIN_PATH)
	$(JAVAC) -cp $(CLASSPATH) -d $(BIN_PATH) $(GEN_PATH)/*.java checker/*.java Main.java

# Executa o parser. Comando: $ make run FILE=arquivo_de_teste
run:
ifeq ($(strip $(FILE)),)
	$(JAVA) -cp $(CLASSPATH):$(BIN_PATH) org.antlr.v4.gui.TestRig $(GRAMMAR_PREFIX) program
else
	$(JAVA) -cp $(CLASSPATH):$(BIN_PATH) org.antlr.v4.gui.TestRig $(GRAMMAR_PREFIX) program -gui $(FILE)
endif

# Executa o front-end (Main class). Comando: $ make run-main FILE=arquivo_de_teste
run-main:
ifeq ($(strip $(FILE)),)
	@echo "Erro: É necessário especificar um arquivo. Use: make run-main FILE=../../../Inputs_Labs/c01.ezl"
else
	$(JAVA) -cp $(CLASSPATH):$(BIN_PATH) Main $(FILE)
endif

# Remove os arquivos gerados pelo ANTLR
clean:
	@rm -rf $(GEN_PATH)
	@rm -f $(OUTPUT_DIR)/*
	@rm -rf $(BIN_PATH)