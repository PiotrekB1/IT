#!/bin/bash

while true; do
    clear
    echo "Menu:"
    echo "1. Wyjście ze skryptu"
    echo "2. Pokaż ilość pamięci"
    echo "3. Zajętość dysku"
    echo "4. Otwarte porty"

    read -p "Wybierz opcję (1/2/3/4): " option

    case $option in
        1)
            echo "Wyjście ze skryptu."
            exit
            ;;
        2)
            echo "Ilość pamięci:"
            free -m
            read -p "Naciśnij Enter, aby kontynuować..."
            ;;
        3)
            echo "Zajętość dysku:"
            df -h
            read -p "Naciśnij Enter, aby kontynuować..."
            ;;
        4)
            echo "Otwarte porty:"
            netstat -tuln
            read -p "Naciśnij Enter, aby kontynuować..."
            ;;
        *)
            echo "Niepoprawna opcja. Naciśnij Enter, aby kontynuować..."
            read
            ;;
    esac
done
