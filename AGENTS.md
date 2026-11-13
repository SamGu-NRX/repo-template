# Working here

## Check

Run `./check` before you report. Include the result and any checks you could not run.

## Verify

Create `verify-<app>` with pstack's `/pstack:create-verification-skill` and keep it in `.agents/skills/`.
Fill in the real app's launch command, the changed user flow, and the visible result that proves it works.
This template has no app. Verify its gate and adoption commands in a scratch copy.

## Mistakes become rules

When a correction repeats, make it impossible through the structure first, then the types,
then an ast-grep rule whose message names the fix, then a test. Write docs last.
Use pstack's `/pstack:correct`. Each rule's test must include the real past mistake as an `invalid` case.
The starter cases below are examples; replace or extend them with observed mistakes.

| Mistake | Enforcer | Test |
| --- | --- | --- |
| Hiding a failure in an empty catch | `lint/rules/no-empty-catch.yml` | `lint/rule-tests/no-empty-catch.yml` |
| Turning off a value's type checking | `lint/rules/no-as-any.yml` | `lint/rule-tests/no-as-any.yml` |

## Formal verification

None for v1. This template has no application state machine. Pick one consequential invariant when the app exists and explain why it needs model checking or property tests.

## Skill families

No app stack is active in the template. After initialization, use `typescript-best-practices` for the TypeScript files justified by `package.json` and `tsconfig.json`. Add other families only when the repo uses them.

## Pull requests

Follow the `pr-writing` skill and `.github/pull_request_template.md`. Merges are Sam's.
