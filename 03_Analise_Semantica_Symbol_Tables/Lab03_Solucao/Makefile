# # Comando do compilador Java
# JAVAC=javac
# # Comando da JVM
# JAVA=java
# # ROOT é a raiz dos diretórios com todos os roteiros de laboratórios
# YEAR=$(shell pwd | grep -o '20..-.')
# ROOT=/home/zambon/Teaching/$(YEAR)/CC/labs
# # Caminho para o JAR do ANTLR em labs/tools
# ANTLR_PATH=$(ROOT)/tools/antlr-4.11.1-complete.jar
# # Opção de configuração do CLASSPATH para o ambiente Java
# CLASS_PATH_OPTION=-cp .:$(ANTLR_PATH)
# # Configuração do comando de compilação do ANTLR
# ANTLR4=$(JAVA) -jar $(ANTLR_PATH)
# # Configuração do ambiente de teste do ANTLR
# GRUN=$(JAVA) $(CLASS_PATH_OPTION) org.antlr.v4.gui.TestRig
# # Nome da gramática
# GRAMMAR_NAME=EZ
# LEXER_FILE=$(GRAMMAR_NAME)Lexer.g
# PARSER_FILE=$(GRAMMAR_NAME)Parser.g
# # Diretório para aonde vão os arquivos gerados
# GEN_PATH=parser
# # Diretório para os arquivos .class
# BIN_PATH=bin

# # Executa o ANTLR e o compilador Java
# all: antlr javac
# 	@echo "Done."
# # Executa o ANTLR para compilar a gramática
# antlr: $(LEXER_FILE) $(PARSER_FILE)
# 	$(ANTLR4) -no-listener -visitor -o $(GEN_PATH) $(LEXER_FILE) $(PARSER_FILE)
# # Compila todos os subdiretórios e joga todos os .class em BIN_PATH pra organizar
# javac:
# 	rm -rf $(BIN_PATH)
# 	mkdir $(BIN_PATH)
# 	$(JAVAC) $(CLASS_PATH_OPTION) -d $(BIN_PATH) */*.java Main.java
# # Executa o front-end. Comando: $ make run FILE=arquivo_de_teste
# # 'Main' é a classe com a função principal
# run:
# 	$(JAVA) $(CLASS_PATH_OPTION):$(BIN_PATH) Main $(FILE)
# # Executa o TestRig para exibir a parse tree
# debug:
# # 	cd $(BIN_PATH) && $(GRUN) $(GRAMMAR_NAME) program -gui $(FILE)
# 	cd $(BIN_PATH) && $(GRUN) parser.$(GRAMMAR_NAME) program -gui $(FILE)
# # Remove os arquivos gerados pelo ANTLR
# clean:
# 	@rm -rf $(GEN_PATH) $(BIN_PATH)

# Comando do compilador Java
JAVAC=javac
# Comando da JVM
JAVA=java
# ROOT é a raiz dos diretórios com todos os roteiros de laboratórios
ROOT=$(shell pwd)
# Caminho para o JAR do ANTLR em labs/tools
ANTLR_PATH=$(ROOT)/tools/antlr-4.13.2-complete.jar
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

# Diretório para os arquivos .class
BIN_PATH=bin

# Executa o ANTLR e o compilador Java
all: antlr javac
	@echo "Compilação concluída."

# Executa o ANTLR para compilar as gramáticas
antlr: $(GRAMMARS)
	$(ANTLR4) -no-listener -o $(GEN_PATH) $(GRAMMARS)

# Executa o javac para compilar os arquivos gerados
javac:
	$(JAVAC) -cp $(CLASSPATH) -d $(BIN_PATH) $(GEN_PATH)/*.java Main.java

# Executa o parser. Comando: $ make run FILE=arquivo_de_teste
run:
ifeq ($(strip $(FILE)),)
	cd $(GEN_PATH) && $(JAVA) -cp $(CLASSPATH):$(BIN_PATH) org.antlr.v4.gui.TestRig $(GRAMMAR_PREFIX) program
else
	cd $(GEN_PATH) && $(JAVA) -cp $(CLASSPATH):$(BIN_PATH) org.antlr.v4.gui.TestRig $(GRAMMAR_PREFIX) program -gui ../$(FILE)
endif

# Executa o parser sem GUI (versão texto). Comando: $ make run-text FILE=arquivo_de_teste
run-text:
ifeq ($(strip $(FILE)),)
	@echo "Erro: É necessário especificar um arquivo. Use: make run-text FILE=../Lab02_Input/c01.ezl"
else
	cd $(GEN_PATH) && $(JAVA) -cp $(CLASSPATH):$(BIN_PATH) org.antlr.v4.gui.TestRig $(GRAMMAR_PREFIX) program -tokens ../$(FILE)
endif

# Executa o parser mostrando a árvore (versão texto). Comando: $ make run-tree FILE=arquivo_de_teste
run-tree:
ifeq ($(strip $(FILE)),)
	@echo "Erro: É necessário especificar um arquivo. Use: make run-tree FILE=../Lab02_Input/c01.ezl"
else
	cd $(GEN_PATH) && $(JAVA) -cp $(CLASSPATH):$(BIN_PATH) org.antlr.v4.gui.TestRig $(GRAMMAR_PREFIX) program -tree ../$(FILE)
endif

# Remove os arquivos gerados pelo ANTLR
clean:
	@rm -rf $(GEN_PATH)
	@rm -f $(OUTPUT_DIR)/*
	@rm -rf $(BIN_PATH)