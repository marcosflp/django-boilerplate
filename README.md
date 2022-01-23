## About

After years of working with different Django projects, I noticed some excellent design patterns and packages that helps maintain the project's code quality, simplicity, readability, maintainability, reliability, and testing.

This is a compilation of patterns and libraries that I learned over the years to help build a robust Django application fast.

#### Stack included

- Django3
- Postgres
- Pytest
- Factory Boy
- Celery
- Celery Beat (Periodic tasks)
- Python decouple
- Pytest
- Isort
- Black
- Flak8
- Pre-commit
- Redis
- GraphQL/Graphene
- Docker

#### Patterns

- Repository Pattern
  - Every query should be written in the module `core/db/repository`
  - Avoid writing queries on Django's Manager/QuerySet.
  - The repository functions should return a list of instances, instead of a QuerySet. This makes easy caching data. 
- Single Django app layer
  - It's recommend to write the entire application inside the `core`
  - Avoid creating new django apps
- One model per file
  - Each model should have its own file in `core/db/models/`
- Service layer
  - Add all business logic in `core/services/`



## Setup

Clone the project
```shell
$ git clone git@github.com:marcosflp/django-boilerplate.git project_name
$ cd project_name
```

Install pre-commit
```shell
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


## Deployment

Automatically deploy this project to Heroku!

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

### How it works

The "Deploy to Heroku" button enables users to deploy apps to Heroku without leaving the web browser, and with little or no configuration. There are four conf files required to deploy this project: 

#### `app.json`

This file describes the settings to automatically deploy the project to Heroku.

- **env**: environment variables. Most of the settings is already configured. You just need to make sure to set the `ALLOWED_HOSTS` and `FRONTEND_APP_URL` correctly to avoid CORS problems 
- **addons**: specify the services used by the application (e.g.: postgres)
- **formation**: define the dyno instances. You can set the size and the amount of instances
- **buildpacks**: specify how to build the application. By adding `"heroku/python"` heroku will automatically:
  - Build a python instance to run the project
  - Install the project's dependencies from the `requirements.txt` file
  - Run `python manage.py collectstatic`

#### `Procfile`

This file specifies the commands that are executed by the app on startup. We are using it to run the django and celery after Heroku finishes the deployment.

#### `bin/post_compile`

This is a bash script file that is used by `"heroku/python"` build-pack to run commands at the end of the deployment cycle.

We are using this file to automatically run the migrations.

#### `runtime.txt`

Specify the python version to be used by `"heroku/python"` build-pack
