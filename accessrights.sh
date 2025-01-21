CSV_FILE="users.csv"

if [ ! -f "$CSV_FILE" ]; then
    echo "Le fichier CSV $CSV_FILE n'existe pas."
    exit 1
fi

while IFS=, read -r username is_admin
do
    
    if [ "$username" == "username" ]; then
        continue
    fi

    
    if id "$username" &>/dev/null; then
        echo "L'utilisateur $username existe déjà."
    else
        sudo useradd -m "$username"
        echo "$username:password" | sudo chpasswd
        echo "L'utilisateur $username a été créé."
    fi

    
    if [ "$is_admin" == "yes" ]; then
        sudo usermod -aG sudo "$username"
        echo "L'utilisateur $username a été ajouté au groupe sudo."
    fi
done < "$CSV_FILE"
