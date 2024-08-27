
  create view "DBT"."public"."joined_banks_data__dbt_tmp"
    
    
  as (
    -- Insere dados ou atualiza se já existir
INSERT INTO banks_trusted (Segmento, CNPJ, Nome)
SELECT "Segmento", CAST("CNPJ" AS VARCHAR), REPLACE("Nome", ' - PRUDENCIAL', '')
FROM public.banks;




/*
--Cria a tabela employers_trusted caso não exista
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_tables WHERE tablename = 'employers_trusted') THEN
    EXECUTE 'CREATE TABLE employers_trusted (LIKE employers INCLUDING ALL)';
  END IF;
END $$;

-- Insere dados na tabela trusted
INSERT INTO employers_trusted
SELECT * FROM public.employers;

--Cria a tabela reviews_trusted caso não exista
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_tables WHERE tablename = 'reviews_trusted') THEN
    EXECUTE 'CREATE TABLE reviews_trusted (LIKE reviews INCLUDING ALL)';
  END IF;
END $$;

--Altera o nome coluna CNPJ IF para CNPJ
ALTER TABLE reviews_trusted
RENAME COLUMN "CNPJ IF" TO CNPJ;

--Altera a coluna CNPJ para VARCHAR
ALTER TABLE reviews_trusted
ALTER COLUMN CNPJ TYPE VARCHAR;

-- Insere dados na tabela trusted
INSERT INTO reviews_trusted
SELECT "Segmento", CAST("CNPJ" AS VARCHAR), "Nome", "employer_name", "reviews_count", "culture_count", "salaries_count", "benefits_count", "employer-website", "employer-headquarters", "employer-founded", "employer-industry", "employer-revenue", url, "Geral", "Cultura e valores", "Diversidade e inclusão", "Qualidade de vida", "Alta liderança", "Remuneração e benefícios", "Oportunidades de carreira", "Recomendam para outras pessoas(%)", "Perspectiva positiva da empresa(%)", match_percent, "Ano", "Trimestre", "Categoria", "Tipo", "CNPJ IF", "Institui��o financeira", "�ndice", "Quantidade de reclama��es reguladas procedentes", "Quantidade de reclama��es reguladas - outras", "Quantidade de reclama��es n�o reguladas", "Quantidade total de reclama��es", "Quantidade total de clientes � CCS e SCR", "Quantidade de clientes � CCS", "Quantidade de clientes � SCR"
FROM public.reviews;


WITH banks AS (
  SELECT * FROM "DBT"."public"."banks"
),
employers AS (
  SELECT * FROM "DBT"."public"."employers"
),
reviews AS (
  SELECT * FROM "DBT"."public"."reviews"
)

SELECT
  banks.*,
  employers.*,
  reviews.*
FROM banks
INNER JOIN employers ON banks.Nome = employers.Nome
INNER JOIN reviews ON CAST(banks.CNPJ AS TEXT) = CAST(reviews."CNPJ IF" AS TEXT);

-- Verifica se a tabela final existe
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_tables WHERE tablename = 'delivery') THEN
    EXECUTE 'CREATE TABLE delivery (LIKE temp_table INCLUDING ALL)';
  END IF;
END $$;

-- Insere dados na tabela final
INSERT INTO delivery
SELECT * FROM temp_table;
*/
  );