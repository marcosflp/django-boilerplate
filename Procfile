web: gunicorn wsgi --log-file -
worker: celery -A core.celery_worker worker -B -l info
