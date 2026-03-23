#!/usr/bin/env bash

# setup.sh — One-shot macOS setup orchestrator
#
# Usage:
#   ./setup.sh           Run everything
#   ./setup.sh install    Install packages only
#   ./setup.sh link       Create symlinks only
#   ./setup.sh config     Configure git and runtimes only
#   ./setup.sh macos      Apply macOS settings only

set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
eval "$(brew shellenv)" 2>/dev/null || true

run_step() {
    local label="$1"
    local script="$2"
    echo ""
    echo "=== ${label} ==="
    if ! bash "${DIR}/${script}"; then
        echo "ERROR: ${script} failed. Fix the issue and re-run: ./setup.sh ${3:-}"
        exit 1
    fi
}

case "${1:-all}" in
    install) run_step "Installing packages" "install.sh" "install" ;;
    link)    run_step "Creating symlinks" "link.sh" "link" ;;
    config)  run_step "Configuring git and runtimes" "config.sh" "config" ;;
    macos)   run_step "Applying macOS settings" "macos.sh" "macos" ;;
    all)
        run_step "Installing packages" "install.sh" "install"
        run_step "Creating symlinks" "link.sh" "link"
        run_step "Configuring git and runtimes" "config.sh" "config"
        run_step "Applying macOS settings" "macos.sh" "macos"
        echo ""
        echo "=== All done ==="
        echo "Some changes require a logout or restart to take effect."
        echo "See README.md for manual configuration steps."
        ;;
    *)
        echo "Usage: ./setup.sh [install|link|config|macos]"
        exit 1
        ;;
esac
