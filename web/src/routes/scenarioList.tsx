import { Button } from "react-bootstrap"

import "./scenarioList.css"
import { Scenario } from "../types"
import { getScenarios } from "../api"
import { useLoaderData } from "react-router"
import { useState } from "react"

type ScenarioListItemProps = {
  scenario: Scenario
}

function ScenarioListItem({ scenario }: ScenarioListItemProps) {
  const { name, id, patients } = scenario

  const [checkedState, setChecked] = useState<boolean[]>(
    patients.map(() => true),
  )

  function checkPatient(index: number, isChecked: boolean) {
    setChecked((state) => {
      return state.map((v, i) => (i === index ? isChecked : v))
    })
  }

  return (
    <li className="scenario-list-item">
      <details>
        <summary>
          {name} ({id})
        </summary>
        <form>
          <section className="content">
            <div>
              <h3>Patienten</h3>
              <ul className="patient-list">
                {patients.map(({ name }, i) => {
                  return (
                    <li>
                      <label>
                        <input
                          type="checkbox"
                          checked={checkedState[i]}
                          onChange={() => checkPatient(i, !checkedState[i])}
                        ></input>
                        {name}
                      </label>
                    </li>
                  )
                })}
              </ul>
            </div>
            <div>
              <h3>Locations</h3>
            </div>
          </section>
        </form>
      </details>
    </li>
  )
}

export function ScenarioList() {
  const scenarios = useLoaderData() as Scenario[]

  return (
    <section className="scenario-list">
      <header>
        <h1>Szenarios</h1>
        <div>
          <Button>Erstellen</Button>
        </div>
      </header>
      <ul>
        {scenarios.map((scenario) => {
          return <ScenarioListItem scenario={scenario} />
        })}
      </ul>
    </section>
  )
}

ScenarioList.loader = async function (): Promise<Scenario[]> {
  return getScenarios()
}
