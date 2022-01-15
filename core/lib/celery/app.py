from celery import Celery
from django.conf import settings

from core.lib.celery.constants import Queue, TaskPriority

# Remember to register the module that you added a new task
include_modules = ["core.tasks"]

celery_config = dict(
    task_serializer="json",
    task_ignore_result=True,  # we don't need to store results for most tasks
    task_acks_late=False,
    broker_transport_options={
        "queue_order_strategy": "priority",
        "sep": ":",
        "priority_steps": [0, 5, 9],
    },
    worker_prefetch_multiplier=settings.CELERY_WORKER_PREFETCH_MULTIPLER,
    worker_redirect_stdouts_level="INFO",
    worker_hijack_root_logger=False,  # Django is already logging, don't double-log
    task_always_eager=settings.CELERY_TASK_ALWAYS_EAGER,
    task_eager_propagates=settings.CELERY_TASK_ALWAYS_EAGER,
    task_default_queue=Queue.DEFAULT,
    task_default_priority=TaskPriority.MEDIUM,
)


app = Celery(
    "celery",
    backend=settings.CELERY_BROKER_URL,
    broker=settings.CELERY_BROKER_URL,
    include=include_modules,
)
app.conf.update(**celery_config)

app.autodiscover_tasks()
