#!/bin/bash
CURRENT_DIR=$(pwd)
ROOT=$(dirname "$CURRENT_DIR")  # Vai para 03_Analise_Semantica_Symbol_Tables
PROJECT_ROOT=$(dirname "$ROOT")  # Vai para Compilador_EZLang

ANTLR_PATH="$PROJECT_ROOT/tools/antlr-4.13.2-complete.jar"
CLASS_PATH_OPTION="-cp .:$ANTLR_PATH"

GRAMMAR_PREFIX=EZ
GEN_PATH=parser
BIN_PATH=bin

IN="$PROJECT_ROOT/Inputs_Labs"
OUT="$ROOT/Lab04_Output"
EXPECTED="$ROOT/Lab04_Output_Expected"

# Verificar se o diretório de saída existe
mkdir -p "$OUT"

if [[ ! -d "$GEN_PATH" ]]; then
    echo "Please run make first to generate the parser files."
    exit 1
fi

for infile in "$IN"/*.ezl; do
    if [[ -f "$infile" ]]; then
        base=$(basename "$infile")
        outfile="$OUT/${base/.ezl/.out}"
        echo "Running $base"
        java $CLASS_PATH_OPTION:$BIN_PATH Main "$infile" > "$outfile" 2>&1
        if [[ $? -ne 0 ]]; then
            echo "Error processing $base"
        fi
    fi
done

echo "Comparing outputs..."
diff -u "$OUT" "$EXPECTED"
