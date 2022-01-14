class BaseException(Exception):  # noqa
    """
    Useful base exception class, adds some common attributes (code, data) to the built-in class
    """

    def __init__(self, message=None, code=None, data=None):
        super().__init__(message)
        self.message = message
        self.code = code
        self.data = data
