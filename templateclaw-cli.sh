#!/usr/bin/env bash
# TemplateClaw CLI - Dependency-free template fetcher
# Usage: templateclaw <command> [options]
# Install: curl -fsSL https://jeromwolf.github.io/templateclaw/install.sh | bash

set -euo pipefail

# ──────────────────────────────────────────────
# Configuration
# ──────────────────────────────────────────────

VERSION="1.0.0"
BASE_URL="https://jeromwolf.github.io/templateclaw"
API_URL="${BASE_URL}/api.json"
TEMPLATE_URL="${BASE_URL}/templates"

# ──────────────────────────────────────────────
# Colors & Formatting
# ──────────────────────────────────────────────

if [[ -t 1 ]]; then
  BOLD="\033[1m"
  DIM="\033[2m"
  RESET="\033[0m"
  PURPLE="\033[38;5;141m"
  PINK="\033[38;5;205m"
  CYAN="\033[38;5;117m"
  GREEN="\033[38;5;114m"
  YELLOW="\033[38;5;221m"
  RED="\033[38;5;203m"
  GRAY="\033[38;5;245m"
  WHITE="\033[38;5;255m"
else
  BOLD="" DIM="" RESET=""
  PURPLE="" PINK="" CYAN="" GREEN="" YELLOW="" RED="" GRAY="" WHITE=""
fi

# ──────────────────────────────────────────────
# Header Art
# ──────────────────────────────────────────────

print_header() {
  echo ""
  echo -e "${PURPLE}${BOLD}  ╔╦╗┌─┐┌┬┐┌─┐┬  ┌─┐┌┬┐┌─┐${PINK}╔═╗┬  ┌─┐┬ ┬${RESET}"
  echo -e "${PURPLE}${BOLD}   ║ ├┤ │││├─┘│  ├─┤ │ ├┤ ${PINK}║  │  ├─┤│││${RESET}"
  echo -e "${PURPLE}${BOLD}   ╩ └─┘┴ ┴┴  ┴─┘┴ ┴ ┴ └─┘${PINK}╚═╝┴─┘┴ ┴└┴┘${RESET}"
  echo -e "  ${DIM}${GRAY}Developer Templates Hub v${VERSION}${RESET}"
  echo ""
}

# ──────────────────────────────────────────────
# Helpers
# ──────────────────────────────────────────────

die() {
  echo -e "${RED}${BOLD}Error:${RESET} $1" >&2
  exit 1
}

info() {
  echo -e "${CYAN}${BOLD}>>>${RESET} $1"
}

success() {
  echo -e "${GREEN}${BOLD}>>>${RESET} $1"
}

warn() {
  echo -e "${YELLOW}${BOLD}>>>${RESET} $1"
}

check_curl() {
  command -v curl &>/dev/null || die "curl is required but not found. Install it and try again."
}

# Fetch API JSON and parse with python3 (fallback to jq)
fetch_api() {
  check_curl
  local json
  json=$(curl -fsSL --connect-timeout 10 --max-time 30 "$API_URL" 2>/dev/null) || \
    die "Failed to fetch catalog from ${API_URL}. Check your network connection."
  echo "$json"
}

# Use python3 for JSON parsing (available on macOS, most Linux)
json_query() {
  local json="$1"
  local query="$2"
  if command -v python3 &>/dev/null; then
    echo "$json" | python3 -c "
import sys, json
data = json.load(sys.stdin)
$query
" 2>/dev/null
  elif command -v jq &>/dev/null; then
    echo "$json" | jq -r "$3" 2>/dev/null
  else
    die "Requires python3 or jq for JSON parsing. Please install one."
  fi
}

# ──────────────────────────────────────────────
# Commands
# ──────────────────────────────────────────────

cmd_list() {
  local category_filter=""
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --category|-c) category_filter="$2"; shift 2 ;;
      *) shift ;;
    esac
  done

  print_header
  info "Fetching template catalog..."
  local json
  json=$(fetch_api)

  echo "$json" | python3 -c "
import sys, json

data = json.load(sys.stdin)
category_filter = '${category_filter}'.lower()
templates = data.get('templates', [])

if category_filter:
    templates = [t for t in templates if t.get('category', '').lower() == category_filter
                 or category_filter in t.get('category', '').lower()]
    if not templates:
        print(f'  No templates found for category: ${category_filter}')
        sys.exit(0)

# Group by category
groups = {}
for t in templates:
    cat = t.get('category', 'other')
    groups.setdefault(cat, []).append(t)

colors = {
    'landing-pages': '\033[38;5;141m',
    'dashboard': '\033[38;5;205m',
    'components': '\033[38;5;117m',
    'dev-methodology': '\033[38;5;221m',
    'project-setup': '\033[38;5;114m',
    'refactoring': '\033[38;5;215m',
}
RESET = '\033[0m'
BOLD = '\033[1m'
DIM = '\033[2m'
WHITE = '\033[38;5;255m'
GRAY = '\033[38;5;245m'

total = len(templates)
print(f'  {BOLD}{WHITE}{total} templates found{RESET}')
print()

