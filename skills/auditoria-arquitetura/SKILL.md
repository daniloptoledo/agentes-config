---
name: auditoria-arquitetura
description: Use quando o Danilo pedir para mapear ou explicar a arquitetura de um projeto (onde roda a lógica, como o login chega ao banco), ou para preparar respostas de entrevista. Somente leitura.
---

# Auditoria de arquitetura (somente leitura)

Nada de editar código, rodar migrations, deploy ou chamar serviços reais.

1. Inventário: estrutura de pastas, `package.json`/`pyproject.toml`, workflows de CI, contagem de testes.
2. Autenticação: quem emite a sessão/JWT e onde ela é validada (`grep -rn "auth/v1\|getUser\|jwt"`).
3. Acesso a dados: o navegador chama banco/API direto? Com que token? Existe RLS?
   Contar nas migrations: `enable row level security`, `create policy`, `security definer`, `revoke`.
4. Regra de negócio: o que roda no navegador, no servidor (API routes / Edge Functions) e no banco
   (funções RPC, triggers). Separar cálculo de exibição de escrita crítica.
5. Integrações e webhooks: como autenticam (assinatura HMAC, segredo, OAuth) e onde ficam os tokens.
6. Escrever `docs/ARQUITETURA.md` com:
   - Diagrama Mermaid (navegador → auth → API → banco → integrações)
   - Os caminhos principais, citando arquivo:linha
   - Tabela "onde fica cada tipo de lógica"
   - Pontos de melhoria (sem implementar)
   - "Resposta curta para entrevista" (5 frases)
7. Não commitar. Entregar o arquivo para revisão.

**Como verificar:** cada afirmação do documento tem um arquivo ou comando que a comprova.
