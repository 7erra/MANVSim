import { ActionFunctionArgs, Form, Navigate, redirect, useActionData } from "react-router-dom";
import { Button, Collapse, Form as FormBS } from "react-bootstrap";
import "./login.css"
import { CsrfInput } from "../components/csrf";
import { tryFetchApi } from "../api";
import { isLoggedIn } from "../utils";

export default function Login() {
  const error = useActionData() as string

  if (isLoggedIn()) {
    return <Navigate replace to="/" />
  }

  return (
    <div className="row h-50 justify-content-center align-items-center">
      <div className="col-12 position-at-25">
        <div className="d-flex justify-content-center m-3">
          <h1>MANVSim</h1>
        </div>
        <Form className="login-form m-auto m-3" method="post">
          <CsrfInput />
          <FormBS.Group className="my-3" controlId="formGroupUsername">
            <FormBS.Label>Benutzername</FormBS.Label>
            <FormBS.Control required type="text" placeholder="Benutzername" name="username" autoComplete="username" />
          </FormBS.Group>
          <FormBS.Group controlId="formGroupPassword">
            <FormBS.Label>Passwort</FormBS.Label>
            <FormBS.Control required type="password" placeholder="Passwort" name="password" />
          </FormBS.Group>
          <div className="d-grid gap-2">
            <Button type="submit" className="my-3">Einloggen</Button>
          </div>
          <Collapse in={error !== undefined}>
            <div className="bg-danger p-3 mb-2 rounded-3 text-white">
              {error}
            </div>
          </Collapse>
        </Form>
      </div>
    </div>
  )
}

Login.action = async function ({ request }: ActionFunctionArgs<Request>) {
  const formData = await request.formData()
  const response = await tryFetchApi("login", { method: "POST", body: formData })
  if (response.status === 401) {
    return "Nutzer oder Passwort ist falsch"
  }

  const json = await response.json() as { token: string, username: string }
  if (!("token" in json) || !("username" in json)) {
    throw new Error("Login request returned unknown data")
  }

  localStorage.setItem("token", json.token)
  localStorage.setItem("user", json.username)

  return redirect("/")
}
