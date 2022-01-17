"""
WSGI config for the project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/3.0/howto/deployment/wsgi/
"""
import logging
import os
import time

from django.conf import settings
from django.core.wsgi import get_wsgi_application

logger = logging.getLogger(__name__)

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "settings")
application = get_wsgi_application()

# Preload urls/views/schemas, to avoid Django lazily-importing those on the first request
# which can cause that first request to time out.
if not settings.DEBUG:
    logger.info("Set up application, loading urls and views")
    start = time.time()

    import core.api.graphql.schema  # noqa
    import core.urls  # noqa

    elapsed = time.time() - start
    logger.info("Loaded all imports (elapsed={})".format(elapsed))
