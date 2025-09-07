-- A0.
-- ALGEBRA RELACIONAL
-- Liste nome do país e nome do circuito das corridas de 1987
SELECT NOME_PAIS,
       NOME_CIRCUITO
  FROM PAIS
       NATURAL JOIN
       CIRCUITO
       NATURAL JOIN
       CORRIDA
 WHERE ANO_CORRIDA = 1987;
 
 --A1.
 -- ALGEBRA RELACIONAL
 -- Liste o nome de construtores que já abandonou corrida por
 -- problemas no turbo ou nas velas
SELECT DISTINCT NOME_CONSTRUTOR
  FROM RESULTADO
       NATURAL JOIN
       CONSTRUTOR
       NATURAL JOIN
       STATUS
 WHERE DESC_STATUS = 'Velas' OR 
       DESC_STATUS = 'Turbo';

-- A2.
-- ALGEBRA RELACIONAL
-- Hat-trick na fórmula 1 é quando o piloto larga na frente,
-- vence a prova e ainda faz a volta mais rápida, mesmo que
-- tenha perdido a liderança em algum momento da corrida.
-- Liste, em ordem alfabética, nome e nacionalidade dos
-- diferentes pilotos que já fizeram hat-tricks
SELECT DISTINCT NOME_PILOTO,
                NACIONALIDADE_PILOTO
  FROM PILOTO P
       INNER JOIN
       RESULTADO R ON R.ID_PILOTO = P.ID_PILOTO
 WHERE R.VALOR_POS_TERMINO = 1 AND 
       R.VALOR_POS_LARGADA = 1 AND 
       R.VALOR_POSICAO_VMR = 1
 ORDER BY NOME_PILOTO,
          NACIONALIDADE_PILOTO;
		  
--A3. 
-- ALGEBRA RELACIONAL
-- Listar todos os países e o nome dos seus circuitos quando existirem
SELECT NOME_PAIS,
       NOME_CIRCUITO
  FROM PAIS
       NATURAL LEFT OUTER JOIN
       CIRCUITO;
	   
--A4.
-- ALGEBRA RELACIONAL
-- Listar as nacionalidades de pilotos que também são nacionalidades de construtor
SELECT DISTINCT NACIONALIDADE_PILOTO
  FROM PILOTO
INTERSECT
SELECT DISTINCT NACIONALIDADE_CONSTRUTOR
  FROM CONSTRUTOR;
 
--A5.	.
-- ALGEBRA RELACIONAL
-- Liste o nome do circuito, ano da corrida e o nome do piloto vencedor
-- nas corridas em que o vencedor foi um piloto brasileiro entre os anos
-- de 1970 (inclusive) e 1980 (inclusive) 
SELECT NOME_CIRCUITO,
       ANO_CORRIDA,
       NOME_PILOTO
  FROM CORRIDA C
       INNER JOIN
       CIRCUITO CT ON C.ID_CIRCUITO = CT.ID_CIRCUITO
       INNER JOIN
       RESULTADO R ON C.ID_CORRIDA = R.ID_CORRIDA
       INNER JOIN
       PILOTO P ON P.ID_PILOTO = R.ID_PILOTO
 WHERE P.NACIONALIDADE_PILOTO = 'Brasileira' AND 
       R.VALOR_POS_TERMINO = 1 AND 
       ANO_CORRIDA >= 1971 AND 
       ANO_CORRIDA <= 1980;
	   
-- A6.
-- ALGEBRA RELACIONAL
-- Pilotos que venceram mais de quatro corridas em 1991
SELECT DISTINCT NOME_PILOTO
  FROM CLASSIFICACAO_PILOTO
       NATURAL JOIN
       PILOTO
       NATURAL JOIN
       CORRIDA
 WHERE ANO_CORRIDA = 1991 AND 
       QTE_VITORIAS > 4;
	   
