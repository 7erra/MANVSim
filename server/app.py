import logging
import os
import secrets

from flask import send_from_directory, redirect
from apiflask import APIFlask
from flask_cors import CORS
from flask_jwt_extended import JWTManager
from flask_sqlalchemy import SQLAlchemy
from flask_wtf.csrf import CSRFProtect

from vars import LOG_LEVEL

logging.basicConfig(format="%(levelname)s:%(message)s", level=LOG_LEVEL)


def create_app(csrf: CSRFProtect, db: SQLAlchemy):
    """
    Create the app instance, register all URLs and the database to the app
    """
    # asynchronously import local packages
    import models  # noqa: F401
    import execution.web_api.setup
    import scenario.web_api.setup
    import administration.web_api.setup
    import execution.api.setup
    import media.media_api

    app = APIFlask(__name__, static_folder="../web/dist")
    app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///db.sqlite3"
    app.config["SECRET_KEY"] = secrets.token_urlsafe(32)
    app.config["JWT_SECRET_KEY"] = secrets.token_urlsafe(32)

    db.init_app(app)
    csrf.init_app(app)
    JWTManager(app)

    # -- Endpoint connection
    execution.web_api.setup.setup(app)
    scenario.web_api.setup.setup(app)
    administration.web_api.setup.setup(app)
    execution.api.setup.setup(app)
    media.media_api.setup(app)

    CORS(app, resources={r"/*": {"origins": "*"}})

    # -- FE Routes
    @app.route("/", defaults={"path": ""})
    @app.route("/<path:path>")
    def serve(path):
        """Registers paths required for serving frontend."""
        if not app.static_folder:
            app.static_folder = ""

        if path != "" and os.path.exists(app.static_folder + "/" + path):
            return send_from_directory(app.static_folder, path)
        elif path == "/" or path == "":
            return send_from_directory(app.static_folder, "index.html")
        elif path.startswith("/api"):
            return (
                "API Endpoint not found. Please refactor your request or "
                "contact the admin",
                404,
            )
        elif path.startswith("web/"):
            return {"error": "Unknown endpoint"}, 404
        else:
            return redirect("/")

    return app
