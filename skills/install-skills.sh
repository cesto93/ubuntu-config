#!/usr/bin/env bash
set -euo pipefail

# Install skills using the `skills` CLI (npx skills add).
# Usage: ./install-skills.sh [path-to-yaml]
#
# Reads a YAML list of skill sources (one `- <source>` per line) and installs
# each via `npx skills add`. Defaults to skills-to-install.yaml next to this script.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_LIST="${1:-${SCRIPT_DIR}/skills-to-install.yaml}"

if [ ! -f "${SKILLS_LIST}" ]; then
  echo "ERROR: skill list not found: ${SKILLS_LIST}" >&2
  exit 1
fi

# Extract list items (`- value`) from the YAML, stripping the leading "- ".
mapfile -t SKILLS_TO_ADD < <(grep -E '^\s*-\s+' "${SKILLS_LIST}" | sed -E 's/^\s*-\s+//')

if [ "${#SKILLS_TO_ADD[@]}" -eq 0 ]; then
  echo "ERROR: no skills listed in ${SKILLS_LIST}" >&2
  exit 1
fi

for src in "${SKILLS_TO_ADD[@]}"; do
  echo "==> Installing: ${src}"
  # shellcheck disable=SC2086
  npx --yes skills add ${src} --yes --global --agent opencode
done

echo "==> Done."
