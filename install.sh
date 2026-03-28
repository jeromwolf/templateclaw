#!/usr/bin/env bash
# TemplateClaw Installer
# Usage: curl -fsSL https://jeromwolf.github.io/templateclaw/install.sh | bash

set -euo pipefail

# Colors
if [[ -t 1 ]]; then
  BOLD="\033[1m"
  RESET="\033[0m"
  PURPLE="\033[38;5;141m"
  PINK="\033[38;5;205m"
  GREEN="\033[38;5;114m"
  RED="\033[38;5;203m"
  GRAY="\033[38;5;245m"
  WHITE="\033[38;5;255m"
else
  BOLD="" RESET="" PURPLE="" PINK="" GREEN="" RED="" GRAY="" WHITE=""
fi

CLI_URL="https://jeromwolf.github.io/templateclaw/templateclaw-cli.sh"
INSTALL_DIR="${HOME}/.local/bin"
INSTALL_PATH="${INSTALL_DIR}/templateclaw"

echo ""
echo -e "${PURPLE}${BOLD}  ╔╦╗┌─┐┌┬┐┌─┐┬  ┌─┐┌┬┐┌─┐${PINK}╔═╗┬  ┌─┐┬ ┬${RESET}"
echo -e "${PURPLE}${BOLD}   ║ ├┤ │││├─┘│  ├─┤ │ ├┤ ${PINK}║  │  ├─┤│││${RESET}"
echo -e "${PURPLE}${BOLD}   ╩ └─┘┴ ┴┴  ┴─┘┴ ┴ ┴ └─┘${PINK}╚═╝┴─┘┴ ┴└┴┘${RESET}"
echo -e "  ${GRAY}Installer${RESET}"
echo ""

# Check dependencies
command -v curl &>/dev/null || {
  echo -e "${RED}${BOLD}Error:${RESET} curl is required but not found."
  exit 1
}

command -v python3 &>/dev/null || {
  echo -e "${RED}${BOLD}Error:${RESET} python3 is required for JSON parsing."
  exit 1
}

# Create install directory
if [[ ! -d "$INSTALL_DIR" ]]; then
  echo -e "${PURPLE}>>>${RESET} Creating ${INSTALL_DIR}..."
  mkdir -p "$INSTALL_DIR"
fi

# Download CLI script
echo -e "${PURPLE}>>>${RESET} Downloading TemplateClaw CLI..."
if curl -fsSL --connect-timeout 10 --max-time 30 -o "$INSTALL_PATH" "$CLI_URL" 2>/dev/null; then
  chmod +x "$INSTALL_PATH"
  echo -e "${GREEN}>>>${RESET} Installed to ${INSTALL_PATH}"
else
  echo -e "${RED}${BOLD}Error:${RESET} Failed to download CLI. Check your network connection."
  exit 1
fi

# Check if INSTALL_DIR is in PATH
if [[ ":${PATH}:" != *":${INSTALL_DIR}:"* ]]; then
  echo ""
  echo -e "${PURPLE}>>>${RESET} Adding ${INSTALL_DIR} to PATH..."

  # Detect shell config file
  SHELL_CONFIG=""
  if [[ -n "${ZSH_VERSION:-}" ]] || [[ "$SHELL" == *"zsh"* ]]; then
    SHELL_CONFIG="${HOME}/.zshrc"
  elif [[ -n "${BASH_VERSION:-}" ]] || [[ "$SHELL" == *"bash"* ]]; then
    SHELL_CONFIG="${HOME}/.bashrc"
  fi

  if [[ -n "$SHELL_CONFIG" ]]; then
    EXPORT_LINE='export PATH="${HOME}/.local/bin:${PATH}"'
    if ! grep -qF '.local/bin' "$SHELL_CONFIG" 2>/dev/null; then
      echo "" >> "$SHELL_CONFIG"
      echo "# TemplateClaw" >> "$SHELL_CONFIG"
      echo "$EXPORT_LINE" >> "$SHELL_CONFIG"
      echo -e "${GREEN}>>>${RESET} Added PATH entry to ${SHELL_CONFIG}"
      echo -e "${GRAY}    Run: source ${SHELL_CONFIG}${RESET}"
    else
      echo -e "${GRAY}    ~/.local/bin already in ${SHELL_CONFIG}${RESET}"
    fi
  else
    echo -e "${GRAY}    Add this to your shell config:${RESET}"
    echo -e "${WHITE}    export PATH=\"\${HOME}/.local/bin:\${PATH}\"${RESET}"
  fi
fi

echo ""
echo -e "${GREEN}${BOLD}  Installation complete!${RESET}"
echo ""
echo -e "  ${WHITE}Quick start:${RESET}"
echo -e "    ${GRAY}templateclaw list${RESET}              List all templates"
echo -e "    ${GRAY}templateclaw search landing${RESET}    Search for templates"
echo -e "    ${GRAY}templateclaw get saas-landing${RESET}  Download a template"
echo -e "    ${GRAY}templateclaw help${RESET}              Show all commands"
echo ""
