#!/bin/sh

[[ -f .env ]] && echo "JUST DONT" && exit 1

## You can (should) customize those variables
# the docker-compose project name
export CHATONS_COMPOSE_PROJECT=oxyta
# the host directory for the containers' volumes
export CHATONS_ROOT_DIR=/srv
# the domain name for all services
export CHATONS_DOMAIN=oxyta.net
# the email to which services will send important email
export CHATONS_MAIL=services@$CHATONS_DOMAIN

## Thos does not need customization
export CHATONS_MYSQL_PASSWORD=$(openssl rand -base64 32)
export CHATONS_MYSQL_ROOT_PASSWORD=$(openssl rand -base64 32)

if [ ! -d "$CHATONS_ROOT_DIR" ]; then
    echo "error: $CHATONS_ROOT_DIR must exist and be a regular folder" >&2
    exit 1
fi

# Export common environment variables

echo "COMPOSE_PROJECT_NAME=$CHATONS_COMPOSE_PROJECT" > .env
echo "CHATONS_ROOT_DIR=$CHATONS_ROOT_DIR" >> .env
echo "CHATONS_DOMAIN=$CHATONS_DOMAIN" >> .env
echo "CHATONS_MAIL=$CHATONS_MAIL" >> .env

# Export specific environment configuration

mkdir -p cloud pad

echo "MYSQL_PASSWORD=$CHATONS_MYSQL_PASSWORD" > cloud/.env
echo "MYSQL_ROOT_PASSWORD=$CHATONS_MYSQL_ROOT_PASSWORD" >> cloud/.env
echo "MYSQL_ROOT_PASSWORD=$CHATONS_MYSQL_ROOT_PASSWORD" > pad/.env
echo "ETHERPAD_DB_PASSWORD=$CHATONS_MYSQL_ROOT_PASSWORD" >> pad/.env

# Configure traefik

mkdir -p "$CHATONS_ROOT_DIR/traefik"
touch "$CHATONS_ROOT_DIR/traefik/acme.json"
chmod 600 "$CHATONS_ROOT_DIR/traefik/acme.json"
sed "s/###DOMAIN###/$CHATONS_DOMAIN/" traefik/traefik.toml > "$CHATONS_ROOT_DIR/traefik/traefik.toml"
