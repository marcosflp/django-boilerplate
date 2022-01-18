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
