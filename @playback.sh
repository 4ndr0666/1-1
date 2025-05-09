#!/usr/bin/env bash
# @playback.sh — 1=1 Execution Log Rehydration Tool
set -euo pipefail
IFS=$'\n\t'

# ─── Load Runtime Config ────────────────────────────────────────────────────────
CONFIG_FILE=".1eq1rc"

[[ ! -f "$CONFIG_FILE" ]] && {
  echo "❌ Missing .1eq1rc config. Aborting."
  exit 1
}

source <(grep -v '^#' "$CONFIG_FILE" | sed 's/ *= */=/' | sed 's/\[.*\]//g' | awk NF)

# ─── Locate Execution Logs ──────────────────────────────────────────────────────
LOG_FILES=$(find . -maxdepth 2 -type f \( -name "*.log" -o -name "*results.md" -o -name "*.1eq1" \))

if [[ -z "$LOG_FILES" ]]; then
  echo "❌ No logs found for playback."
  exit 2
fi

# ─── Extract Executed Commands ──────────────────────────────────────────────────
echo "▶ Rehydrating execution context from logs..."
COMMANDS=$(grep -hE '^\s*(sudo\s+)?(git|gh|curl|wget|chmod|bash|mkdir|cp|mv|npx|npm|pnpm|pacman|make|python3?)' $LOG_FILES | sed 's/^[[:space:]]*//')

# ─── Display Rehydrated Playback Script ─────────────────────────────────────────
echo -e "\n📜 Reconstructed Execution Log:"
echo "$COMMANDS"

# ─── Optional Execution Prompt ──────────────────────────────────────────────────
echo -e "\n🚨 This is a dry-run. To actually replay the commands:"
echo '   echo "$COMMANDS" | bash'

# Optional: write to tmp replay script
TMP_SCRIPT="/tmp/1eq1-playback-rehydrated.sh"
echo "$COMMANDS" > "$TMP_SCRIPT"
chmod +x "$TMP_SCRIPT"
echo "🧠 Written rehydration script to $TMP_SCRIPT"
