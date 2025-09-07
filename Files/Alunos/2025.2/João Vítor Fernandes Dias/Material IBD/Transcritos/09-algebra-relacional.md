# Álgebra Relacional

- Universidade Federal de Minas Gerais
- Introdução a Banco de Dados
- Rodrygo L. T. Santos
- <rodrygo@dcc.ufmg.br>

## Linguagens de consulta

- Permitem manipulação e recuperação de dados
  - Propósito específico (vs. linguagens de programação)
  - Suportam acesso fácil e eficiente a dados
- O modelo relacional suporta linguagens poderosas
  - Forte fundamentação teórica baseada em lógica
  - Permitem otimizações

---

- Duas linguagens matemáticas formam a base para implementações de linguagens de consulta (e.g., SQL)
  - **Álgebra relacional:** predominantemente imperativa, útil para representar planos de execução
  - **Cálculo relacional:** predominantemente declarativa, permite descrever o que recuperar (em vez de como)

### Álgebra vs. Cálculo relacional

- Álgebra
  - > Retorne nome e telefone de livrarias que vendem o livro X
  - Junte as relações livraria e livro pelo identificador da livraria
  - Selecione da junção tuplas correspondentes ao livro X
  - Projete o resultado da seleção para manter somente os atributos nome e telefone da livraria

---

- Cálculo relacional
  - > Retorne nome e telefone de livrarias que vendem o livro X
  - Obtenha o nome e telefone
  - De livrarias
  - Para as quais exista um livro cujo identificador remeta à livraria e cujo título seja X

## Álgebra relacional

- **Operações unárias**
  - Seleção ($\sigma$)
  - Projeção ($\pi$)
  - Renomeação ($\rho$)
- **Operações binárias**
  - Aditivas
    - União ($\cup$)
    - Interseção ($\cap$)
    - Diferença ($-$)
  - Multiplicativas
    - Produto cartesiano ($\times$)
    - Junção ($\bowtie$)
    - Divisão ($\div$)

### Operações Unárias

#### Seleção ($\sigma$)

- Recupera as tuplas de uma relação $R$ que satisfazem uma determinada condição lógica [$cond$]
  - Notação: $\sigma_{[cond]}(R)$
- Exemplo:
  - $\sigma_{(Dept = 28 \wedge Salário > 600) \lor (Dept = 21)}(Empregado)$

---

- $\sigma_{(Dept = 28 \wedge Salário > 600) \lor (Dept = 21)}(Empregado)$

**Tabela:** Empregado

| **ID** | **Nome** | **Salário** | **Dept** | ✗/✓ |
| :----: | :------: | :---------: | :------: | :-: |
|  032   | J Silva  |     380     |    21    |  ✗  |
|  074   |  M Reis  |     400     |    25    |  ✓  |
|  089   |  C Melo  |     520     |    28    |  ✓  |
|  092   | R Silva  |     480     |    25    |  ✓  |
|  112   | R Pinto  |     390     |    21    |  ✗  |
|  121   | V Simão  |     905     |    28    |  ✗  |

---

- $\sigma_{(Dept = 28 \wedge Salário > 600) \lor (Dept = 21)}(Empregado)$

**Tabela:** Empregado

| **ID** | **Nome** | **Salário** | **Dept** | ✗/✓ |
| :----: | :------: | :---------: | :------: | :-: |
|  032   | J Silva  |     380     |    21    |  ✓  |
|  112   | R Pinto  |     390     |    21    |  ✓  |
|  121   | V Simão  |     905     |    28    |  ✓  |

#### Projeção ($\pi$)

- Projeta as tuplas de uma relação $R$ sobre um determinado conjunto de atributos [$atrib$]
  - Notação: $\pi_{[atrib]}(R)$
- Exemplos:
  - $\pi_{Nome, Salário}(Empregado)$
  - $\pi_{Dept}(Empregado)$

---

- $\pi_{Nome, Salário}(Empregado)$

**Tabela:** Empregado

| ID ✗ | Nome ✓  | Salário ✓ | Dept ✗ |
| :--: | :-----: | :-------: | :----: |
| 032  | J Silva |    380    |   21   |
| 074  | M Reis  |    400    |   25   |
| 089  | C Melo  |    520    |   28   |
| 092  | R Silva |    480    |   25   |
| 112  | R Pinto |    390    |   21   |
| 121  | V Simão |    905    |   28   |

---

**Tabela:** Empregado

