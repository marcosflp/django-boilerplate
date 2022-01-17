web: gunicorn wsgi
worker: celery -A core.celery_worker worker -l info
beat: celery -A core.celery_worker beat -l info
