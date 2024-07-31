from apiflask import APIBlueprint, Schema, abort
from flask_jwt_extended import create_access_token
from flask_login import login_user
from apiflask.fields import String
from utils.schemas import CsrfSchema

import models

web_api = APIBlueprint("web_api-login", __name__)


class UserIn(CsrfSchema):
    username = String(required=True)
    password = String(required=True)


class LoginOut(Schema):
    token = String()
    username = String()


@web_api.post("/login")
@web_api.input(UserIn, location="form")
@web_api.output(LoginOut)
def login(form_data):
    username = form_data["username"]
    password = form_data["password"]
    # Get user object from database
    user = models.WebUser.get_by_username(username)
    if user is None:
        abort(401, "User not found")

    # Check password
    if not user.check_password(password):
        abort(401, "Incorrect password")

    login_user(user)
    return {"token": create_access_token(identity="admin"), "username": username}, 200
