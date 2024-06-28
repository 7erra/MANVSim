import { isStartResponse, StartResponse } from "../types"
import { tryFetchJson } from "./util"

export async function startScenario(
  formData: FormData,
): Promise<StartResponse> {
  const json = await tryFetchJson<StartResponse>("scenario", {
    method: "POST",
    body: formData,
  })
  if (!isStartResponse(json)) {
    throw new Error("Unexpected response")
  }
  return json
}
