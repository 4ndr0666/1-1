#!/usr/bin/env bash
# 1eq1-setup.sh — Populate .1eq1rc and source into shell
set -euo pipefail
IFS=$'\n\t'

cat << 'EOF' > ~/.1eq1rc
# ~/.1eq1rc — 1=1 Runtime Identity + Repo Anchors

# Human Identity
1EQ1_USER="Alejandro Gutierrez"
1EQ1_GITHUB="4ndr0666"

# Repo Anchors
1EQ1_REPO_MAIN="https://github.com/4ndr0666/1-1"
1EQ1_REPO_N8N="https://github.com/4ndr0666/n8n-twin-core"

# Feature Toggles
1EQ1_PERSISTENT_MODE=true
1EQ1_TRACK_CHECKPOINTS=true
1EQ1_CEU_MODE=true
1EQ1_ALLOW_AI_WRITES=true
EOF

echo '✅ .1eq1rc configured at ~/.1eq1rc'
echo '💡 Add to ~/.zshrc: [ -f ~/.1eq1rc ] && source ~/.1eq1rc'