--A7.
-- ALGEBRA RELACIONAL
-- Liste IDs de corrida e duração dos pitstops que duraram menos de 14s
SELECT ID_CORRIDA,
       DURACAO_PITSOP
  FROM PITSTOP
 WHERE DURACAO_PITSOP < 14.0;


--A8.
-- ALGEBRA RELACIONAL
-- Vencedores (Pilotos) do circuito 5 (Istambul) por ano
SELECT ANO_CORRIDA,
       NOME_PILOTO
  FROM CORRIDA
       NATURAL JOIN
       RESULTADO
       NATURAL JOIN
       PILOTO
 WHERE ID_CIRCUITO = 5 AND 
       VALOR_POS_TERMINO = 1;
	   
-- A9.
-- ALGEBRA RELACIONAL
-- Construtores que pontuaram em HockenHeim em 2016
SELECT ANO_CORRIDA,
       NOME_CONSTRUTOR,
       QTE_PONTOS
  FROM CORRIDA
       NATURAL JOIN
       RESULTADO_CONSTRUTOR
       NATURAL JOIN
       CONSTRUTOR
 WHERE ID_CIRCUITO = 10 AND 
       ANO_CORRIDA >= 2016 AND 
       QTE_PONTOS > 10;
	   
-- B0. 
-- Listar o nome do circuito e nome do piloto vencedor
-- de cada corrida de 2017.
SELECT NOME_CIRCUITO,
       NOME_PILOTO
  FROM CIRCUITO CT,
       PILOTO P,
       CORRIDA CR,
       RESULTADO R
 WHERE CR.ID_CIRCUITO = CT.ID_CIRCUITO AND 
       R.ID_CORRIDA = CR.ID_CORRIDA AND 
       R.ID_PILOTO = P.ID_PILOTO AND 
       ANO_CORRIDA = 2017 AND 
       VALOR_POS_TERMINO = 1;

-- B1.
-- Pole position é quando o piloto larga da 1a posição. 
-- Listar nome, nacionalidade e número de pole positions
-- do piloto que mais vezes largou em 1o em 2015

SELECT NOME_PILOTO,
       NACIONALIDADE_PILOTO,
       MAX(POLES) 
  FROM (
           SELECT NOME_PILOTO,
                  COUNT(NOME_PILOTO) AS POLES,
                  NACIONALIDADE_PILOTO
             FROM PILOTO P,
                  CORRIDA C,
                  RESULTADO R
            WHERE P.ID_PILOTO = R.ID_PILOTO AND 
                  C.ID_CORRIDA = R.ID_CORRIDA AND 
                  R.VALOR_POS_LARGADA = 1 AND 
                  C.ANO_CORRIDA = 2015
            GROUP BY NOME_PILOTO,
                     NACIONALIDADE_PILOTO
       );


-- B2.
-- Liste a equipe e a duração do pitstop mais rápido registrado na base		
SELECT NOME_CONSTRUTOR,
       MIN(DURACAO_PITSOP) 
  FROM PITSTOP P
       INNER JOIN
       RESULTADO R ON R.ID_CORRIDA = P.ID_CORRIDA AND 
                      R.ID_PILOTO = P.ID_PILOTO
       INNER JOIN
       CONSTRUTOR C ON C.ID_CONSTRUTOR = R.ID_CONSTRUTOR;

-- B3.
-- Liste nome e sobrenome dos pilotos brasileiros que nunca pisaram no 
-- pódio (i.e. nunca terminaram entre 1o e 3o lugares)
SELECT DISTINCT nome_piloto
  FROM piloto p
 WHERE p.id_piloto NOT IN (
           SELECT id_piloto
             FROM resultado r
            WHERE valor_pos_termino <= 3
       )
AND 
       NACIONALIDADE_PILOTO = 'Brasileira';
	   
