# Docker Compose with SQLite
Example using MySql database.

## Usage
Create an `.env` file by copying the example:
```shell
cp .env-example .env
```
Edit the `.env` file to your liking.

Fire up the application with docker compose:
```shell
docker compose up -d
```
Follow the logs:
```shell
docker compose logs -f
```

The application is available on http://0.0.0.0/ on standard port 80.