| Nome ✓  | Salário ✓ |
| :-----: | :-------: |
| J Silva |    380    |
| M Reis  |    400    |
| C Melo  |    520    |
| R Silva |    480    |
| R Pinto |    390    |
| V Simão |    905    |

---

- $\pi_{Dept}(Empregado)$

**Tabela:** Empregado

| ID ✗ | Nome ✗  | Salário ✗ | Dept ✓ |
| :--: | :-----: | :-------: | :----: |
| 032  | J Silva |    380    |   21   |
| 074  | M Reis  |    400    |   25   |
| 089  | C Melo  |    520    |   28   |
| 092  | R Silva |    480    |   25   |
| 112  | R Pinto |    390    |   21   |
| 121  | V Simão |    905    |   28   |

---

- $\pi_{Dept}(Empregado)$

**Tabela:** Empregado

| Dept ✓ |
| :----: |
|   21   |
|   25   |
|   28   |
| **25** |
| **21** |
| **28** |

> Modelo relacional não permite tuplas duplicadas

---

- $\pi_{Dept}(Empregado)$

**Tabela:** Empregado

| Dept ✓ |
| :----: |
|   21   |
|   25   |
|   28   |

#### Renomeação ($\rho$)

- Cria um novo esquema $S(A_1, \dots, A_n)$ para a relação $R$
  - Notação 1: $\rho_{S(A_1, \dots, A_n)}(R)$
  - Notação 2: $S(A_1, \dots, A_n) \gets R$
- Exemplo:
  - $\rho_{Funcionário(ID, Nome, Renda, Dept)}(Empregado)$

---

- $\rho_{Funcionário(ID, Nome, Renda, Dept)}(Empregado)$

**Tabela:** _Empregado_

| **ID** | **Nome** | **Salário** | **Dept** |
| :----: | :------: | :---------: | :------: |
|  032   | J Silva  |     380     |    21    |
|  074   |  M Reis  |     400     |    25    |
|  089   |  C Melo  |     520     |    28    |
|  092   | R Silva  |     480     |    25    |
|  112   | R Pinto  |     390     |    21    |
|  121   | V Simão  |     905     |    28    |

---

**Tabela:** ~~Empregado~~ **Funcionário**

| **ID** | **Nome** | **Salário** | **Dept** |
| :----: | :------: | :---------: | :------: |
|  032   | J Silva  |     380     |    21    |
|  074   |  M Reis  |     400     |    25    |
|  089   |  C Melo  |     520     |    28    |
|  092   | R Silva  |     480     |    25    |
|  112   | R Pinto  |     390     |    21    |
|  121   | V Simão  |     905     |    28    |

### Sequência de operações

- Várias operações podem ser combinadas para formar uma expressão da álgebra relacional
  - $\pi_{Nome, Salário}(\sigma_{Dept = 21} Empregado)$
- Considerações importantes
  - A ordem das operações importa
  - Relações temporárias podem ser úteis

### Ordenação de operações

✗✓

- Nem todas as ordenações são factíveis
  - $\pi_{Nome, Salário}(\sigma_{Dept = 21}(Empregado))$ ✓
  - $\sigma_{Dept = 21}(\pi_{Nome, Salária}(Empregado))$ ✗
- Certas ordenações promovem eficiência
  - Otimização via seleção e projeção precoces (menos dados trafegam para a operação seguinte)

### Relações temporárias

- Certas consultas podem ser complexas
  - $S \gets \pi_{Nome, Salário}(\sigma_{Dept = 21}(Empregado))$
- Relações temporárias facilitam a abstração
  - $T \gets \sigma_{Dept = 21}(Empregado)$
  - $S \gets \pi_{Nome, Salário}(T)$

## Operações Aditivas

### Compatibilidade de tipos

- Dois esquemas $R(A_1, A_2, \dots, A_n)$ e $S(B_1, B_2, \dots, B_n)$ são compatíveis para operações aditivas se
  - $grau(R) = grau(S)$ e
  - $dom(A_i) = dom(B_i) \forall i$
- **Observação:** a correspondência de nomes de atributos não é necessária, apenas a de seus domínios

### União ($\cup$)

- Dadas duas relações compatíveis $R$ e $S$, retorna tuplas contidas em ao menos uma das duas relações

$R \cup S$

[Imagem: Diagrama de Venn mostrando a união de dois conjuntos R e S]

---

Secretário $\cup$ Engenheiro

**Tabela:** Secretário

