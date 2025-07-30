#!/bin/bash
CURRENT_DIR=$(pwd)
ROOT=$(dirname "$CURRENT_DIR")  # Vai para 01_Analise_Lexica
PROJECT_ROOT=$(dirname "$ROOT")  # Vai para Compilador_EZLang

ANTLR_PATH="$PROJECT_ROOT/tools/antlr-4.13.2-complete.jar"
CLASS_PATH_OPTION="-cp .:$ANTLR_PATH"

GRAMMAR_NAME=EZLexer
GEN_PATH=lexer

IN="$PROJECT_ROOT/Inputs_Labs"
OUT="$ROOT/Lab01_Output"
EXPECTED="$ROOT/Lab01_Output_Expected"

# Verificar se o diretório de saída existe
mkdir -p "$OUT"

if [[ ! -d "$GEN_PATH" ]]; then
    echo "Please run make first to generate the lexer files."
    exit 1
fi

cd "$GEN_PATH"
for infile in "$IN"/*.ezl; do
    if [[ -f "$infile" ]]; then
        base=$(basename "$infile")
        outfile="$OUT/${base/.ezl/.out}"
        echo "Running $base"
        java $CLASS_PATH_OPTION org.antlr.v4.gui.TestRig $GRAMMAR_NAME tokens -tokens "$infile" > "$outfile" 2>&1
        if [[ $? -ne 0 ]]; then
            echo "Error processing $base"
        fi
    fi
done

echo "Comparing outputs..."
diff -u "$OUT" "$EXPECTED"
