from apiflask import APIFlask

from execution.web_api import notification, lobby


def setup(app: APIFlask):
    """Connects each implemented endpoint to flask environment."""
    app.register_blueprint(notification.web_api, url_prefix="/web")
    app.register_blueprint(lobby.web_api, url_prefix="/web")
