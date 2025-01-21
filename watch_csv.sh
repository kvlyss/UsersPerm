CSV_FILE="users.csv"

while inotifywait -e modify "$CSV_FILE"; do
    ./accessrights.sh
done
