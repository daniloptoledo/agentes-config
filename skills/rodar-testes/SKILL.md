---
name: rodar-testes
description: Use para rodar testes, lint, typecheck ou build em qualquer projeto. Mostra só o resumo ou os trechos de erro, economizando contexto.
---

# Rodar testes

1. Descobrir os comandos do projeto (README, `package.json`, `pyproject.toml`, `pom.xml`).
2. Rodar cada um via:
   `python3 ~/.agentes/scripts/run_quiet.py <comando>`
   Exemplos: `... npm test`, `... pytest`, `... ruff check .`, `... npm run typecheck`
3. `[PASS]` → segue. `[FAIL]` → ler os trechos; log completo em `.ai-memory/last_fail.log`.
4. Nunca "consertar" teste apagando, pulando ou afrouxando assert.
5. Duas tentativas de correção falharam → PARE e use a skill `revisao-codex`.

**Como verificar:** todas as linhas `[PASS]`; reportar os comandos e resultados no relatório.
