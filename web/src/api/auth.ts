import { redirect } from "react-router"
import { CsrfToken, isCsrfToken, isLoginResponse } from "../types"
import { tryFetchJson } from "./util"

export async function getCsrfToken(): Promise<string> {
  const json = await tryFetchJson<CsrfToken>("csrf")
  if (!isCsrfToken(json)) {
    throw new Error("Fetched json does not contain a CSRF Token!")
  }
  return json.csrf_token
}

export async function getAuthToken(
  formData: FormData,
): Promise<string | Response> {
  const response = await fetch(api + "login", {
    method: "POST",
    body: formData,
  })
  if ([401, 404].includes(response.status)) {
    return "Nutzer oder Passwort ist falsch"
  }

  const json = await response.json()
  if (!isLoginResponse(json)) {
    throw new Error("Login request returned unknown data")
  }

  return redirect("/")
}
