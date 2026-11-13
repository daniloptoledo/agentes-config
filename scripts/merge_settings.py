"""Junta as travas de permissão do kit no ~/.claude/settings.json sem apagar o que já existe."""
import json
import sys
from pathlib import Path

kit, alvo = Path(sys.argv[1]), Path(sys.argv[2])
novo = json.loads(kit.read_text(encoding="utf-8"))
atual = json.loads(alvo.read_text(encoding="utf-8")) if alvo.exists() and alvo.read_text().strip() else {}

perm = atual.setdefault("permissions", {})

# Regras antigas e amplas demais (bloqueavam também o .env.example, que não tem segredo)
OBSOLETAS = {"Read(./.env)", "Read(./.env.*)", "Read(**/.env.*)"}
perm["deny"] = [r for r in perm.get("deny", []) if r not in OBSOLETAS]
for chave in ("ask", "deny"):
    lista = perm.setdefault(chave, [])
    for regra in novo["permissions"].get(chave, []):
        if regra not in lista:
            lista.append(regra)

alvo.parent.mkdir(parents=True, exist_ok=True)
alvo.write_text(json.dumps(atual, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
print(f"  ok: travas aplicadas em {alvo} (ask={len(perm['ask'])}, deny={len(perm['deny'])})")
