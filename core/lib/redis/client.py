import fakeredis
from django.conf import settings
from redis import Redis

"""
General Redis client for when a shared key space is acceptable

- keys should all be prepended with unique string
- cardinality of keys should be low
- SCAN should not be used

"""

if settings.TESTING:
    redis_client = fakeredis.FakeStrictRedis()
else:
    redis_client = Redis.from_url(settings.REDIS_URL, db=settings.GENERAL_REDIS_DB)


redis_celery_client = Redis.from_url(settings.REDIS_URL, db=settings.CELERY_REDIS_DB)