for cat in sorted(groups.keys()):
    items = groups[cat]
    color = colors.get(cat, '\033[38;5;245m')
    display = cat.replace('-', ' ').title()
    print(f'  {color}{BOLD}{display}{RESET} ({len(items)})')
    print(f'  {DIM}{"─" * 50}{RESET}')
    for t in items:
        name = t['filename'].replace('.md', '')
        desc = t.get('description', '')[:60]
        diff = t.get('difficulty', '?')
        diff_colors = {'beginner': '\033[38;5;114m', 'intermediate': '\033[38;5;221m', 'advanced': '\033[38;5;203m'}
        dc = diff_colors.get(diff, GRAY)
        print(f'  {WHITE}{name:30s}{RESET} {dc}[{diff}]{RESET}  {GRAY}{desc}{RESET}')
    print()

print(f'  {DIM}Use \"templateclaw get <name>\" to download a template{RESET}')
print()
" 2>/dev/null || die "Failed to parse catalog JSON"
}

cmd_search() {
  local query="${1:-}"
  [[ -z "$query" ]] && die "Usage: templateclaw search <query>"

  print_header
  info "Searching for \"${query}\"..."
  local json
  json=$(fetch_api)

  echo "$json" | python3 -c "
import sys, json

data = json.load(sys.stdin)
query = '${query}'.lower()
templates = data.get('templates', [])

BOLD = '\033[1m'
RESET = '\033[0m'
WHITE = '\033[38;5;255m'
GRAY = '\033[38;5;245m'
GREEN = '\033[38;5;114m'
PURPLE = '\033[38;5;141m'

matches = []
for t in templates:
    searchable = ' '.join([
        t.get('title', ''),
        t.get('description', ''),
        t.get('category', ''),
        ' '.join(t.get('tags', [])),
        t.get('filename', ''),
    ]).lower()
    if query in searchable:
        matches.append(t)

if not matches:
    print(f'  No templates matching \"{query}\"')
    sys.exit(0)

print(f'  {BOLD}{WHITE}{len(matches)} match(es) found{RESET}')
print()

for t in matches:
    name = t['filename'].replace('.md', '')
    cat = t.get('category', 'other').replace('-', ' ').title()
    desc = t.get('description', '')[:70]
    tags = ', '.join(t.get('tags', [])[:4])
    print(f'  {GREEN}{BOLD}{name}{RESET}')
    print(f'    {PURPLE}{cat}{RESET}  {GRAY}{desc}{RESET}')
    if tags:
        print(f'    {GRAY}Tags: {tags}{RESET}')
    print()

print(f'  {GRAY}Use \"templateclaw get <name>\" to download{RESET}')
print()
" 2>/dev/null || die "Failed to search catalog"
}

cmd_get() {
  local name="${1:-}"
  [[ -z "$name" ]] && die "Usage: templateclaw get <template-name>"

  # Append .md if not present
  local filename="${name%.md}.md"

  print_header
  info "Downloading ${filename}..."

  check_curl
  local url="${TEMPLATE_URL}/${filename}"
  local output_file="./${filename}"

  if [[ -f "$output_file" ]]; then
    warn "File ${filename} already exists. Overwrite? [y/N]"
    read -r confirm
    if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
      echo "  Cancelled."
      exit 0
    fi
  fi

  if curl -fsSL --connect-timeout 10 --max-time 30 -o "$output_file" "$url" 2>/dev/null; then
    local size
    size=$(wc -c < "$output_file" | tr -d ' ')
    success "Downloaded ${filename} (${size} bytes)"
    echo -e "  ${GRAY}Saved to: ${output_file}${RESET}"
    echo ""
  else
    rm -f "$output_file"
    die "Template \"${name}\" not found. Use 'templateclaw list' to see available templates."
  fi
}

cmd_info() {
  local name="${1:-}"
  [[ -z "$name" ]] && die "Usage: templateclaw info <template-name>"

  local filename="${name%.md}.md"

  print_header
  info "Fetching info for ${filename}..."
  local json
  json=$(fetch_api)

  echo "$json" | python3 -c "
import sys, json

data = json.load(sys.stdin)
filename = '${filename}'
templates = data.get('templates', [])

BOLD = '\033[1m'
RESET = '\033[0m'
WHITE = '\033[38;5;255m'
GRAY = '\033[38;5;245m'
PURPLE = '\033[38;5;141m'
PINK = '\033[38;5;205m'
CYAN = '\033[38;5;117m'
GREEN = '\033[38;5;114m'
YELLOW = '\033[38;5;221m'
DIM = '\033[2m'

match = None
for t in templates:
    if t.get('filename') == filename:
        match = t
        break

if not match:
    print(f'  Template \"{filename}\" not found.')
    sys.exit(1)

diff_colors = {'beginner': GREEN, 'intermediate': YELLOW, 'advanced': '\033[38;5;203m'}

print(f'  {BOLD}{WHITE}{match[\"title\"]}{RESET}')
print(f'  {DIM}{\"─\" * 50}{RESET}')
print()
print(f'  {PURPLE}Category{RESET}    {match.get(\"category\", \"other\").replace(\"-\", \" \").title()}')
diff = match.get('difficulty', 'intermediate')
dc = diff_colors.get(diff, GRAY)
print(f'  {PURPLE}Difficulty{RESET}  {dc}{diff}{RESET}')
tags = ', '.join(match.get('tags', []))
print(f'  {PURPLE}Tags{RESET}        {tags or \"none\"}')
desc = match.get('description', 'No description')
print(f'  {PURPLE}Description{RESET} {desc}')
url = match.get('download_url', '')
print(f'  {PURPLE}Download{RESET}    {CYAN}{url}{RESET}')
print()
print(f'  {GRAY}Run \"templateclaw get {filename.replace(\".md\", \"\")}\" to download{RESET}')
print()
" 2>/dev/null || die "Failed to fetch template info"
}

