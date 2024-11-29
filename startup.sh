#!/bin/sh

# Variables for startup script
SERVE_PATH=/usr/share/nginx/html
NAME=OpenShock

require() {
    if [ -z "$1" ]; then
        echo "Env var '$1' is required. Specify it and restart the container."
        exit 1
    fi
}

# Method that accepts one argument, the name of the environment variable to inject.
# Will substitute said variable as a literal string 
inject() {
    if [ -z "$1" ] && [ -z "$2" ]; then
        echo "[$NAME] Usage: inject <variable> <value>"
    fi
    
    # Ensure the environment variable has a value specified.
    require $1

    echo "[$NAME] Injecting variable: $1 = $2"
    find $SERVE_PATH -name "*.js" -exec sed -i "s|$1|$2|g" {} +
    find $SERVE_PATH -name "*.html" -exec sed -i "s|$1|$2|g" {} +
}

# Inject our variables.
inject OPENSHOCK_NAME $OPENSHOCK_NAME
inject OPENSHOCK_URL $OPENSHOCK_URL
inject OPENSHOCK_API_URL $OPENSHOCK_API_URL
inject OPENSHOCK_SHARE_URL $OPENSHOCK_SHARE_URL
inject OPENSHOCK_DEV $OPENSHOCK_DEV

# Start nginx as normal.
# If something breaks, see: https://github.com/nginxinc/docker-nginx/blob/master/mainline/debian/Dockerfile
echo "[$NAME] Starting nginx"
./docker-entrypoint.sh "$@"
