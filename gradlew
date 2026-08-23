#!/usr/bin/env bash
set -euo pipefail

GRADLE_VERSION="8.11.1"
DIST_DIR="${HOME}/.elevate-gradle/${GRADLE_VERSION}"
GRADLE_BIN="${DIST_DIR}/gradle-${GRADLE_VERSION}/bin/gradle"
ZIP_PATH="${DIST_DIR}/gradle-${GRADLE_VERSION}-bin.zip"

if [ ! -x "${GRADLE_BIN}" ]; then
  mkdir -p "${DIST_DIR}"
  if [ ! -f "${ZIP_PATH}" ]; then
    echo "Downloading Gradle ${GRADLE_VERSION}..."
    curl -L --fail --retry 3 \
      "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" \
      -o "${ZIP_PATH}"
  fi
  unzip -q -o "${ZIP_PATH}" -d "${DIST_DIR}"
fi

exec "${GRADLE_BIN}" "$@"
