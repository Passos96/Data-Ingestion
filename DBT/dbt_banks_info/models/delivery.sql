WITH source_banks AS (
    SELECT *
	FROM public.banks_trusted
),		
source_employers AS (
	SELECT employer_name, reviews_count, culture_count, salaries_count, benefits_count, "employer-website", "employer-headquarters", "employer-founded", "employer-industry", "employer-revenue", url, "Geral", "Cultura e valores", "Diversidade e inclusão", "Qualidade de vida", "Alta liderança", "Remuneração e benefícios", "Oportunidades de carreira", "Recomendam para outras pessoas(%)", "Perspectiva positiva da empresa(%)", "Nome" as nome_emp, match_percent
	FROM public.employers_trusted
),
source_reviews AS (
	SELECT * 
	FROM public.reviews_trusted
)


SELECT DISTINCT * FROM source_banks
join source_employers
on source_banks.nome = source_employers.nome_emp
join source_reviews
on source_banks.cnpj = source_reviews.cnpj_rev