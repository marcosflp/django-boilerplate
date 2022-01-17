web: gunicorn wsgi --log-file -
celery: celery -A core.celery_worker worker -B -l info
