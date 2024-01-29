#!/bin/bash
clear
sleep 1
Y='\033[0;33m'
G='\033[0;32m'
RESET='\033[0m'
R='\033[0;31m'

count=0
found=0

echo " "
echo ""
chondro="
 _     ___  _       _____ ___ _     _____ 
| |   / _ \| |     |  ___|_ _| |   | ____|
| |  | | | | |     | |_   | || |   |  _|  
| |__| |_| | |___  |  _|  | || |___| |___ 
|_____\___/|_____| |_|   |___|_____|_____|
                               Version:1.0
"
echo -e "${Y}$chondro ${RESET}"

folder_path="Recover"
word="Wordlist"

if [ -z "$(ls -A "$folder_path")" ]; then
    echo -e "${R}Recover folder is empty!${RESET}" 
else
    for file in "$folder_path"/*; do
        count=$((count+1))
        if [ $count -lt 2 ]; then
            formate=${file##*.}
            for w in "$word"/*; do 
                if [ -z "$(ls -A "$word")" ]; then
                    sleep 0.5
                    echo -e "${R}Wordlist folder is empty!${RESET}"
                else
                    if [ "$formate" = "zip" ] || [ "$formate" = "7z" ]; then
                    while read -r words; do
                        count=$((count+1))
                        7z t -p"$words" "$file" &>/dev/null
                        if [ $? = 0 ]; then
                            echo " "
                            echo -e "${G}[+]Password found: $words${RESET}"
                            found=1
                            break
                        else
                            echo -ne "\r${Y}[$count] Typing Password: $words ${RESET}"
                        fi
                    done < "$w"
                    if [ $found = 0 ]; then
                        echo " "
                        echo " "
                        echo " "
                        echo -e "${R}Password not found in this wordlist!${RESET}"
                    fi
                    elif [ "$formate" = "rar" ]; then
                        while read -r words; do
                            unrar t -p"$words" "$file" &>/dev/null
                            if [ $? = 0 ]; then
                                echo " "
                                echo -e "${G}[+]Password found: $words${RESET}"
                                found=1
                                break
                            else
                                echo -ne "\r${Y}[$count] Typing Password: $words ${RESET}"
                            fi
                        done < "$w"
                        if [ $found = 0 ]; then
                        echo " "
                        echo " "
                        echo " "
                        echo -e "${R}Password not found in this wordlist!${RESET}"
                        fi
                    elif [ "$formate" = "pdf" ]; then
                        while read -r words; do
                            qpdf --check --password="$words" "$file" &>/dev/null
                            if [ $? = 0 ]; then
                                echo " "
                                echo -e "${G}[+]Password found: $words${RESET}"
                                found=1
                                break
                            else
                                echo -ne "\r${Y}[$count] Typing Password: $words ${RESET}"
                            fi
                        done < "$w"
                        if [ $found = 0 ]; then
                        echo " "
                        echo " "
                        echo " "
                        echo -e "${R}Password not found in this wordlist!${RESET}"
                        fi
                    else
                        echo -e "${R}$formate  file is not allowed!"
                    fi
                fi
            done 
        else
            sleep 0.5
            echo -e "${R}No multiple files allowed in Recover folder${RESET}"
            break
        fi
    done
fi