| **ID**  |  **Nome**  | **Salário** | **Dept** |
| :-----: | :--------: | :---------: | :------: |
|   032   |  J Silva   |     380     |    21    |
|   074   |   M Reis   |     400     |    25    |
| **089** | **C Melo** |   **520**   |  **28**  |

**Tabela:** Engenheiro

| **ID**  |  **Nome**  | **Salário** | **Dept** |
| :-----: | :--------: | :---------: | :------: |
| **089** | **C Melo** |   **520**   |  **28**  |
|   092   |  R Silva   |     480     |    25    |
|   112   |  R Pinto   |     390     |    21    |

> Modelo relacional não permite tuplas duplicadas

---

Secretário $\cup$ Engenheiro

**Tabela:** Secretário $\cup$ Engenheiro

| **ID** | **Nome** | **Salário** | **Dept** |
| :----: | :------: | :---------: | :------: |
|  032   | J Silva  |     380     |    21    |
|  074   |  M Reis  |     400     |    25    |
|  089   |  C Melo  |     520     |    28    |
|  092   | R Silva  |     480     |    25    |
|  112   | R Pinto  |     390     |    21    |

### Interseção ($\cap$)

- Dadas duas relações compatíveis $R$ e $S$, retorna tuplas contidas em ambas as relações

$R \cap S$

[Imagem: Diagrama de Venn mostrando a interseção de dois conjuntos R e S]

---

Secretário $\cap$ Engenheiro

**Tabela:** Secretário

| **ID** | **Nome** | **Salário** | **Dept** |
| :----: | :------: | :---------: | :------: |
|  032   | J Silva  |     380     |    21    |
|  074   |  M Reis  |     400     |    25    |
|  089   |  C Melo  |     520     |    28    |

**Tabela:** Engenheiro

| **ID** | **Nome** | **Salário** | **Dept** |
| :----: | :------: | :---------: | :------: |
|  089   |  C Melo  |     520     |    28    |
|  092   | R Silva  |     480     |    25    |
|  112   | R Pinto  |     390     |    21    |

---

Secretário $\cap$ Engenheiro

**Tabela:** Secretário $\cap$ Engenheiro

| **ID** | **Nome** | **Salário** | **Dept** |
| :----: | :------: | :---------: | :------: |
|  089   |  C Melo  |     520     |    28    |

### Diferença ($-$)

- Dadas duas relações compatíveis $R$ e $S$, retorna tuplas contidas em $R$ mas não em $S$

$R - S$

[Imagem: Diagrama de Venn mostrando a diferença entre dois conjuntos $R$ e $S$ ($R$ menos $S$)]

---

Secretário $-$ Engenheiro

**Tabela:** Secretário

| **ID** | **Nome** | **Salário** | **Dept** |
| :----: | :------: | :---------: | :------: |
|  032   | J Silva  |     380     |    21    |
|  074   |  M Reis  |     400     |    25    |
|  089   |  C Melo  |     520     |    28    |

**Tabela:** Engenheiro

| **ID** | **Nome** | **Salário** | **Dept** |
| :----: | :------: | :---------: | :------: |
|  089   |  C Melo  |     520     |    28    |
|  092   | R Silva  |     480     |    25    |
|  112   | R Pinto  |     390     |    21    |

---

Secretário $-$ Engenheiro

**Tabela:** Secretário $-$ Engenheiro

| **ID** | **Nome** | **Salário** | **Dept** |
| :----: | :------: | :---------: | :------: |
|  032   | J Silva  |     380     |    21    |
|  074   |  M Reis  |     400     |    25    |

---

Engenheiro $-$ Secretário

**Tabela:** Secretário

| **ID** | **Nome** | **Salário** | **Dept** |
| :----: | :------: | :---------: | :------: |
|  032   | J Silva  |     380     |    21    |
|  074   |  M Reis  |     400     |    25    |
|  089   |  C Melo  |     520     |    28    |

**Tabela:** Engenheiro

| **ID** | **Nome** | **Salário** | **Dept** |
| :----: | :------: | :---------: | :------: |
|  089   |  C Melo  |     520     |    28    |
|  092   | R Silva  |     480     |    25    |
|  112   | R Pinto  |     390     |    21    |

---

Engenheiro $-$ Secretário

| **ID** | **Nome** | **Salário** | **Dept** |
| :----: | :------: | :---------: | :------: |
|  092   | R Silva  |     480     |    25    |
|  112   | R Pinto  |     390     |    21    |

## Operações Multiplicativas

### Álgebra relacional (2)

