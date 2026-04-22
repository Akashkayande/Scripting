#!/bin/bash

DEFAULT_SHELL="/bin/bash"

source ./log.sh
source ./validation.sh

create_user() {
    local username=$1
    local group=$2

    if [[ -z "$username" || -z "$group" ]]; then
        log_error "Username or group cannot be empty"
        echo "ERROR: Username and group are required"
        return 1
    fi

    if ! validate_username "$username"; then
        log_error "Invalid username: $username"
        echo "Invalid username"
        return 1
    fi

    if id "$username" &>/dev/null; then
        log_error "User already exists: $username"
        echo "User already exists"
        return 1
    fi

    if ! getent group "$group" &>/dev/null; then
    log_info "Group does not exist. Creating group: $group"
    echo "Group does not exist. Creating group: $group"
    groupadd "$group"

    if [[ $? -ne 0 ]]; then
        log_error "Failed to create group: $group"
        echo "Failed to create group"
        return 1
    fi
fi

    password=$(generate_password)
    log_info "Generated password for $username: $password"
    useradd -m -s "$DEFAULT_SHELL" -g "$group" "$username"
    if [[ $? -ne 0 ]]; then
        log_error "user not create successfully"
        echo "user not create successfully"
        return 1
    fi

    echo "$username:$password" | chpasswd

    if [[ $? -ne 0 ]]; then
        log_error "password  not set successfully"
        echo "password  not set successfully"
        return 1
    fi
    
    passwd -e $username

    log_info "User created: $username with group $group"
    echo "User created: $username with group $group"
}

delete_user() {
    local username=$1

    if ! id "$username" &>/dev/null; then
        log_error "User does not exist: $username"
        echo "User does not exist: $username"
        return 1
    fi

    userdel -r "$username"
    log_info "User deleted: $username"
    echo "User deleted: $username"
}

update_user() {
    local old_username=$1
    local new_username=$2
    local new_group=$3

    if ! id "$old_username" &>/dev/null; then
        log_error "User not found: $old_username"
        echo "User not found: $old_username"
        return 1
    fi


    if [[ -z "$new_username" ]]; then
        log_error "New username cannot be empty"
        echo "New username cannot be empty"
        return 1
    fi

    if ! validate_username "$new_username"; then
        log_error "Invalid username: $new_username"
        echo "Invalid username :$new_username"
        return 1
    fi

    if id "$new_username" &>/dev/null; then
        log_error "New username already exists: $new_username"
        echo "Username already exists"
        return 1
    fi

    if [[ -z "$new_group" ]]; then
        log_error "new_group cannot be empty"
        echo "new_group cannot be empty"
        return 1
    fi
    if ! getent group "$new_group" &>/dev/null; then
        log_info "Group does not exist. Creating group: $new_group"
        groupadd "$new_group"

        if [[ $? -ne 0 ]]; then
            log_error "Failed to create group: $new_group"
            echo "Failed to create group"
            return 1
        fi
    fi

    log_info "Renaming user $old_username -> $new_username"

    usermod -l "$new_username" "$old_username"

    if [[ $? -ne 0 ]]; then
        log_error "Failed to change username"
        echo "Username update failed"
        return 1
    fi

    if [[ -d "/home/$old_username" ]]; then
        usermod -d "/home/$new_username" -m "$new_username"
        log_info "Home directory moved to /home/$new_username"
    fi

    usermod -g "$new_group" "$new_username"

    if [[ $? -ne 0 ]]; then
        log_error "Failed to update group for $new_username"
        return 1
    fi

    log_info "User updated: $old_username -> $new_username | Group: $new_group"

    echo "User successfully updated:"
    echo "Username: $old_username -> $new_username"
    echo "Group: $new_group"
}