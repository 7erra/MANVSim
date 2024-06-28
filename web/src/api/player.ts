import { tryFetchApi } from "./util"

export async function togglePlayerStatus(
  executionId: string,
  playerTan: string,
  formData: FormData,
): Promise<Response> {
  return tryFetchApi(
    `execution/player/status?id=${executionId}&tan=${playerTan}`,
    {
      method: "PATCH",
      body: formData,
    },
  )
}
