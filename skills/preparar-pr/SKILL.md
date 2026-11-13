---
name: preparar-pr
description: Use quando o Danilo autorizar commit e push de uma etapa, para criar commit no padrão Conventional Commits e abrir o Pull Request sem fazer merge.
---

# Preparar PR (só com autorização explícita)

1. Confirmar que a mensagem do Danilo autoriza **nesta etapa**: commit, push e PR.
2. Conferir: não está na `main`; `git diff --stat` só tem arquivos da tarefa; nenhum `.env`,
   segredo, log ou dado real no diff.
3. Testes passando (skill `rodar-testes`).
4. Commit no padrão Conventional Commits: `feat: ...`, `fix: ...`, `docs: ...`, `refactor: ...`, `test: ...`.
5. `git push -u origin <branch>` e abrir PR com: o que mudou, por quê, como testar, evidências.
6. **Nunca dar merge.** Avisar o efeito do merge (ex.: deploy automático, custo de créditos).

**Como verificar:** link do PR no relatório; CI do PR rodando.
