import { Scenario, isScenario } from "../types"
import { tryFetchJson } from "./utils"

export async function getScenarios(): Promise<Scenario[]> {
  const scenarios = await tryFetchJson<Scenario[]>("templates")
  if (Array.isArray(scenarios) && scenarios.every(isScenario)) {
    return scenarios
  }
  throw Error(`Could not load scenarios!`)
}
