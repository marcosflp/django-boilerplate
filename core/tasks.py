import time

from core.lib.celery import task


@task
def dummy_task():
    time.sleep(2)
    print("Hello from Dummy task")
