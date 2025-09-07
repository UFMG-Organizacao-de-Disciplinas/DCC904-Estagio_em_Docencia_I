# Conteúdo

## Novos

### EX1: 05 Modelo ER: Exercícios (EX1 - 02/09 @ 23:59)

Aberto: terça, 2 Set 2025, 14:00
Vencimento: terça, 2 Set 2025, 23:59
Considere a seguinte especificação de requisitos:

A Associação de Tenistas Profissionais (ATP) contratou você para projetar a estrutura do banco de dados que armazenará dados dos diversos torneios organizados por ela ao longo do ano. Para cada torneio, deverão ser armazenados um identificador, nome (e.g., "Wimbledon 2025"), e o país onde o torneio é sediado. O torneio terá a sua disposição uma série de quadras, cada uma representada por um identificador, um nome (e.g., "Quadra Central") e um tipo de piso (e.g., "grama", "saibro", "concreto"). Cada quadra poderá ser utilizada por múltiplos torneios. Cada partida será disputada por dois jogadores do mesmo sexo, e deverá registrar a quadra, torneio, fase (e.g., "1a fase", "2a fase", "3a fase", "4a fase", "quartas-de-final", "semifinal", "final") e a data em que a partida foi disputada, bem como o número de sets vencidos por cada jogador. Cada jogador será representado por um identificador, nome, sexo, e país.

Utilizando as construções vistas para o modelo entidade-relacionamento (ER), produza o esquema ER correspondente a esses requisitos. Para confecção do esquema, você pode utilizar qualquer software para a edição de diagramas, ou mesmo fazer o diagrama a mão, desde que utilize a notação vista em aula.

Sumário de avaliação

## Antigos

### 05 Modelo ER: Exercícios (EX1 - 02/09 @ 23:59)

Aberto: terça, 2 Set 2025, 14:00
Vencimento: terça, 2 Set 2025, 23:59
Considere a seguinte especificação de requisitos:

A Associação de Tenistas Profissionais (ATP) contratou você para projetar a estrutura do banco de dados que armazenará dados dos diversos torneios organizados por ela ao longo do ano. Para cada torneio, deverão ser armazenados um identificador, nome (e.g., "Wimbledon 2025"), e o país onde o torneio é sediado. O torneio terá a sua disposição uma série de quadras, cada uma representada por um identificador, um nome (e.g., "Quadra Central") e um tipo de piso (e.g., "grama", "saibro", "concreto"). Cada quadra poderá ser utilizada por múltiplos torneios. Cada partida será disputada por dois jogadores do mesmo sexo, e deverá registrar a quadra, torneio, fase (e.g., "1a fase", "2a fase", "3a fase", "4a fase", "quartas-de-final", "semifinal", "final") e a data em que a partida foi disputada, bem como o número de sets vencidos por cada jogador. Cada jogador será representado por um identificador, nome, sexo, e país.

Utilizando as construções vistas para o modelo entidade-relacionamento (ER), produza o esquema ER correspondente a esses requisitos. Para confecção do esquema, você pode utilizar qualquer software para a edição de diagramas, ou mesmo fazer o diagrama a mão, desde que utilize a notação vista em aula.

### 08 Modelo Relacional: Exercícios (EX2 - 07/04 @ 23:59)

Aberto: domingo, 27 Jul 2025, 13:00
Vencimento: domingo, 27 Jul 2025, 23:59
Considere o seguinte esquema ER, construído a partir da especificação de requisitos apresentada no EX1:

Utilizando as construções vistas para o modelo relacional, produza o esquema relacional correspondente a esse esquema ER. Para confecção do esquema relacional, você pode utilizar a notação textual ou gráfica vista em aula. Caso opte pela notação gráfica, você pode utilizar qualquer software para a edição de diagramas, ou mesmo fazer o diagrama a mão, desde que utilize a notação vista em aula. A submissão deve ser em formato PDF.

### 13 Álgebra Relacional: Exercícios (EX3 - 05/05 @ 23:59)

Aberto: domingo, 24 Ago 2025, 13:00
Vencimento: domingo, 24 Ago 2025, 23:59
Usando álgebra relacional, especifique as consultas abaixo dado o seguinte esquema relacional:

