---
name: revisao-codex
description: Use antes de qualquer commit, ou depois de 2 tentativas de correção falhadas, para pedir uma segunda opinião do Codex sobre o diff atual.
---

# Revisão pelo Codex

Pré-requisito: plugin oficial `openai/codex-plugin-cc` instalado (`/codex:setup` mostra `ready: true`).
A revisão obrigatória automática (`--enable-review-gate`) fica DESLIGADA: revisar sob demanda economiza cota.

1. Testes e lint passando (skill `rodar-testes`), salvo se o objetivo for investigar uma falha.
2. Pedir ao Danilo que rode `/codex:review` (revisa as mudanças não commitadas) — ou, se ele
   autorizar, rodar o comando. Foco pedido: bugs, riscos de segurança, casos de borda sem teste,
   código desnecessário, citando arquivo:linha. O Codex não deve alterar arquivos.
3. Para cada achado: corrigir, ou registrar por que discorda.
4. Achado de segurança não resolvido → PARE e avise o Danilo.

**Como verificar:** o relatório final lista os achados do Codex e o que foi feito com cada um.
