
-- SQL stage: raw financials + validation + analysis
-- Historical data: 2023-2025
-- Forecast data remains in Excel and is not inserted here.

DROP TABLE IF EXISTS raw_financials;

CREATE TABLE raw_financials (
    year INT NOT NULL,
    region VARCHAR(50) NOT NULL,
    metric VARCHAR(100) NOT NULL,
    value DECIMAL(18,2) NOT NULL,
    unit VARCHAR(30) NOT NULL,
    source VARCHAR(50) NOT NULL
);

INSERT INTO raw_financials
(year, region, metric, value, unit, source)
VALUES
(2023,'Consolidated','Net Operating Revenues',45754.00,'USD million','2023 10-K'),
(2023,'Consolidated','Revenue Growth',6.00,'%','2023 10-K'),
(2023,'Consolidated','Operating Income',11311.00,'USD million','2023 10-K'),
(2023,'Consolidated','Operating Margin',24.70,'%','2023 10-K'),
(2023,'Consolidated','Gross Profit',27234.00,'USD million','2023 10-K'),
(2023,'Consolidated','Gross Profit Margin',59.50,'%','2023 10-K'),
(2023,'Consolidated','Volume Impact',2.00,'%','2023 10-K'),
(2023,'Consolidated','Price/Product/Geographic Mix',10.00,'%','2023 10-K'),
(2023,'Consolidated','FX Impact',-4.00,'%','2023 10-K'),
(2023,'Consolidated','Acquisitions/Divestitures',-1.00,'%','2023 10-K'),
(2023,'EMEA','Revenue Contribution',16.20,'% of company revenue','2023 10-K'),
(2023,'EMEA','Revenue Growth',7.00,'%','2023 10-K'),
(2023,'EMEA','Operating Income',4202.00,'USD million','2023 10-K'),
(2023,'EMEA','Operating Margin',56.80,'%','2023 10-K'),
(2023,'EMEA','Price/Product/Geographic Mix',19.00,'%','2023 10-K'),
(2023,'EMEA','FX Impact',-12.00,'%','2023 10-K'),

(2024,'Consolidated','Net Operating Revenues',47061.00,'USD million','2024 10-K'),
(2024,'Consolidated','Revenue Growth',3.00,'%','2024 10-K'),
(2024,'Consolidated','Operating Income',9992.00,'USD million','2024 10-K'),
(2024,'Consolidated','Operating Margin',21.20,'%','2024 10-K'),
(2024,'Consolidated','Gross Profit',28737.00,'USD million','2024 10-K'),
(2024,'Consolidated','Gross Profit Margin',61.10,'%','2024 10-K'),
(2024,'Consolidated','Volume Impact',2.00,'%','2024 10-K'),
(2024,'Consolidated','Price/Product/Geographic Mix',11.00,'%','2024 10-K'),
(2024,'Consolidated','FX Impact',-5.00,'%','2024 10-K'),
(2024,'Consolidated','Acquisitions/Divestitures',-4.00,'%','2024 10-K'),
(2024,'EMEA','Revenue Contribution',15.80,'% of company revenue','2024 10-K'),
(2024,'EMEA','Revenue Growth',1.00,'%','2024 10-K'),
(2024,'EMEA','Operating Income',4125.00,'USD million','2024 10-K'),
(2024,'EMEA','Operating Margin',55.40,'%','2024 10-K'),
(2024,'EMEA','Price/Product/Geographic Mix',17.00,'%','2024 10-K'),
(2024,'EMEA','FX Impact',-16.00,'%','2024 10-K'),

(2025,'Consolidated','Net Operating Revenues',47941.00,'USD million','2025 10-K'),
(2025,'Consolidated','Revenue Growth',2.00,'%','2025 10-K'),
(2025,'Consolidated','Operating Income',13762.00,'USD million','2025 10-K'),
(2025,'Consolidated','Operating Margin',28.70,'%','2025 10-K'),
(2025,'Consolidated','Gross Profit',29544.00,'USD million','2025 10-K'),
(2025,'Consolidated','Gross Profit Margin',61.60,'%','2025 10-K'),
(2025,'Consolidated','Volume Impact',1.00,'%','2025 10-K'),
(2025,'Consolidated','Price/Product/Geographic Mix',4.00,'%','2025 10-K'),
(2025,'Consolidated','FX Impact',-2.00,'%','2025 10-K'),
(2025,'Consolidated','Acquisitions/Divestitures',-1.00,'%','2025 10-K'),
(2025,'EMEA','Revenue Contribution',22.60,'% of company revenue','2025 10-K'),
(2025,'EMEA','Revenue Growth',5.00,'%','2025 10-K'),
(2025,'EMEA','Operating Income',4298.00,'USD million','2025 10-K'),
(2025,'EMEA','Operating Margin',39.70,'%','2025 10-K'),
(2025,'EMEA','Price/Product/Geographic Mix',2.00,'%','2025 10-K'),
(2025,'EMEA','FX Impact',-1.00,'%','2025 10-K');

-- =========================================================
-- VALIDATION QUERIES
-- =========================================================

-- 1) Row count: should return 48
SELECT COUNT(*) AS total_rows
FROM raw_financials;

-- 2) Rows by year: should return 16 for each year
SELECT year, COUNT(*) AS row_count
FROM raw_financials
GROUP BY year
ORDER BY year;

-- 3) Check for missing values
SELECT *
FROM raw_financials
WHERE year IS NULL
   OR region IS NULL
   OR metric IS NULL
   OR value IS NULL
   OR unit IS NULL
   OR source IS NULL;

