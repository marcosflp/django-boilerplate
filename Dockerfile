FROM python:3.9

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app
COPY requirements.txt /app/

# Install expensive things
RUN \
  BUILD_DEPS='g++ python3-dev libffi-dev git gnupg2' \
  # Install default packages \
  && apt-get update \
  && apt-get install -y --no-install-recommends $BUILD_DEPS \
  && apt-get install -y wget less git libpq-dev vim-tiny python3 python3-pip python-is-python3 \
  # Install postgres-client \
  && apt-get -y install postgresql-client \
  # Install project requirements
  && pip install --no-deps -r requirements.txt \
  # Set linux default configurations
  && apt-get install -y locales \
  && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
  && dpkg-reconfigure --frontend=noninteractive locales \
  # Uninstall packages used to build pip requirements
  && apt-get purge --autoremove -y $BUILD_DEPS \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Copy the project to the container
COPY . /app/

# Collect static files
RUN python manage.py collectstatic --noinput
