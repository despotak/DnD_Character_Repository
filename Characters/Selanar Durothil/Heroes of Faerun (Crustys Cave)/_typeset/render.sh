#!/usr/bin/env bash
# journal.md → journal.html, built off-share: Quarto's project cache is SQLite,
# which cannot take locks on the CIFS mount, and its globs choke on "[D&D]".
set -euo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
stage="$(mktemp -d)"
trap 'rm -rf "$stage"' EXIT

cp -r "$here/_quarto.yml" "$here/_extensions" "$here/_typeset" "$here/journal.md" "$stage/"
(cd "$stage" && quarto render --quiet)
cp "$stage/journal.html" "$here/journal.html"
echo "$here/journal.html"
