#!/bin/bash

runtime="python3.8"  
memory_size=128
input_file=""
zip_file="PY/function.zip"  

# Flag-ek és argumentumok feldolgozása
while getopts "r:m:i:z:" opt; do
  case ${opt} in
    r )
      runtime=$OPTARG
      ;;
    m )
      memory_size=$OPTARG
      ;;
    i )
      input_file=$OPTARG
      ;;
    z )
      zip_file=$OPTARG
      ;;
    \? )
      echo "Usage: cmd [-r runtime] [-m memory_size] [-i input _file] [-z zip_file]"
      exit 1
      ;;
  esac
done

# JSON fájlból adatok beolvasása és a szám kinyerése
if [[ -f "$input_file" ]]; then
    number_value=$(jq -r '.number' "$input_file")
else
    echo "Hiba: A megadott JSON fájl nem létezik."
    exit 1
fi



# Terraform futtatása a megadott flag-ekkel
terraform apply -var "runtime=$runtime" -var "memory_size=$memory_size" -var "number_value=$number_value" -var "zip_file=$zip_file" -auto-approve
