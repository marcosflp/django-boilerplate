# About

A Django boilerplate project that uses great patterns and libraries to help you build a robust Django application fast. 
You can quickly start writing up your applications features.


# Setup

```shell
# Clone the project
git clone git@github.com:marcosflp/django-boilerplate.git project_name
cd project_name

# Install pre-commit
pip install pre-commit
pre-commit install
```

### Docker

```shell
# Running the app
docker compose up

# Running tests
docker compose exec web pytest
```

### Locally

```shell
# Before starting, remember to create a new virtual env.
# Also, you need to have a running postgres server with the right credentials configured on the settings

# Install the dependencies 
pip install -r requirements.txt
 
# Run migrations:
python manage.py migrate

# Running the server
python manage.py runserver

# Running tests
pytest

```


# Deployment

Automatically deploy the project to AWS with Terraform and Ansible.

### Configure

> You need an AWS credential with admin access to create: 
(1) EC2, (2) RDS instances, (3) network resources

Add to your ~/.bash_rc fish or zsh file the following environment variables
```bash
# AWS (Required by Terraform and Ansible)
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=

# Godaddy (Required by Terraform)
export GODADDY_API_KEY=
export GODADDY_API_SECRET=

# Terraform variables used by Django 
export TF_VAR_AWS_DB_PASSWORD_DJANGO_BOILERPLATE=
```

Using Search Everywhere and Match case on your IDE or Text Editor, rename all in the following order: 
  - `django-boilerplate.org` to `your-domain.com`
  - `django_boilerplate` to `your_project_name`  
  - `Django Boilerplate ` to `Your Project Name` 
  - `DJANGO_BOILERPLATE` to `YOUR_PROJECT_NAME` 

## Terraform

Create and manage your infrastructure with Terraform.

### Configure
```shell
# Initial Setup
cd deployment/terraform
terraform init
```

### Deploy

```shell
# Create or Update resources on AWS using Terraform apply
terraform apply
```

## Ansible

Automate the setup and deployment process of your application with Ansible. 

### Configure

```shell
# Set the hosts at
deployment/config_files/inventory

# Create and set your ansible vars
cp deployment/application/ansible/vars.yml.example deployment/application/ansible/vars.yml

# Create and set all Django production env variables
cp deployment/config_files/.env.production.example deployment/config_files/.env.production

# Rename the Nginx site-available
mv deployment/config_files/nginx/sites-enabled/django_boilerplate.org.conf deployment/config_files/nginx/sites-enabled/yourdomain.com.conf

# Rename the Nginx site-enabled
mv deployment/config_files/nginx/sites-enabled/django_boilerplate.org.conf deployment/config_files/nginx/sites-enabled/yourdomain.com.conf

# Make sure Nginx is properly configured (server_name, location, etc) at
deployment/config_files/nginx/sites-enabled/yourdomain.com.conf

# Make sure Gunicorn is properly configured (WorkingDirectory, ExecStart) at
deployment/config_files/gunicorn.service
```

Set up and run the initial Django app
```shell
cd deployment/ansible
ansible-playbook -i inventory playbook_setup_ubuntu.yml playbook_setup_django.yml playbook_setup_webservers.yml --tags="setup"
```


### Deploy

```shell
cd deployment/ansible
ansible-playbook -i inventory playbook_setup_ubuntu.yml playbook_setup_django.yml playbook_setup_webservers.yml --tags="deploy"
```


## Included

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
