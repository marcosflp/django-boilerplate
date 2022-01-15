FROM python:3

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app
COPY requirements.txt /app/

# Install expensive things
# Install general dependencies, set configurations, and do some cleanup
RUN \
  BUILD_DEPS='g++ python3-dev libffi-dev' \
  && apt-get update \
  && apt-get install -y wget less git libpq-dev vim-tiny python3 python3-pip python-is-python3 libpython3.9 \
  && apt-get install -y --no-install-recommends $BUILD_DEPS \
  && pip install --no-deps -r requirements.txt \
  && apt-get install -y locales \
  && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
  && dpkg-reconfigure --frontend=noninteractive locales \
  && apt-get purge --autoremove -y $BUILD_DEPS \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Copy the project to the container
COPY . /app/
