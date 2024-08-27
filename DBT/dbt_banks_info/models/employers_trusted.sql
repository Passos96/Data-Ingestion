-- models/employers_trusted.sql

WITH source_data AS (
    SELECT 
        *
    FROM 
        public.employers
)

SELECT 
    *
FROM 
    source_data