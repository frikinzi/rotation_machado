#!/bin/bash

for i in {6..39}; do
    next=$((i+1))
    echo python3 extract_chr.py "$i" "chr_${next}.fa"
    python3 extract_chr.py "$i" "chr_${next}.fa"
done
