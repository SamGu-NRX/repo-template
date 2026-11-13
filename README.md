# Repo template

A private GitHub template with one local and CI gate, tested ast-grep rules,
PR metadata, and an optional Bun TypeScript preset. Bun must be on PATH.
CI uses Bun 1.4.4; use that version locally for matching runtime behavior.

## Start a repo

```sh
gh repo create <name> --template SamGu-NRX/repo-template --private --clone
cd <name>
./baseline init bun-ts
./check
```

Commit the generated `.baseline/stack`, package files, lockfile, stack check,
and sample source and test. Replace the sample with the app's code and tests.
Without `.baseline/stack`, `./check` tests the lint rules and scans TypeScript only.
It does not typecheck or run the inactive preset's tests.

## Adopt into an existing repo

From this template's clone:

```sh
./baseline adopt /absolute/path/to/existing-repo
```

`baseline.json` lists the managed files. Adoption copies missing files and lists
all skips, including paths blocked by symlinks. Existing files stay untouched.
Review and merge skipped files yourself. In the target, run `./baseline init bun-ts`
only if it has no stack files yet. Otherwise merge the preset's scripts and strict
TypeScript settings, install its dev dependencies, copy `check.d/bun-ts.sh`, and
write `bun-ts` to `.baseline/stack`. Run `bun install` and commit `bun.lock`.
Run `./check` before pushing.

## Reuse the check workflow

Copy `templates/caller-check.yml` to `.github/workflows/check.yml` in a product
repo after adopting the baseline. It calls:

```yaml
uses: SamGu-NRX/repo-template/.github/workflows/check.yml@v1
with:
  stack: bun-ts
```

The workflow checks out the caller's repository and runs its `./check`. The stack
input verifies `.baseline/stack`; it never initializes or changes the caller.
Private callers owned by Sam can use this template's workflows because its Actions
access level is `user`. The caller still needs the managed files committed locally.
There is no automatic baseline synchronization in v1.

## Default branch rules

After observing the target's hosted check name, apply the proposed ruleset manually:

```sh
gh api --method POST repos/OWNER/REPO/rulesets \
  --input rulesets/default-branch.json
```

This requires squash merges, one approval after the latest push by someone other
than the pusher, resolved review threads, and an up-to-date passing `check`.
A reused workflow can expose a nested check name such as `check / check`; inspect
its actual name and update the JSON before applying it. GitHub plan support is
required for rulesets on private repos. The template does not apply this ruleset.
Merges are Sam's.

## Extend it

Add a stack under `presets/` and its gate under `check.d/` when it is supported.
`baseline init` currently accepts only `bun-ts`. Keep new managed paths in
`baseline.json`. For an app, create `verify-<app>` with pstack's
`/pstack:create-verification-skill` in `.agents/skills/` and fill in `AGENTS.md`.

Swift and Python presets and a sync workflow are outside v1.
