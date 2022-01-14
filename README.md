## About

After years of working with different Django projects, I noticed some excellent design patterns that help maintain the project's code quality, simplicity, readability, maintainability, reliability, and testing.

This is a compilation of patterns and libraries that I learned over the years to help build a robust Django application fast.

#### Stack included

- Django3
- Postgres
- GraphQL/Graphene
- Docker
- Pytest
- Factory Boy

#### Patterns

- Repository Pattern, for the database
- Single app
- Service


## Running

- Clone the project: `$ git clone git@github.com:marcosflp/django-boilerplate.git project_name`
- Access the project folder: `$ cd project_name`

### Docker

`$ docker compose up`

#### Running tests

`docker compose exec web pytest`

### Locally

- Create a new virtual env
- Install the dependencies: `$ pip install -r requirements.txt`
- Run migrations: `$ python manage.py migrate`
- Run the server: `$ python manage.py runserver`

#### Running tests

`$ pytest`
