"""Roda um comando (pytest, ruff, docker...) e mostra só o essencial.

Uso:  python3 scripts/run_quiet.py pytest
      python3 scripts/run_quiet.py ruff check .

- Passou (exit 0): imprime 1 linha com [PASS], o tempo e a última linha da saída.
- Falhou: imprime [FAIL] e só os trechos ao redor das linhas de erro (máx. 80 linhas).
  O log completo fica em .ai-memory/last_fail.log (ignorado pelo Git).

Motivo: economizar a janela de contexto do agente de IA, que não precisa ler
centenas de linhas de log quando tudo passou.
"""
from __future__ import annotations

import re
import subprocess
import sys
import time
from pathlib import Path

ERRO = re.compile(
    r"error|exception|traceback|failed|failure|fatal|assert|E\s{3}",
    re.IGNORECASE,
)
MAX_LINHAS = 80
LOG = Path(".ai-memory/last_fail.log")


def trechos_de_erro(linhas: list[str]) -> list[int]:
    """Índices das linhas de erro, com 2 linhas antes e 5 depois de cada uma."""
    manter: set[int] = set()
    for i, linha in enumerate(linhas):
        if ERRO.search(linha):
            manter.update(range(max(0, i - 2), min(len(linhas), i + 6)))
    if not manter:  # nenhum padrão encontrado: mostra o fim da saída
        manter.update(range(max(0, len(linhas) - 40), len(linhas)))
    return sorted(manter)[:MAX_LINHAS]


def main(argv: list[str]) -> int:
    if not argv:
        print(__doc__)
        return 2

    inicio = time.perf_counter()
    try:
        proc = subprocess.run(
            argv, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
            text=True, errors="replace",
        )
    except FileNotFoundError:
        print(f"[FAIL] comando não encontrado: {argv[0]}")
        return 127
    tempo = time.perf_counter() - inicio
    linhas = (proc.stdout or "").splitlines()

    if proc.returncode == 0:
        ultima = linhas[-1].strip() if linhas else "OK"
        print(f"[PASS] {tempo:.1f}s | {len(linhas)} linhas omitidas | {ultima}")
        return 0

    LOG.parent.mkdir(exist_ok=True)
    LOG.write_text(proc.stdout or "", encoding="utf-8")
    print(f"[FAIL] exit {proc.returncode} | {tempo:.1f}s | log completo: {LOG}")
    anterior = -2
    for i in trechos_de_erro(linhas):
        if i > anterior + 1:
            print("...")
        print(f"{i + 1:4d}: {linhas[i]}")
        anterior = i
    return proc.returncode


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
