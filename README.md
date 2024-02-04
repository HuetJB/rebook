# Rebook

Rebook is a website allowing students to resell school books to each other.

## Dev Requirements

- [git](https://git-scm.com/book/fr/v2/D%C3%A9marrage-rapide-Installation-de-Git)
- [docker](https://docs.docker.com/engine/install/ubuntu/)
- [python](https://vegastack.com/tutorials/how-to-install-python-3-11-on-ubuntu-22-04/)
- [poetry](https://pypi.org/project/poetry/)

## Quick start

### To setup the developpement instance

```bash
./setup
```

### Start the instance

```bash
docker compose up -d
```

## Use Django manager script

### To migrate Django database

```bash
docker compose exec rebook python manage.py migrate
```

### To create a admin user for the Django app

```bash
docker compose exec rebook python manage.py createsuperuser
```

## For install poetry for dev in local

```bash
poetry install
```

## To run tests in local

### Linter and formater tests :

```sh
poetry run pre-commit run -a
```

## Pre-commit

For install pre-commit in your local repository

```bash
poetry install
pre-commit install
pre-commit installed at .git/hooks/commit-msg
```

## Docker compose

`setup` script generate a docker compose for developpement purpose. It takes as input the standard `docker-compose.yml` (same as used in production) and `docker-compose-dev-override`.

It generates a final `docker-compose.yml` to be used easily in your on environment.

To modify something inside docker-compose, use the source file and re-run `./setup.sh` script.

## Environment variables

All environment variables are generated from `deploy/env` in the `docker-compose.yml` file by the script `./setup.sh`

## Naming convention

### For branchs

Format of branch name :
```txt
<type>/<name of branch>
```

Availables type :

- `feat` Add a feature
- `fix` Fix a bug
- `clean` Clean the codebase
- `refactor` Refactor the codebase

### For commits

Format of commit messages :

```txt
<type>(<scope>): <subject of commit>
```

Availables type :

- `feat` Add a feature
- `fix` Fix a bug
- `ci` Change a file or add feature in link with the deployment of the application (Jenkins, Travis, Ansible, gitlabCI, npm, grunt, gulp, webpack, etc.)
- `docs` Add documentation (README, JSdoc, comments, etc.)
- `refactor` Change codebase without add feature or fix bug
- `test` Add test
