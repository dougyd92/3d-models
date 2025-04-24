#!/bin/bash

base_path='/Users/douglasdejesus/Downloads/mana-master/svg/'
main_symbols=('w' 'u' 'b' 'r' 'g')
type_symbols=('artifact' 'creature' 'enchantment' 'instant' 'planeswalker' 'sorcery')

i=0 

for main in "${main_symbols[@]}"; do
  for type in "${type_symbols[@]}"; do
    arg1="main_symbol_filepath=\"${base_path}${main}.svg\""
    arg2="type_symbol_filepath=\"${base_path}${type}.svg\""
    tab_side=$((i % 2))
    ((i++))
    arg3="tab_side=${tab_side}"
    
    openscad --export-format binstl -o "./output/${main}-${type}.stl" ./divider.scad -D $arg1 -D $arg2 -D $arg3
  done
done
