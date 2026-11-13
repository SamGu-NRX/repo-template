#!/bin/sh
set -eu
[ -f package.json ] || { echo 'Missing package.json. Restore the bun-ts preset.' >&2; exit 1; }
[ -f bun.lock ] || { echo 'Missing bun.lock. Run bun install and commit bun.lock.' >&2; exit 1; }
bun install --frozen-lockfile || { echo 'Dependency install failed. Run bun install locally and commit the updated bun.lock.' >&2; exit 1; }
bun run typecheck
bun run test
