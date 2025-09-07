import os
import pandas as pd
import multiset as ms
import re
import sqlite3
import sqlparse
import sys

def note(s):
    '''formats strings to create VPL comments'''
    print('Comment :=>> ' + s)

def grade(g):
    '''formats a number to create a VPL grade'''
    print('Grade :=>> ' + str(g))

def inline(sql):
    return re.sub('\s+', ' ', sql.strip())

def cleanup(sql):
    '''cleans up SQL statement'''
    sql = sqlparse.format(sql, strip_comments=True, reindent=True)
    sql = os.linesep.join([line for line in sql.splitlines() if line])
    return sql

# matriculation number pattern
m_patt = re.compile(r'^\s*--\s*(20\d{8})\b', re.M)
# query id pattern
q_patt = re.compile(r'^\s*--\s*([AB]\d)\b', re.I|re.M)

def parse(statements, check_sid=False):
    '''returns a dict of valid (qid, sql) pairs'''

    queries = {}

    sid = None
    for statement in statements:

        qid = None
        sql = inline(cleanup(str(statement)))

        for token in statement.tokens:

            # validate comment
            if isinstance(token, sqlparse.sql.Comment):
                comment = str(token)

                # validate student id
                if check_sid and not sid:
                    m = m_patt.search(comment)
                    if m:
                        sid = m.group(1)
                    else:
                        note('Numero de matricula ausente ou invalido. Interrompendo...')
                        sys.exit()

                # validate query id
                m = q_patt.search(comment)
                if m:
                    qid = m.group(1).upper()

            # validate select
            elif str(token).lower() == 'select':
                # ensure query id was informed
                if not qid:
                    note('ID da consulta ausente ou invalido. Ignorando consulta [' + sql + ']')
                else:
                    queries[qid] = sql
    
    return (queries, sid)

def match(conn, asql, ssql):
    # execute answer
    try:
        # answer data frame
        adf = pd.read_sql_query(asql, conn)
        # print(adf)
        # number of columns in answer
        anc = adf.shape[1]
    except Exception as err:
        note(f'Erro ao processar resposta: {err}')
        sys.exit()

    # execute submission
    try:
        # submission data frame
        sdf = pd.read_sql_query(ssql, conn)
        # print(sdf)
        # number of columns in submission
        snc = sdf.shape[1]
    except Exception as err:
        return (0, err)

    # number of columns in submission
    snc = sdf.shape[1]
    
    # test number of columns
    if (anc != snc):
        return (0, f'Numero de colunas incorreto: {snc}')

    # test result set similarity
    else:
        try:
            # rename columns to allow merging (assume same order)
            tmp = sdf.columns
            sdf.columns = adf.columns

            # compute jaccard similarity for sets
            # inter = len(adf.merge(sdf, how='inner', indicator=False))
            # union = len(pd.concat([adf, sdf]))
            
            # compute jaccard similarity for multisets
            ams = ms.Multiset(adf.groupby(adf.columns.tolist()).size().to_dict())
            sms = ms.Multiset(sdf.groupby(sdf.columns.tolist()).size().to_dict())
            inter = len(ams.intersection(sms))
            union = len(ams.union(sms))

            # restore column names
            sdf.columns = tmp

            return (0.5 * inter / union if union > 0 else 0, None)

        except Exception as err:
            return (0, err)

import os
if __name__ == '__main__':
    
    files = [f for f in os.listdir('.') if os.path.isfile(f)]
    for f in files:
        print('>>>> ' + f)
    
    # setup
    note('========================================')
    note('PREPARANDO AVALIACAO')
    note('========================================')

    conn = sqlite3.connect(':memory:')
    cursor = conn.cursor()

    dfp = open('./database.sql')
    dcontents = dfp.read()
    cursor.executescript(dcontents)

    # parse answers
    afp = open('answers.sql', 'r')
    acontents = afp.read()

    (aqueries, dummy) = parse(sqlparse.parse(acontents), check_sid=False)

    # parse submission
    note('========================================')
    note('PROCESSANDO O ARQUIVO SUBMETIDO')
    note('========================================')

    sfp = open('submission.sql', 'r')
    scontents = sfp.read()

    (squeries, sid) = parse(sqlparse.parse(scontents), check_sid=True)

    target = []
    for i in range(0, 5):
        q = int(sid[i])
        while f'A{q}' in target:
            q = (q+1) % 10
        target.append(f'A{q}')

    for i in range(5, 10):
        q = int(sid[i])
        while f'B{q}' in target:
            q = (q+1) % 10
        target.append(f'B{q}')

    note('========================================')
    note('ATRIBUINDO NOTA AO TRABALHO')
    note(f'  Matr. {sid} (consultas-alvo: {", ".join(target)})')
    note('========================================')

    # grade submission
    total = 0
    target.sort()
    for qid in target:
        if qid in squeries.keys():
            (points, err) = match(conn, aqueries[qid], squeries[qid])
            total = total + points
            if (err is None):
                note(f'{qid} => [CONSULTA EXECUTADA COM SUCESSO: {squeries[qid]}]')
                note(f'  pontos: {points:.2f} / 0.50')
            else:
                note(f'{qid} => [CONSULTA COM ERROS NA EXECUCAO: {squeries[qid]}]')
                note(f'  pontos: {points:.2f} / 0.50 # {err}')
        else:
            note(f'{qid} => [CONSULTA NAO ENCONTRADA]')
            note(f'  pontos: 0.00 / 0.50')
    
    note(f'TOTAL (antes dos descontos): {total:.2f} / {0.5 * len(target):.2f}')

    grade(f'{total:.2f}')

    conn.close()