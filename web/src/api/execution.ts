import { ExecutionData } from "../types"
import { tryFetchApi, tryFetchJson } from "./util"

export async function getExecutionStatus(id: string): Promise<ExecutionData> {
  return tryFetchJson<ExecutionData>(`execution?id=${id}`)
}

export async function changeExecutionStatus(
  id: string,
  formData: FormData,
): Promise<Response> {
  return tryFetchApi(`execution?id=${id}`, {
    method: "PATCH",
    body: formData,
  })
}
