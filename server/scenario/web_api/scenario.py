from flask import Blueprint

import models
from utils.decorator import admin_only

web_api = Blueprint("web_api-scenario", __name__)


@web_api.get("/templates")
@admin_only
def get_templates():
    return [
        {
            "id": scenario.id,
            "name": scenario.name,
            "executions": [
                {"id": execution.id, "name": execution.name}
                for execution in scenario.executions
            ],
            "patients": [
                {"id": patient.id, "name": patient.name}
                for patient in scenario.get_patients()
            ],
        }
        for scenario in models.Scenario.query
    ]
