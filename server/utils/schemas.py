from apiflask import Schema
from apiflask.fields import String


class CsrfSchema(Schema):
    csrf_token = String(required=True)
