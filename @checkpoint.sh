#!/usr/bin/env bash
# @checkpoint.sh — 1=1 Dual-Log Execution Checkpoint Recorder
set -euo pipefail
IFS=$'\n\t'

# ─── Constants ─────────────────────────────────────────────────────
CHECKPOINTS_DIR=".checkpoints"
MD_LOG="$CHECKPOINTS_DIR/checkpoints.md"
STRUCTURED_LOG="$CHECKPOINTS_DIR/latest.1eq1"
TIMESTAMP="$(date '+%Y-%m-%dT%H:%M:%S%:z')"

# ─── Helpers ───────────────────────────────────────────────────────
mkdir -p "$CHECKPOINTS_DIR"

# ⛏️ Accept vars via env or prompt
SCRIPT_NAME="${1:-${CHECKPOINT_SCRIPT:-unknown.sh}}"
STATUS="${2:-${CHECKPOINT_STATUS:-unknown}}"
CMD_LOG="${3:-${CHECKPOINT_COMMANDS:-}}"
OUT_LOG="${4:-${CHECKPOINT_OUTPUT:-}}"

# Fallbacks
[[ -z "$CMD_LOG" ]] && CMD_LOG="(none recorded)"
[[ -z "$OUT_LOG" ]] && OUT_LOG="(none recorded)"

# ─── Write Markdown Log ────────────────────────────────────────────
cat >> "$MD_LOG" <<EOF

### 📍 Checkpoint — $TIMESTAMP
**Script**: \`$SCRIPT_NAME\`  
**Status**: \`$STATUS\`  

**Commands**:
\`\`\`sh
$CMD_LOG
\`\`\`

**Output Summary**:
$OUT_LOG
---
EOF

# ─── Write Structured `.1eq1` Log ───────────────────────────────────
cat > "$STRUCTURED_LOG" <<EOF
[checkpoint]
timestamp = $TIMESTAMP
script = $SCRIPT_NAME
status = $STATUS

[commands]
$(
  echo "$CMD_LOG" | awk '{printf "cmd%d = %s\n", NR, $0}'
)

[output]
$(
  echo "$OUT_LOG" | awk '{printf "line%d = %s\n", NR, $0}'
)
EOF

echo "✅ Checkpoint logged to: $STRUCTURED_LOG and $MD_LOG"
