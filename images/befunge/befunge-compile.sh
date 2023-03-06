#!/bin/bash

for file in "./app/*"
do
    name=$(basename $file)
    name="${name%.*}"
    ./tbc $file > $name.c
done

gcc *.c -o compiled-app

rm *.c