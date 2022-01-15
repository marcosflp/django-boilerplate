import os

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "settings")

from core.lib.celery.app import app  # noqa
