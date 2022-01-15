import functools
import logging
import time

import requests

from core.lib.celery.app import app
from core.lib.celery.task_manager import is_task_disabled


logger = logging.getLogger(__name__)

# Set up task decorator to be registered to our Celery app
orig_task = app.task


def time_celery_function(func):
    """
    A decorator used to log the function execution time.
    """

    func_name = func.__name__

    @functools.wraps(func)
    def wrap(*args, **kwargs):
        if is_task_disabled(func_name):
            logger.info("Celery task %s disabled, skipping run", func_name)
            return

        start = time.time()
        result = func(*args, **kwargs)
        elapsed_seconds = time.time() - start
        logger.debug("Elapsed %s", elapsed_seconds)

        return result

    return wrap


def task(*args, **kwargs):
    if len(args) == 1 and callable(args[0]):
        func = args[0]
        return orig_task(**kwargs)(time_celery_function(func))

    def decorator(func):
        return orig_task(*args, **kwargs)(time_celery_function(func))

    return decorator


"""
Task decorator with some simple default retry options. Note that it will retry for ANY exception class
"""
task_with_retries = functools.partial(
    task,
    max_retries=3,
    retry_backoff=True,
    default_retry_delay=30,
    autoretry_for=(Exception,),  # retry for any exception
    retry_backoff_max=5 * 60,
    retry_jitter=True,
)


task_with_connection_retry = functools.partial(task_with_retries, autoretry_for=(requests.exceptions.ConnectionError,))