Pesquisador(PID, Nome)
Artigo(AID, Título, Veículo, Ano)
Citação(Citante, Citado)
Citante referencia Artigo.AID
Citado referencia Artigo.AID
Autoria(AID, PID, Posição)
AID referencia Artigo.AID
PID referencia Pesquisador.PID
Obter os nomes dos pesquisadores que, em 2020, publicaram artigos em veículo intitulado "VLDB Journal", constando como primeiro autor. Resolver usando produto cartesiano.
Resolver a questão (1) usando junções (naturais, de preferência).
Obter os nomes dos pesquisadores que não foram autores de artigos.
Obter os códigos dos pesquisadores que publicaram todos os artigos de 2015.
Obter os nomes dos pesquisadores que citam o pesquisador de nome "J Silva".
Obter os códigos dos artigos que citam outros artigos do mesmo ano.

### 17 SQL: Exercícios (EX4 - 19/05 @ 13:00)

Aberto: terça, 2 Set 2025, 13:00
Vencimento: domingo, 7 Set 2025, 13:00
Elabore e execute uma consulta SQL para cada uma das questões abertas incluída no notebook anexo. Como solução, submeta um único arquivo .zip contendo

Arquivo .ipynb com as respostas
Arquivo .pdf com as respostas (exportado a partir do próprio notebook)

sql-exercicio.ipynb 13 novembro 2024, 09:54 AM

### 22 Projeto: Exercícios (EX5 - 04/06 @ 23:59)

Abre: terça, 23 Set 2025, 13:00
Vencimento: terça, 23 Set 2025, 23:59

### 27 TP2: Apresentações 23/06 (submeter slides até 22/06 @ 23:59)

Abre: terça, 7 Out 2025, 00:00
Vencimento: sábado, 11 Out 2025, 23:59
Chegada de Turistas Internacionais - 2024
GABRIEL IRALA / LEONARDO GAIAO / MARCELO CAMPOS
Licitações e Contratos do Governo Federal
AMANDA BARBOSA / FABRICIO SOBRINHO / JUAN JUNQUEIRA
Dados do Cadastro Nacional da Pessoa Jurídica
IZABELA XAVIER / LARA FREITAS / MARCIA DRUMMOND
Importações por NCM 2024
DANIEL COSTA / ISAAC ABREU / PEDRO SILVA
Viagens a Serviço no Governo Federal
ARTHUR FUJITO / DAVI RODRIGUES / GABRIEL VAZ
CRU - Dados Correcionais
GABRIEL MOURA / IAN STARLING

### 28 TP2: Apresentações 25/06 (submeter slides até 24/06 @ 23:59)

Abre: terça, 7 Out 2025, 00:00
Vencimento: segunda, 13 Out 2025, 23:59
CACI - Cartografia de Ataques contra Indígenas
GIOVANNA SOUZA / JULIANE DUTRA
Doses aplicadas pelo Programa de Nacional de Imunizações (PNI) - 2025
GABRIEL VIOLANTE / GUSTAVO RIBEIRO / MIGUEL MOREIRA
CENIPA - Ocorrências Aeronáuticas na Aviação Civil Brasileira
CAIO COSTA / MARCOS SANTOS
Salas de Exibição e Complexos Registrados pela Ancine
ALICE FERREIRA / PEDRO CALAIS
Acervo de Dados Técnicos da ANP
GABRIEL GOMES / JOAO ARALDI / RODRIGO FELIZARDO
Projetos do setor público com financiamento externo de organismos internacionais
CAMILA RIBEIRO / EMERSON SIMÕES / PAULO RAMOS

### Submissão da proposta (01/06 @ 23:59)

Abre: terça, 16 Set 2025, 00:00
Vencimento: sábado, 20 Set 2025, 23:59

### Submissão do relatório (22/06 @ 23:59)

Abre: terça, 16 Set 2025, 00:00
Vencimento: sábado, 11 Out 2025, 23:59

### Submissão (02/06 @ 23:59)

Disponível a partir de: terça, 2 Set 2025, 13:00
Data de entrega: domingo, 21 Set 2025, 23:59
Arquivos requeridos: submission.sql ( Baixar)
Tipo de trabalho: Trabalho individual
Configurações de notas: Nota máxima: 5 Oculto
Redução por avaliação automática: 0.5 Avaliações livres: 5
Visível: Não
Executar: Não. Script de execução: SQL. Avaliar: Sim. Avaliar apenas no momento do envio: Sim
Atribuição automática de nota: Sim.
Arquivos requeridos
submission.sql
