from celery.schedules import crontab

PERIODIC_TASKS = {
    # Executes every 3 minutes
    "cron_heartbeat": {
        "task": "core.tasks.heartbeat",
        "schedule": crontab(minute="*/3"),
    },
}
