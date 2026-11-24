#!/usr/bin/env bash
# Membuat pasangan key RSA untuk JWT. Private key hanya dipakai auth-ep, public key dipakai service lain.
set -euo pipefail

directory="$(cd "$(dirname "$0")/.." && pwd)/keys"

mkdir -p "$directory"

if [ -f "$directory/jwt-private.pem" ]; then
    echo "Key sudah ada di $directory, tidak ditimpa."
    exit 0
fi

openssl genrsa -out "$directory/jwt-private.pem" 2048
openssl rsa -in "$directory/jwt-private.pem" -pubout -out "$directory/jwt-public.pem"

echo "Key dibuat di $directory"
