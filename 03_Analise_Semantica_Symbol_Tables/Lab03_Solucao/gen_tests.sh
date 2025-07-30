# #!/bin/bash

# YEAR=$(pwd | grep -o '20..-.')
# ROOT=/home/zambon/Teaching/$YEAR/CC/labs
# ANTLR_PATH=$ROOT/tools/antlr-4.11.1-complete.jar
# CLASS_PATH_OPTION="-cp .:$ANTLR_PATH"

# GRAMMAR_NAME=EZ
# BIN_PATH=bin

# DATA=/home/zambon/Teaching/$YEAR/CC/labs/io
# IN=$DATA/in
# OUT=$DATA/out03_java

# for infile in `ls $IN/*.ezl`; do
#     base=$(basename $infile)
#     outfile=$OUT/${base/.ezl/.out}
#     echo Running $base
#     java $CLASS_PATH_OPTION:$BIN_PATH Main $infile &> $outfile
# done

#!/bin/bash
CURRENT_DIR=$(pwd)
ROOT=$(dirname "$CURRENT_DIR")  # Vai para 03_Analise_Semantica_Symbol_Tables
PROJECT_ROOT=$(dirname "$ROOT")  # Vai para Compilador_EZLang

ANTLR_PATH="$CURRENT_DIR/tools/antlr-4.13.2-complete.jar"
CLASS_PATH_OPTION="-cp .:$ANTLR_PATH"

GRAMMAR_PREFIX=EZ
GEN_PATH=parser
BIN_PATH=bin

IN="$ROOT/Lab03_Input"
OUT="$ROOT/Lab03_Output"
EXPECTED="$ROOT/Lab03_Output_Expected"

# Verificar se o diretório de saída existe
mkdir -p "$OUT"

cd "$GEN_PATH"
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
