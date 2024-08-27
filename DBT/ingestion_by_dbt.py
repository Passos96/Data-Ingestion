import pandas as pd
from sqlalchemy import create_engine
from pathlib import Path
import psycopg2
import subprocess
import os

def get_csv_separator(folder, suffix):
    if folder == 'BANKS':
        sep = '\t' if suffix == '.tsv' else ';'
    elif folder == 'EMPLOYERS':
        sep = '|'
    elif folder == 'REVIEWS':
        sep = ';'
    else:
        sep = None
    return sep

def run_dbt():
    try:
        # Altere para o diretório onde o dbt está localizado
        path = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'dbt_banks_info')
        os.chdir(path)
        print(path)
        # Executa o comando 'dbt run'
        result = subprocess.run(['dbt', 'run'], check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        # Exibe a saída do comando
        print(result.stdout)
        
    except Exception as e:
        # Em caso de erro, exibe a mensagem de erro
        print(f"O comando falhou com o erro: {e}")

directory = 'C:/Users/marcelo.passos/Desktop/Pós Poli/Ingestão/Ingestao_by_python/RAW/'
FOLDERS_LST = ['BANKS', 'EMPLOYERS', 'REVIEWS']
for folder in FOLDERS_LST:
    df_list = []
    for file in list(Path(directory + folder).glob('*.csv')) + list(Path(directory + folder).glob('*.tsv')):
        sep = get_csv_separator(folder, file.suffix)
        # Ler o arquivo em um DataFrame
        df = pd.read_csv(file, sep=sep, encoding='utf-8')
        # Adicionar o DataFrame à lista
        df_list.append(df)
    # Concatenar todos os DataFrames em um único DataFrame
    df_banks_union = pd.concat(df_list, ignore_index=True)
    # Conectar ao banco de dados PostgreSQL
    DATABASE_URL = 'postgresql://dbt_job:dbt_job@localhost:5432/DBT'
    engine = create_engine(DATABASE_URL)
    # Criar e popular a tabela no PostgreSQL
    df_banks_union.to_sql(folder.lower(), engine, if_exists='replace', index=False)

# Executar os scripts .sql via dbt
run_dbt()


