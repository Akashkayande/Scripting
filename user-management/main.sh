#!/bin/bash


source ./user.sh

mkdir -p logs

if [[ "$UID" -ne 0 ]]; then
    echo "Run as root"
    exit 1
fi

show_menu() {
    echo "========= User Management ========="
    echo "1. Create User"
    echo "2. Delete User"
    echo "3. Update User"
    echo "4. Exit"
}

while true; do
    show_menu
    read -p "Choose option: " choice

    case $choice in
        1)
            read -p "Enter username: " username
            read -p "Enter group: " group
            create_user "$username" "$group"
            ;;
        2)
            read -p "Enter username: " username
            delete_user "$username"
            ;;
        3)
            read -p "Enter old username: " username
            read -p "Enter new username: " new_username
            read -p "Enter new group: " group
            update_user "$username" "$new_username" "$group"
            ;;
        4)
            exit 0
            ;;
        *)
            echo "Invalid option"
            ;;
    esac
done
