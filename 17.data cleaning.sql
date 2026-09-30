#data cleaning

# 1. Remove Duplicates
# 2. Standardize the Data 
# 3. Null values or blank values
# 4. Remove Any Column

CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT * 
FROM layoffs_staging;

INSERT layoffs_staging
SELECT *
FROM layoffs;

SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company,industry, total_laid_off, percentage_laid_off, `date`) AS row_num
FROM layoffs_staging;

TRUNCATE TABLE layoffs_staging;

#run all fixing
INSERT layoffs_staging
SELECT * FROM layoffs;

SELECT COUNT(*) FROM layoffs_staging;
#

WITH duplicate_cte AS 
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company,location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging 
)
SELECT *
FROM duplicate_cte
WHERE row_num>1;

SELECT *
FROM layoffs_staging
WHERE company = "Casper";

#cte is not updatable cant be deleted this way
WITH duplicate_cte AS 
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company,location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging 
)
DELETE
FROM duplicate_cte
WHERE row_num>1;

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` text,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` text,
  `row_num`INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


SELECT *
FROM layoffs_staging2
WHERE row_num>1
;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company,location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging; 


DELETE
FROM layoffs_staging2
WHERE row_num>1;

SELECT *
FROM layoffs_staging2;






#Standardizing Data.  

SELECT company, TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1
;

SELECT *
FROM layoffs_staging
WHERE industry LIKE "Crypto%";

UPDATE layoffs_staging2
SET industry = "Crypto"
WHERE industry LIKE "Crypto%";



SELECT DISTINCT country, TRIM(TRAILING "." FROM country)
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING "." FROM country)
WHERE country LIKE "United States%";

SELECT `date`,
STR_TO_DATE(`date`,"%m/%d/%Y") # Y should be uppercase, y is taking first 2 number from the year and updates every year to 2020 
FROM layoffs_staging2;

#there is "null" strings in the dataset
#now just updating date null strings
UPDATE layoffs_staging2
SET `date`= NULL
WHERE `date`= "NULL";

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`,"%m/%d/%Y");


#only do staging table do not apply on the main table
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date`DATE;


SELECT *
FROM layoffs_staging2;







#Working with nulls

#first return "NULL"(string) to NULL

UPDATE layoffs_staging2
SET company               = NULLIF(company, 'NULL'),
    location              = NULLIF(location, 'NULL'),
    industry              = NULLIF(industry, 'NULL'),
    total_laid_off        = NULLIF(total_laid_off, 'NULL'),
    percentage_laid_off   = NULLIF(percentage_laid_off, 'NULL'),
#    `date`                = NULLIF(`date`, 'NULL'), done earlier
    stage                 = NULLIF(stage, 'NULL'),
    country               = NULLIF(country, 'NULL'),
    funds_raised_millions = NULLIF(funds_raised_millions, 'NULL');



SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL
;


UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = "";


SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = "";



SELECT st1.industry, st2.industry
FROM layoffs_staging2 st1
JOIN layoffs_staging2 st2
  ON st1.company = st2.company
WHERE (st1.industry IS NULL OR st1.industry = "")
AND st2.industry IS NOT NULL;

#same company, industry null fixing
UPDATE layoffs_staging2 st1
JOIN layoffs_staging2 st2
  ON st1.company = st2.company
SET st1.industry = st2.industry
WHERE (st1.industry IS NULL OR st1.industry = "")
AND st2.industry IS NOT NULL;

#check
SELECT *
FROM layoffs_staging2
WHERE company = "Airbnb";




DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT * 
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;