cmd_agent_snippet() {
  print_header
  echo -e "  ${BOLD}${WHITE}Agent Integration Snippet${RESET}"
  echo -e "  ${DIM}──────────────────────────────────────────────────${RESET}"
  echo ""
  echo -e "  ${PURPLE}# Python (Claude Code / Agents)${RESET}"
  echo -e "  ${GRAY}import requests${RESET}"
  echo -e "  ${GRAY}catalog = requests.get(\"${API_URL}\").json()${RESET}"
  echo -e "  ${GRAY}for t in catalog[\"templates\"]:${RESET}"
  echo -e "  ${GRAY}    print(t[\"title\"], t[\"download_url\"])${RESET}"
  echo ""
  echo -e "  ${PURPLE}# curl (download a template)${RESET}"
  echo -e "  ${GRAY}curl -fsSL ${TEMPLATE_URL}/saas-landing.md > saas-landing.md${RESET}"
  echo ""
  echo -e "  ${PURPLE}# Claude Code (WebFetch)${RESET}"
  echo -e "  ${GRAY}WebFetch ${API_URL}${RESET}"
  echo -e "  ${GRAY}WebFetch ${TEMPLATE_URL}/admin-dashboard.md${RESET}"
  echo ""
  echo -e "  ${PURPLE}# API Endpoints${RESET}"
  echo -e "  ${CYAN}Catalog (light):${RESET}  ${API_URL}"
  echo -e "  ${CYAN}Catalog (full):${RESET}   ${BASE_URL}/api-full.json"
  echo -e "  ${CYAN}Template file:${RESET}    ${TEMPLATE_URL}/{filename}.md"
  echo -e "  ${CYAN}Site:${RESET}             ${BASE_URL}"
  echo ""
}

cmd_help() {
  print_header
  echo -e "  ${BOLD}${WHITE}Commands${RESET}"
  echo -e "  ${DIM}──────────────────────────────────────────────────${RESET}"
  echo ""
  echo -e "  ${GREEN}list${RESET} ${GRAY}[--category <cat>]${RESET}    List all templates (optionally filter by category)"
  echo -e "  ${GREEN}search${RESET} ${GRAY}<query>${RESET}             Search templates by keyword"
  echo -e "  ${GREEN}get${RESET} ${GRAY}<name>${RESET}                 Download a template to current directory"
  echo -e "  ${GREEN}info${RESET} ${GRAY}<name>${RESET}                Show template details"
  echo -e "  ${GREEN}agent-snippet${RESET}                Show agent integration code"
  echo -e "  ${GREEN}help${RESET}                         Show this help message"
  echo -e "  ${GREEN}version${RESET}                      Show version"
  echo ""
  echo -e "  ${BOLD}${WHITE}Examples${RESET}"
  echo -e "  ${DIM}──────────────────────────────────────────────────${RESET}"
  echo ""
  echo -e "  ${GRAY}templateclaw list${RESET}"
  echo -e "  ${GRAY}templateclaw list --category dashboard${RESET}"
  echo -e "  ${GRAY}templateclaw search \"landing page\"${RESET}"
  echo -e "  ${GRAY}templateclaw get saas-landing${RESET}"
  echo -e "  ${GRAY}templateclaw info admin-dashboard${RESET}"
  echo ""
  echo -e "  ${BOLD}${WHITE}Install${RESET}"
  echo -e "  ${DIM}──────────────────────────────────────────────────${RESET}"
  echo ""
  echo -e "  ${GRAY}curl -fsSL https://jeromwolf.github.io/templateclaw/install.sh | bash${RESET}"
  echo ""
}

cmd_version() {
  echo -e "${PURPLE}${BOLD}TemplateClaw${RESET} v${VERSION}"
}

# ──────────────────────────────────────────────
# Main Dispatcher
# ──────────────────────────────────────────────

main() {
  local cmd="${1:-help}"
  shift 2>/dev/null || true

  case "$cmd" in
    list)           cmd_list "$@" ;;
    search)         cmd_search "$@" ;;
    get|download)   cmd_get "$@" ;;
    info)           cmd_info "$@" ;;
    agent-snippet)  cmd_agent_snippet ;;
    help|--help|-h) cmd_help ;;
    version|--version|-v) cmd_version ;;
    *)
      die "Unknown command: ${cmd}. Run 'templateclaw help' for usage."
      ;;
  esac
}

main "$@"
