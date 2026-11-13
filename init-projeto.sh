#!/usr/bin/env bash
# init-projeto.sh — prepara um projeto para trabalhar com os agentes.
# Uso: ./init-projeto.sh /caminho/do/projeto
# Nunca sobrescreve arquivos existentes e não faz commit.
set -euo pipefail

if [ $# -lt 1 ]; then echo "Uso: ./init-projeto.sh /caminho/do/projeto"; exit 1; fi
ALVO="$(cd "$1" && pwd)"
TPL="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/templates/projeto"

copiar() {  # copiar <arquivo relativo>: copia do modelo só se não existir no projeto
  local rel="$1"
  if [ -e "$ALVO/$rel" ]; then
    echo "  mantido (já existe): $rel"
  else
    mkdir -p "$(dirname "$ALVO/$rel")"
    cp "$TPL/$rel" "$ALVO/$rel"
    echo "  criado: $rel"
  fi
}

echo "Projeto: $ALVO"
copiar AGENTS.md
copiar CLAUDE.md
copiar .ai-memory/KNOWLEDGE_GRAPH.md

# Projetos que já usam docs/PROJECT_STATUS.md continuam com ele no papel do HANDOFF.
if [ -e "$ALVO/docs/PROJECT_STATUS.md" ]; then
  echo "  HANDOFF não criado: docs/PROJECT_STATUS.md já faz esse papel"
else
  copiar .ai-memory/HANDOFF.md
fi

# .gitignore: acrescenta só as linhas que faltam
touch "$ALVO/.gitignore"
adicionou=0
while IFS= read -r linha; do
  [ -z "$linha" ] && continue
  case "$linha" in \#*) continue ;; esac
  if ! grep -qxF "$linha" "$ALVO/.gitignore"; then
    if [ $adicionou -eq 0 ]; then printf '\n# agentes (init-projeto.sh)\n' >> "$ALVO/.gitignore"; fi
    echo "$linha" >> "$ALVO/.gitignore"; adicionou=1
    echo "  .gitignore: + $linha"
  fi
done < "$TPL/gitignore-ai.txt"

echo
echo "[OK] Pronto. Próximos passos:"
echo "  1. Se o AGENTS.md foi criado agora, preencha os campos <...>."
echo "  2. Revise com: git -C \"$ALVO\" status"
echo "  3. Commit só depois de revisar (em uma branch, nunca na main)."
