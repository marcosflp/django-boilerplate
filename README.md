## About

After years of working with different Django projects, I noticed some excellent design patterns and packages that helps maintain the project's code quality, simplicity, readability, maintainability, reliability, and testing.

This is a compilation of patterns and libraries that I learned over the years to help build a robust Django application fast.


## Stack included

**App**
- [Django3](https://www.djangoproject.com/), framework for building fast and clean web applications
- [Postgres](https://www.postgresql.org/), open-source object-relational database for persisting data
- [Redis](https://redis.io/), in-memory data structure store used as a database, cache, and message broker
- [GraphQL/Graphene](https://docs.graphene-python.org/projects/django/en/latest/), query language for the API and a runtime for fulfilling those queries with existing data
- [Python decouple](https://github.com/henriquebastos/python-decouple), helps you to organize your project settings on environment variables

**Background and scheduled tasks:**
- [Celery](https://docs.celeryproject.org/en/stable/), task queue with to process background tasks
- [Celery Beat (Periodic tasks)](https://docs.celeryproject.org/en/stable/userguide/periodic-tasks.html), scheduler to kick off tasks at regular intervals

**Testing:**
- [Pytest](https://docs.pytest.org/en/6.2.x/), test framework that makes easy to write small and scalable tests
- [Faker](https://faker.readthedocs.io/en/master/), generates fake data for you
- [Freezegun](https://github.com/spulec/freezegun), allows your tests to freeze or travel through time
- [Factory Boy](https://factoryboy.readthedocs.io/en/stable/#), fixture replacement tool that aims to easy-to-use factories for complex objects
- [Pytest-Mock](https://pypi.org/project/pytest-mock/), plugin that provides a `mocker` fixture that is a wrapper around the mock package

**Development**
- [Docker](https://www.docker.com/), build and run the entire application in docker containers
- [Watchdog](https://pypi.org/project/watchdog/), python file change monitor to reload django fast when you modify a python file
- [Isort](https://github.com/PyCQA/isort), sort and organize your imports automatically
- [Black](https://github.com/psf/black), code-formatter that automatically restructure your code
- [Flak8](https://flake8.pycqa.org/en/latest/), tool for styled guide enforcement
- [Pre-commit](https://pre-commit.com/), framework for managing and maintaining pre-commit hooks


## Patterns

- Repository Pattern
  - Almost every query should live in `core/db/repository/`
  - Avoid writing queries on Django's Manager/QuerySet.
  - The repository functions should return a list of instances, instead of a QuerySet. This makes easy caching data. 
- Single Django app layer
  - It's recommend to write the entire application inside the `core`
  - Avoid creating new django apps
- One model per file
  - Each model should have its own file in `core/db/models/`
- Service layer
  - All business logic should be added in `core/services/`


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

Automatically deploy this project to AWS with Terraform and Ansible!

### Set environment variables

AWS - With admin access to create EC2, RDS instances and network resources
```shell
$ export AWS_ACCESS_KEY_ID=
$ export AWS_SECRET_ACCESS_KEY=
```

Terraform
```shell
$ export TF_VAR_AWS_DB_PASSWORD_DJANGO_BOILERPLATE=
```


### Terraform


Setup
```shell
$ cd deployment/terraform
$ terraform init
$ terraform apply
```

### Ansible

Create and set all Django production's settings env variables 
```shell
$ cp deployment/config_files/.env.production.example deployment/config_files/.env.production
```

Update Nginx domain name at
```shell
$ deployment/config_files/nginx/sites-enabled/django_boilerplate.org.conf
```

Update gunicorn path at
```shell
$ deployment/config_files/gunicorn.service
```

Set the hosts at
```shell
$ deployment/config_files/inventory
```

Setup the entire Django app and Webservers
```shell
$ cd deployment/ansible
$ ansible-playbook -i inventory playbook_setup_ubuntu.yml playbook_setup_django.yml playbook_setup_webservers.yml --tags="setup"
```

Deploy updates
```shell
$ cd deployment/ansible
$ ansible-playbook -i inventory playbook_setup_ubuntu.yml playbook_setup_django.yml playbook_setup_webservers.yml --tags="deploy"
```