- Operações unárias
  - Seleção ($\sigma$)
  - Projeção ($\pi$)
  - Renomeação ($\rho$)
- Operações binárias
  - Aditivas
    - União ($\cup$)
    - Interseção ($\cap$)
    - Diferença ($-$)
  - Multiplicativas
    - Prod. cartesiano ($\times$)
    - Junção ($\bowtie$)
    - Divisão ($\div$)

### Operações aditivas vs. multiplicativas

|     |     |     |     |
| :-: | :-: | :-: | :-: |
|     |     |     |     |
|     |     |     |     |
|     |     |     |     |

|     |     |     |     |
| :-: | :-: | :-: | :-: |
|     |     |     |     |
|     |     |     |     |
|     |     |     |     |

---

|     |     |     |     |
| :-: | :-: | :-: | :-: |
|     |     |     |     |
|     |     |     |     |
|     |     |     |     |
|     |     |     |     |
|     |     |     |     |
|     |     |     |     |

- **Operações aditivas**
  - União ($\cup$)
  - Interseção ($\cap$)
  - Diferença ($-$)
- **Esquema preservado!**

---

|     |     |     |     |     |     |     |     |
| :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
|     |     |     |     |     |     |     |     |
|     |     |     |     |     |     |     |     |
|     |     |     |     |     |     |     |     |

- **Operações multiplicativas**
  - Prod. cartesiano ($\times$)
  - Junção ($\bowtie$)
  - Divisão ($\div$)
- **Esquema alterado!**

### Produto cartesiano ($\times$)

- Dadas duas relações $R$ e $S$ quaisquer, combina cada tupla de $R$ com cada tupla de $S$
  - Notação: $R \times S$
- Características
  - $|R \times S| = |R||S|$
  - $grau(R \times S) = grau(R) + grau(S)$

---

**Tabela:** Empregado

| **ID** | **Nome** | **Salário** | **Dept** |
| :----: | :------: | :---------: | :------: |
|  032   | J Silva  |     380     |    21    |
|  074   |  M Reis  |     400     |    25    |
|  089   |  C Melo  |     520     |    28    |

**Tabela:** Departamento

| ID  |    Nome    | Ramal |
| :-: | :--------: | :---: |
| 21  |  Pessoal   |  142  |
| 25  | Financeiro |  143  |
| 28  |  Técnico   |  144  |

---

[Imagem: diagrama representando o produto cartesiano entre as tabelas Empregado e Departamento]

---

**Tabela:** Empregado E $\times$ Departamento D

| E.ID | E.Nome  | E.Salário | E.Dept | D.ID |   D.Nome   | D.Ramal |
| :--: | :-----: | :-------: | :----: | :--: | :--------: | :-----: |
| 032  | J Silva |    380    |   21   |  21  |  Pessoal   |   142   |
| 032  | J Silva |    380    |   21   |  25  | Financeiro |   143   |
| 032  | J Silva |    380    |   21   |  28  |  Técnico   |   144   |
| 074  | M Reis  |    400    |   25   |  21  |  Pessoal   |   142   |
| 074  | M Reis  |    400    |   25   |  25  | Financeiro |   143   |
| 074  | M Reis  |    400    |   25   |  28  |  Técnico   |   144   |
| 089  | C Melo  |    520    |   28   |  21  |  Pessoal   |   142   |
| 089  | C Melo  |    520    |   28   |  25  | Financeiro |   143   |
| 089  | C Melo  |    520    |   28   |  28  |  Técnico   |   144   |

#### Tuplas espúrias

- Produto cartesiano combina todas as tuplas de $R$ e $S$
  - Algumas combinações formarão tuplas válidas
  - Outras formarão tuplas espúrias

---

**Tabela:** Empregado E $\times$ Departamento D

|  E.ID   |   E.Nome    | E.Salário | E.Dept |  D.ID  |     D.Nome     | D.Ramal |
| :-----: | :---------: | :-------: | :----: | :----: | :------------: | :-----: |
|   032   |   J Silva   |    380    |   21   |   21   |    Pessoal     |   142   |
| **032** | **J Silva** |  **380**  | **21** | **25** | **Financeiro** | **143** |
| **032** | **J Silva** |  **380**  | **21** | **28** |  **Técnico**   | **144** |
| **074** | **M Reis**  |  **400**  | **25** | **21** |  **Pessoal**   | **142** |
|   074   |   M Reis    |    400    |   25   |   25   |   Financeiro   |   143   |
| **074** | **M Reis**  |  **400**  | **25** | **28** |  **Técnico**   | **144** |
| **089** | **C Melo**  |  **520**  | **28** | **21** |  **Pessoal**   | **142** |
| **089** | **C Melo**  |  **520**  | **28** | **25** | **Financeiro** | **143** |
|   089   |   C Melo    |    520    |   28   |   28   |    Técnico     |   144   |

