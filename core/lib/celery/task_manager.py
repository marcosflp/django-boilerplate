from core.lib.redis.client import redis_client

DEFAULT_TASK_THROTTLE_EXPIRATION_SECONDS = 3600
TASK_DISABLED_KEY_PREFIX = "celery_task_disabled"


def is_task_disabled(task_name: str):
    key = _get_task_disabled_redis_key(task_name)
    return redis_client.exists(key) == 1


def disable_task(task_name: str, expiration_seconds=DEFAULT_TASK_THROTTLE_EXPIRATION_SECONDS):
    key = _get_task_disabled_redis_key(task_name)
    redis_client.set(key, "true", ex=expiration_seconds)


def enable_task(task_name: str):
    key = _get_task_disabled_redis_key(task_name)
    redis_client.delete(key)


def _get_task_disabled_redis_key(task_name):
    return f"{TASK_DISABLED_KEY_PREFIX}:{task_name}"
