#!/bin/bash

while getopts "vh" opt; do
  case $opt in
    v)
      echo "Running script in a verbose mode"

      echo "Compiling TeX files using compile_all_docker.py"
      python3 compile_all_docker.py
      
      echo "Mergin all files using merge_all.py"
      python3 merge_all.py
      
      echo "Compressing all files using compress.sh"
      ./compress.sh
      
      while true; do
      read -p "Do you wish to remove uncompressed pdf file? " yn
      case $yn in
          [Yy]* ) rm out.pdf; break;;
          [Nn]* ) exit;;
          * ) echo "Please answer yes or no.";;
      esac
      done
      exit 0
      ;;

    h)
      echo "usage: make.sh -(v/h)"
      echo "    -v -> verbose tag"
      echo "    -h -> help dialog"
      exit 0
      ;;
  esac
done

echo "Running script in a non-verbose mode"

echo "Compiling TeX files using compile_all_docker.py"
python3 compile_all_docker.py >/dev/null

echo "Mergin all files using merge_all.py"
python3 merge_all.py >/dev/null

echo "Compressing all files using compress.sh"
./compress.sh >/dev/null

while true; do
    read -p "Do you wish to remove uncompressed pdf file? " yn
    case $yn in
        [Yy]* ) rm out.pdf; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
exit 0