---

**Tabela:** Empregado E $\times$ Departamento D

| E.ID | E.Nome  | E.Salário | E.Dept |  D.ID  |   D.Nome   | D.Ramal |
| :--: | :-----: | :-------: | :----: | :----: | :--------: | :-----: |
| 032  | J Silva |    380    |   21   |   21   |  Pessoal   |   142   |
| 032  | J Silva |    380    | **21** | **25** | Financeiro |   143   |
| 032  | J Silva |    380    | **21** | **28** |  Técnico   |   144   |
| 074  | M Reis  |    400    | **25** | **21** |  Pessoal   |   142   |
| 074  | M Reis  |    400    |   25   |   25   | Financeiro |   143   |
| 074  | M Reis  |    400    | **25** | **28** |  Técnico   |   144   |
| 089  | C Melo  |    520    | **28** | **21** |  Pessoal   |   142   |
| 089  | C Melo  |    520    | **28** | **25** | Financeiro |   143   |
| 089  | C Melo  |    520    |   28   |   28   |  Técnico   |   144   |

---

- Produto cartesiano combina todas as tuplas de $R$ e $S$
  - Algumas combinações formarão tuplas válidas
  - Outras formarão tuplas espúrias!
- Tuplas espúrias eliminadas via seleção
  - Condição define quais tuplas são válidas
  - Tipicamente baseada na chave estrangeira

---

**Tabela:** Empregado E $\times$ Departamento D

| E.ID | E.Nome  | E.Salário | E.Dept |  D.ID  |   D.Nome   | D.Ramal |
| :--: | :-----: | :-------: | :----: | :----: | :--------: | :-----: |
| 032  | J Silva |    380    |   21   |   21   |  Pessoal   |   142   |
| 032  | J Silva |    380    | **21** | **25** | Financeiro |   143   |
| 032  | J Silva |    380    | **21** | **28** |  Técnico   |   144   |
| 074  | M Reis  |    400    | **25** | **21** |  Pessoal   |   142   |
| 074  | M Reis  |    400    |   25   |   25   | Financeiro |   143   |
| 074  | M Reis  |    400    | **25** | **28** |  Técnico   |   144   |
| 089  | C Melo  |    520    | **28** | **21** |  Pessoal   |   142   |
| 089  | C Melo  |    520    | **28** | **25** | Financeiro |   143   |
| 089  | C Melo  |    520    |   28   |   28   |  Técnico   |   144   |

---

- $\sigma_{E.Dept = D.ID}(Empregado E \times Departamento D)$

**Tabela:** Empregado E $\times$ Departamento D

| E.ID | E.Nome  | E.Salário | E.Dept |  D.ID  |   D.Nome   | D.Ramal |
| :--: | :-----: | :-------: | :----: | :----: | :--------: | :-----: |
| 032  | J Silva |    380    | **21** | **21** |  Pessoal   |   142   |
| 032  | J Silva |    380    |   21   |   25   | Financeiro |   143   |
| 032  | J Silva |    380    |   21   |   28   |  Técnico   |   144   |
| 074  | M Reis  |    400    |   25   |   21   |  Pessoal   |   142   |
| 074  | M Reis  |    400    | **25** | **25** | Financeiro |   143   |
| 074  | M Reis  |    400    |   25   |   28   |  Técnico   |   144   |
| 089  | C Melo  |    520    |   28   |   21   |  Pessoal   |   142   |
| 089  | C Melo  |    520    |   28   |   25   | Financeiro |   143   |
| 089  | C Melo  |    520    | **28** | **28** |  Técnico   |   144   |

---

**Tabela:** Empregado E $\times$ Departamento D

| E.ID | E.Nome  | E.Salário | E.Dept | D.ID |   D.Nome   | D.Ramal |
| :--: | :-----: | :-------: | :----: | :--: | :--------: | :-----: |
| 032  | J Silva |    380    |   21   |  21  |  Pessoal   |   142   |
| 074  | M Reis  |    400    |   25   |  25  | Financeiro |   143   |
| 089  | C Melo  |    520    |   28   |  28  |  Técnico   |   144   |
