
  
    

  create  table "DBT"."public"."banks_trusted__dbt_tmp"
  
  
    as
  
  (
    -- models/banks_trusted.sql

WITH source_data AS (
    SELECT 
        "Segmento" AS Segmento, 
        CAST("CNPJ" AS VARCHAR) AS CNPJ, 
        REPLACE("Nome", ' - PRUDENCIAL', '') AS Nome
    FROM 
        public.banks
)

SELECT 
    Segmento,
    CNPJ,
    Nome
FROM 
    source_data
  );
  