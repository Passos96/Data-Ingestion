-- models/reviews_trusted.sql

WITH source_data AS (
    SELECT "Ano", "Trimestre", "Categoria", "Tipo", CAST("CNPJ IF" AS VARCHAR) as CNPJ_rev, "Institui��o financeira", "�ndice", "Quantidade de reclama��es reguladas procedentes", "Quantidade de reclama��es reguladas - outras", "Quantidade de reclama��es n�o reguladas", "Quantidade total de reclama��es", "Quantidade total de clientes � CCS e SCR", "Quantidade de clientes � CCS", "Quantidade de clientes � SCR"
	FROM public.reviews
)		

SELECT * FROM source_data