import { z } from "zod"
import { Dispatch, SetStateAction } from "react"

/**
 * Higher order function that returns a function which checks if a given object
 * is of the required type.
 *
 * @template T - The interface that the object should match
 * @param {ReturnType<typeof z.object>} zobj - zod object that contains the attributes
 * @returns {(x: unknown) => x is T} Function that checks the type of a passed object
 */
function isTypeFactory<T>(zobj: ReturnType<typeof z.object>): (x: unknown) => x is T {
  return (x: unknown): x is T => zobj.safeParse(x).success
}

// Template
const template = z.object({
  id: z.number(),
  name: z.string(),
  players: z.number(),
})

export type Template = z.infer<typeof template>

/**
 * Checks if a variable matches the Template interface
 *
 * @param {unknown} x - Variable to check
 * @returns {obj is Template} true when variable is a template
 */
export const isTemplate = isTypeFactory<Template>(template)

// CsrfToken
const csrfToken = z.object({
  csrf_token: z.string()
})

export type CsrfToken = z.infer<typeof csrfToken>

/**
 * Checks if a variable matches the CsrfToken interface
 *
 * @param {unknown} x - Variable to check
 * @returns {obj is CsrfToken} true when variable is a CSRF token
 */
export const isCsrfToken = isTypeFactory<CsrfToken>(csrfToken)

// StartResponse
const startResponse = z.object({
  id: z.number()
})

export type StartResponse = z.infer<typeof startResponse>

/**
 * Checks if a variable matches the StartResponse interface
 *
 * @param {unknown} x - Variable to check
 * @returns {obj is StartResponse} true when variable is a response from the start API call
 */
export const isStartResponse = isTypeFactory<StartResponse>(startResponse)

// LoginResponse
const loginResponse = z.object({
  token: z.string()
})

export type LoginResponse = z.infer<typeof loginResponse>

/**
 * Checks if a variable matches the LoginResponse interface
 *
 * @param {unknown} x - Variable to check
 * @returns {obj is LoginResponse} true when variable is a response from the login API call
 */
export const isLoginResponse = isTypeFactory<LoginResponse>(loginResponse)

// Player
const player = z.object({
  tan: z.string(),
  name: z.string(),
  status: z.string(),
  action: z.string()
})

export type Player = z.infer<typeof player>

const executionData = z.object({
  id: z.number(),
  status: z.string(),
  players: z.array(player)
})

export type ExecutionData = z.infer<typeof executionData>

/**
 * Checks if a variable matches the ExecutionData interface
 *
 * @param {unknown} x - Variable to check
 * @returns {obj is ExecutionData} true when variable matches the ExecutionData interface
 */
export const isExecutionData = isTypeFactory<ExecutionData>(executionData)

// AuthValue
export type Nullable<T> = T | null
export type NullableString = Nullable<string>
export type SetAuthTokenType = Dispatch<SetStateAction<NullableString>>

export interface AuthValue {
  authToken: NullableString
  setAuthToken: SetAuthTokenType
}
