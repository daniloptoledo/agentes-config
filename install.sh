#!/usr/bin/env bash
# install.sh — instala as regras globais e as skills no seu usuário (rode 1 vez por máquina).
# Usa links simbólicos: depois, basta dar `git pull` neste repositório para atualizar tudo.
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STAMP="$(date +%Y%m%d-%H%M%S)"

link() {  # link <origem> <destino>: faz backup do destino se ele for um arquivo real
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [ -L "$dst" ]; then
    rm "$dst"
  elif [ -e "$dst" ]; then
    mv "$dst" "$dst.backup-$STAMP"
    echo "  backup: $dst -> $dst.backup-$STAMP"
  fi
  ln -s "$src" "$dst"
  echo "  ok: $dst -> $src"
}

echo "1) Pasta ~/.agentes (scripts e skills para qualquer agente)"
link "$REPO" "$HOME/.agentes"

echo "2) Regras globais"
link "$REPO/global/AGENTS.md" "$HOME/.claude/CLAUDE.md"   # Claude Code
link "$REPO/global/AGENTS.md" "$HOME/.codex/AGENTS.md"    # Codex

echo "3) Skills do Claude Code"
for dir in "$REPO"/skills/*/; do
  name="$(basename "$dir")"
  link "$REPO/skills/$name" "$HOME/.claude/skills/$name"
done

echo "4) Travas de permissão do Claude Code (pede confirmação para commit/push/merge/deploy)"
if [ -f "$HOME/.claude/settings.json" ] && [ ! -L "$HOME/.claude/settings.json" ]; then
  cp "$HOME/.claude/settings.json" "$HOME/.claude/settings.json.backup-$STAMP"
  echo "  backup: ~/.claude/settings.json -> settings.json.backup-$STAMP"
fi
python3 "$REPO/scripts/merge_settings.py" "$REPO/global/claude-settings.json" "$HOME/.claude/settings.json"

echo
echo "[OK] Instalado. Para conferir:"
echo "  ls -l ~/.claude/CLAUDE.md ~/.codex/AGENTS.md ~/.claude/skills"
echo "  grep -c 'git commit' ~/.claude/settings.json   # deve mostrar 1"
echo "  python3 ~/.agentes/scripts/run_quiet.py python3 --version"
