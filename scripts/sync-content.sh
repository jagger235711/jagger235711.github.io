#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOCS_DIR="${ROOT_DIR}/docs"

cd "${ROOT_DIR}"

if [ ! -f "${ROOT_DIR}/.gitmodules" ]; then
  echo "No .gitmodules found. Please configure docs as a submodule first."
  exit 1
fi

if [ "$(git ls-files --stage -- docs | awk '{print $1}')" = "160000" ]; then
  git submodule sync -- docs
  git submodule update --init --remote --recursive -- docs
  echo "docs submodule synced."
  exit 0
fi

if [ -d "${DOCS_DIR}/.git" ] || [ -f "${DOCS_DIR}/.git" ]; then
  git -C "${DOCS_DIR}" pull --ff-only
  echo "docs repository updated."
  exit 0
fi

echo "docs is not initialized as a repository/submodule yet."
echo "Run: git submodule update --init --recursive docs"
exit 1