-- 4) Check source consistency
SELECT year, source, COUNT(*) AS rows_per_source
FROM raw_financials
GROUP BY year, source
ORDER BY year;

-- =========================================================
-- FP&A ANALYSIS QUERIES
-- =========================================================

-- 5) Consolidated revenue, operating income and margins
SELECT
    year,
    MAX(CASE WHEN metric = 'Net Operating Revenues' THEN value END) AS revenue,
    MAX(CASE WHEN metric = 'Operating Income' THEN value END) AS operating_income,
    MAX(CASE WHEN metric = 'Operating Margin' THEN value END) AS operating_margin,
    MAX(CASE WHEN metric = 'Gross Profit' THEN value END) AS gross_profit,
    MAX(CASE WHEN metric = 'Gross Profit Margin' THEN value END) AS gross_profit_margin
FROM raw_financials
WHERE region = 'Consolidated'
GROUP BY year
ORDER BY year;

-- 6) Revenue trend by year
SELECT
    year,
    value AS revenue_usd_million
FROM raw_financials
WHERE region = 'Consolidated'
  AND metric = 'Net Operating Revenues'
ORDER BY year;

-- 7) Revenue driver analysis
SELECT
    year,
    MAX(CASE WHEN metric = 'Volume Impact' THEN value END) AS volume_impact,
    MAX(CASE WHEN metric = 'Price/Product/Geographic Mix' THEN value END) AS price_mix_impact,
    MAX(CASE WHEN metric = 'FX Impact' THEN value END) AS fx_impact,
    MAX(CASE WHEN metric = 'Acquisitions/Divestitures' THEN value END) AS acquisition_divestiture_impact
FROM raw_financials
WHERE region = 'Consolidated'
GROUP BY year
ORDER BY year;

-- 8) EMEA performance
SELECT
    year,
    MAX(CASE WHEN metric = 'Revenue Contribution' THEN value END) AS emea_revenue_contribution,
    MAX(CASE WHEN metric = 'Revenue Growth' THEN value END) AS emea_revenue_growth,
    MAX(CASE WHEN metric = 'Operating Income' THEN value END) AS emea_operating_income,
    MAX(CASE WHEN metric = 'Operating Margin' THEN value END) AS emea_operating_margin,
    MAX(CASE WHEN metric = 'Price/Product/Geographic Mix' THEN value END) AS emea_price_mix,
    MAX(CASE WHEN metric = 'FX Impact' THEN value END) AS emea_fx_impact
FROM raw_financials
WHERE region = 'EMEA'
GROUP BY year
ORDER BY year;

-- 9) Revenue CAGR from 2023 to 2025
WITH revenues AS (
    SELECT
        MAX(CASE WHEN year = 2023 AND metric = 'Net Operating Revenues' THEN value END) AS rev_2023,
        MAX(CASE WHEN year = 2025 AND metric = 'Net Operating Revenues' THEN value END) AS rev_2025
    FROM raw_financials
    WHERE region = 'Consolidated'
)
SELECT
    rev_2023,
    rev_2025,
    (POWER(CAST(rev_2025 AS REAL) / CAST(rev_2023 AS REAL), 1.0 / 2.0) - 1) * 100
    AS revenue_cagr_2023_2025
FROM revenues;

-- 10) Gross margin change from 2023 to 2025
WITH margins AS (
    SELECT
        MAX(CASE WHEN year = 2023 AND metric = 'Gross Profit Margin' THEN value END) AS gm_2023,
        MAX(CASE WHEN year = 2025 AND metric = 'Gross Profit Margin' THEN value END) AS gm_2025
    FROM raw_financials
    WHERE region = 'Consolidated'
)
SELECT
    gm_2023,
    gm_2025,
    gm_2025 - gm_2023 AS gross_margin_change_pp
FROM margins;

-- 11) Operating margin change from 2023 to 2025
WITH margins AS (
    SELECT
        MAX(CASE WHEN year = 2023 AND metric = 'Operating Margin' THEN value END) AS om_2023,
        MAX(CASE WHEN year = 2025 AND metric = 'Operating Margin' THEN value END) AS om_2025
    FROM raw_financials
    WHERE region = 'Consolidated'
)
SELECT
    om_2023,
    om_2025,
    om_2025 - om_2023 AS operating_margin_change_pp
FROM margins;

-- 12) 2025 vs 2024 revenue change (absolute and percentage)
WITH rev AS (
    SELECT
        MAX(CASE WHEN year = 2024 AND metric = 'Net Operating Revenues' THEN value END) AS rev_2024,
        MAX(CASE WHEN year = 2025 AND metric = 'Net Operating Revenues' THEN value END) AS rev_2025
    FROM raw_financials
    WHERE region = 'Consolidated'
)
SELECT
    rev_2024,
    rev_2025,
    rev_2025 - rev_2024 AS revenue_change_usd_million,
    (CAST(rev_2025 AS REAL) / CAST(rev_2024 AS REAL) - 1) * 100 AS calculated_growth_pct
FROM rev;

-- 13) Data quality check for unexpected units
SELECT DISTINCT metric, unit
FROM raw_financials
ORDER BY metric, unit;

-- 14) Duplicate check
SELECT year, region, metric, COUNT(*) AS duplicate_count
FROM raw_financials
GROUP BY year, region, metric
HAVING COUNT(*) > 1
ORDER BY year, region, metric;

-- =========================================================
-- END OF SQL STAGE
-- create

