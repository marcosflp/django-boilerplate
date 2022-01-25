import factory

from core.db.models import User
from core.tests.faker import faker


class UserFactory(factory.django.DjangoModelFactory):
    email = factory.LazyFunction(lambda: faker.unique.email())
    first_name = factory.LazyFunction(lambda: faker.first_name())
    last_name = factory.LazyFunction(lambda: faker.last_name())

    class Meta:
        model = User
