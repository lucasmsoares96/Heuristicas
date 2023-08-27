# Introdução
Comparação de Heurísticas.

# Dependências

1. Julia

```bash
curl -fsSL https://install.julialang.org | sh
```

# Execução

```bash
git clone https://github.com/lucasmsoares96/Heuristicas.git
cd Heuristicas
julia run.jl -p tsp -a 1 -s 0 Tnm52.tsp
```

Em que:
- --problem, -p
    - tipo de problema
- --algoritmo, -a
    - tipo de heurística
- --seed, -s
    - semente de aleatoriedade

Para mais informações:
```
julia run.jl --help
```