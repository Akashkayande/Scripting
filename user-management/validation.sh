#!/bin/bash

validate_username() {
    [[ "$1" =~ ^[a-z_][a-z0-9_-]*$ ]]
}


generate_password() {
    echo "$(date +%s%N | sha256sum | head -c 12)"
}