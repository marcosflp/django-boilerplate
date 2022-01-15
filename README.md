## About

After years of working with different Django projects, I noticed some excellent design patterns that help maintain the project's code quality, simplicity, readability, maintainability, reliability, and testing.

This is a compilation of patterns and libraries that I learned over the years to help build a robust Django application fast.

#### Stack included

- Django3
- Postgres
- Pytest
- Factory Boy
- Celery
- Redis
- GraphQL/Graphene
- Docker

#### Patterns

- Repository Pattern, for the database
- Single app
- Service


## Setup

- Clone the project: `$ git clone git@github.com:marcosflp/django-boilerplate.git project_name`
- Go to `$ cd project_name`

Install pre-commit
```sh
$ pip install pre-commit
$ pre-commit install
```


### Docker

- Running the app: `$ docker compose up`
- Running tests: `docker compose exec web pytest`

### Locally

- Create a new virtual env
- Install the dependencies: `$ pip install -r requirements.txt`
- You have to install and run the postgres server. Also, configure the database settings 
- Run migrations: `$ python manage.py migrate`
- Running the server: `$ python manage.py runserver`
- Running tests: `$ pytest`
