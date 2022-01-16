import logging

from django.utils import timezone

from core.lib.celery import task

logger = logging.getLogger(__name__)


@task
def heartbeat():
    logger.info("Heartbeat %s", str(timezone.now()))