-- B4.
-- Liste as nacionalidades e número de abandonos das equipes
-- que já tiveram pelo menos 10 abandonos de prova por culpa
-- da embreagem 
SELECT c.NACIONALIDADE_CONSTRUTOR,
       count(NACIONALIDADE_CONSTRUTOR) 
  FROM RESULTADO r
       INNER JOIN
       CONSTRUTOR C ON c.ID_CONSTRUTOR = r.ID_CONSTRUTOR
       INNER JOIN
       STATUS s ON s.ID_STATUS = r.ID_STATUS
 WHERE S.DESC_STATUS like '%Embreagem%'
 GROUP BY nacionalidade_construtor
 HAVING count(NACIONALIDADE_CONSTRUTOR) >= 10;
 
-- B5.
 -- Liste o nome dos países que já receberam mais de uma prova
 -- em uma mesma temporada
 SELECT DISTINCT NOME_PAIS
  FROM PAIS P
       INNER JOIN
       CIRCUITO C ON C.ID_PAIS = P.ID_PAIS
       INNER JOIN
       CORRIDA CD ON CD.ID_CIRCUITO = C.ID_CIRCUITO
 GROUP BY NOME_PAIS,
          ANO_CORRIDA
HAVING COUNT(CD.ID_CORRIDA) > 1;

-- B6.
-- Liste o ano e o nome do circuito de todas as corridas que 
-- já aconteceram no mês de dezembro.
SELECT ANO_CORRIDA,
       NOME_CIRCUITO
  FROM CORRIDA CD
       INNER JOIN
       CIRCUITO CT ON CD.ID_CIRCUITO = CT.ID_CIRCUITO
 WHERE STRFTIME('%m', Data_corrida) = '12';

-- B7.
-- Liste ano, nome e quantidade de pontos do piloto
-- campeão de cada ano desde 2001
SELECT ANO_CORRIDA,
       NOME_PILOTO,
       MAX(QTE_PONTOS)
  FROM CLASSIFICACAO_PILOTO CP,
       CORRIDA C,
       PILOTO P
 WHERE C.ID_CORRIDA = CP.ID_CORRIDA AND 
       P.ID_PILOTO = CP.ID_PILOTO AND
       ANO_CORRIDA >=2001
 GROUP BY ANO_CORRIDA;

-- B8.
 --Liste os anos em que a última prova do ano foi
 -- em um circuito do Brasil
SELECT CORRIDA.ANO_CORRIDA
  FROM CORRIDA,
       CIRCUITO,
       PAIS,
       (
           SELECT ANO_CORRIDA,
                  MAX(VALOR_RODADA) AS ULTIMA_RODADA
             FROM CORRIDA C
            GROUP BY ANO_CORRIDA
       )
       AS UC
 WHERE CORRIDA.VALOR_RODADA = UC.ULTIMA_RODADA AND 
       CORRIDA.ANO_CORRIDA = UC.ANO_CORRIDA AND 
       CIRCUITO.ID_CIRCUITO = CORRIDA.ID_CIRCUITO AND 
       PAIS.ID_PAIS = CIRCUITO.ID_PAIS AND 
       PAIS.NOME_PAIS = 'Brasil';
 
 --B9. 
 -- Liste os circuitos nos quais Lewis Hamilton já venceu corridas e
 -- quantas vitórias ele tem em cada um
SELECT NOME_CIRCUITO,
       COUNT(NOME_CIRCUITO) 
  FROM CIRCUITO CT
       INNER JOIN
       CORRIDA CR ON CT.ID_CIRCUITO = CR.ID_CIRCUITO
       INNER JOIN
       RESULTADO R ON CR.ID_CORRIDA = R.ID_CORRIDA
       INNER JOIN
       PILOTO P ON R.ID_PILOTO = P.ID_PILOTO
 WHERE P.NOME_PILOTO LIKE '%Lewis Hamilton%' AND 
       R.VALOR_POS_TERMINO = 1
 GROUP BY NOME_CIRCUITO;