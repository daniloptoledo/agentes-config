---
name: revisao-codex
description: Use antes de qualquer commit, ou depois de 2 tentativas de correção falhadas, para pedir uma segunda opinião do Codex sobre o diff atual.
---

# Revisão pelo Codex

Pré-requisito: Codex ligado ao Claude Code via MCP (`claude mcp list` mostra `codex`).

1. Testes e lint passando (skill `rodar-testes`), salvo se o objetivo for investigar uma falha.
2. Chamar a ferramenta do Codex com **sandbox read-only** e este pedido:
   "Revise o `git diff` atual. Liste: bugs, riscos de segurança, casos de borda sem teste e
   código desnecessário. Cite arquivo:linha. Não altere nenhum arquivo."
3. Para cada achado: corrigir, ou registrar por que discorda.
4. Achado de segurança não resolvido → PARE e avise o Danilo.

**Como verificar:** o relatório final lista os achados do Codex e o que foi feito com cada um.
