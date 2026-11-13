---
name: encerrar-sessao
description: Use ao terminar uma sessão de trabalho ou antes de trocar de IA, para salvar a memória do projeto e entregar o trabalho para revisão do Danilo.
---

# Encerrar sessão

1. Sobrescrever `.ai-memory/HANDOFF.md` (≤ 15 linhas):
   - Meta ativa · Arquivos tocados · Status dos testes (comando + resultado) · Próximo passo exato.
   (Projetos com `docs/PROJECT_STATUS.md`: atualizar ele no lugar.)
2. Decisão de arquitetura, regra de negócio ou bug difícil resolvido → 1 linha em
   `.ai-memory/KNOWLEDGE_GRAPH.md`: `- [Tema] -> regra/decisão`.
3. README atualizado se mudou como instalar, rodar ou usar.
4. Apagar `.md` temporários (planos, rascunhos) já consolidados.
5. Mostrar resumo, evidências, `git status`, `git diff --stat` e **PARAR**.
   Commit/push só com autorização explícita do Danilo.

**Como verificar:** outra IA consegue continuar lendo só o HANDOFF/STATUS.
