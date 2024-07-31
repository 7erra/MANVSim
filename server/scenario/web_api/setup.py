from apiflask import APIFlask

from scenario.web_api import scenario


def setup(app: APIFlask):
    """Connects each implemented endpoint to flask environment."""
    app.register_blueprint(scenario.web_api, url_prefix="/web")
