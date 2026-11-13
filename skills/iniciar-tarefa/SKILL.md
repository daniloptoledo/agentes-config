---
name: iniciar-tarefa
description: Use no início de qualquer tarefa de código num projeto do Danilo, antes de editar arquivos. Carrega a memória do projeto, confere o estado real e cria a branch.
---

# Iniciar tarefa

1. Ler `AGENTS.md` do projeto, `.ai-memory/HANDOFF.md` e `.ai-memory/KNOWLEDGE_GRAPH.md`
   (ou `docs/PROJECT_STATUS.md`, se for o que o projeto usa).
2. Conferir o estado real:
   - `git status`, `git branch --show-current`, `git log -3 --oneline`
   - `git fetch` e ver se a `main` local está atrás do remoto.
3. Se estiver na `main`: `git switch main && git pull` e `git switch -c <tipo>/<assunto>`.
4. Resumir em 3 linhas: onde paramos, o que a tarefa pede, riscos.
5. Propor o plano em passos pequenos e **esperar o "ok"** do Danilo antes de editar.

**Como verificar:** `git branch --show-current` mostra a branch nova; o resumo bate com o HANDOFF.
