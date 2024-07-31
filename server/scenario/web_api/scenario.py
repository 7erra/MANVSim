import models
from apiflask import APIBlueprint, Schema
from apiflask.fields import Integer, Nested, String
from utils.decorator import admin_only

web_api = APIBlueprint("web_api-scenario", __name__)


class ExecutionOut(Schema):
    id = Integer()
    name = String()


class TemplateOut(Schema):
    id = Integer()
    name = String()
    executions = Nested(ExecutionOut(many=True))


@web_api.get("/templates")
@admin_only
@web_api.output(TemplateOut(many=True))
def get_templates():
    "Returns a list of available scenarios and their associated executions"
    return models.Scenario.query
