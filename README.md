GameAP Docker image

## How to use

### Start a GameAP instance
```bash
docker run --name gameap -p 1215:1215 gameap/gameap
```

#### With environments

```bash
docker run \
    --name gameap \
    -p 1215:1215 \
    -e ADMIN_PASSWORD=fpwPOuZD \
    -e APP_LANG=ru \
    -e APP_URL=https://example.com \
    gameap/gameap
```

### ... via `docker stack deploy` or `docker-compose`

```
version: '3.1'

services:

  gameap:
    image: gameap/gameap
    restart: always
    volumes:
        - ./gameap-certs:/var/www/gameap/storage/app/certs
    environment:
        ADMIN_PASSWORD: fpwPOuZD
        APP_LANG: ru
        APP_URL: https://example.com
        DB_CONNECTION: mysql
        DB_HOST: db
        DB_DATABASE: gameap
        DB_USERNAME: gameap
        DB_PASSWORD: gameap
    depends_on:
          - db
  db:
      image: mysql
      command: --default-authentication-plugin=mysql_native_password
      restart: always
      environment:
        MYSQL_ROOT_PASSWORD: rootpass
        MYSQL_DATABASE: gameap
        MYSQL_USER: gameap
        MYSQL_PASSWORD: gameap
```

## Environment Variables

You can set any GameAP environment (see [.env.example](https://github.com/et-nik/gameap/blob/develop/.env.example))

| Variable           | Description                                                     |
|--------------------|-----------------------------------------------------------------|
| ADMIN_PASSWORD     | Admin password. Skip this variable if you want random value     |
| APP_LANG           | Language                                                        |
| APP_URL            | GameAP Url                                                      |
| APP_TIMEZONE       | TimeZone (example UTC, Europe/Moscow                            |

