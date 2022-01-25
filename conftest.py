import pytest
from freezegun import freeze_time


@pytest.fixture
def freezer():
    """
    Use freezegun as a pytest fixture
    """
    with freeze_time() as freezer:
        yield freezer
