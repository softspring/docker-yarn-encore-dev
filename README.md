# Docker yarn container for webpack

Docker yarn container for webpack.

## Install

    composer require softspring/docker-yarn-encore-dev --no-scripts --dev
    
## Configure docker-compose.yaml

    version: '3'
    
    services:
      yarn:
        container_name: container_name
        build:
            context: vendor/softspring/docker-yarn-encore-dev
            args:
              USER_NAME: <USERNAME>
              UID: <UID>
        working_dir: /app
        volumes:
         - .:/app
        user: <USERNAME>
        environment:
          USER_NAME: <USERNAME>
