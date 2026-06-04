-- Data Cleaning

SELECT *
FROM layoffs;

CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT *
FROM layoffs_staging;

INSERT layoffs_staging
SELECT *
FROM layoffs;

SELECT *
FROM layoffs_staging;

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `total_laid_off` text,
  `date` text,
  `percentage_laid_off` text,
  `industry` text,
  `stage` text,
  `funds_raised` text,
  `country` text,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

INSERT INTO layoffs_staging2
SELECT company, location, total_laid_off, `date`, percentage_laid_off, industry,
stage, funds_raised, country,
ROW_NUMBER() OVER(
PARTITION BY company, location, total_laid_off, `date`, percentage_laid_off, industry,
stage, funds_raised, country) AS row_num
FROM layoffs_staging;

DELETE
FROM layoffs_staging2
WHERE row_num > 1;

SELECT *
FROM layoffs_staging2;

-- Standardizing Data

SELECT company, TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT *
FROM layoffs_staging2
WHERE country = 'UAE' OR country = 'United Arab Emirates';

UPDATE layoffs_staging2
SET country = 'United Arab Emirates'
WHERE country = 'UAE';

SELECT DISTINCT country
FROM layoffs_staging2;

SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

SELECT `date`
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

UPDATE layoffs_staging2
SET industry = NULL 
WHERE industry = '';

UPDATE layoffs_staging2
SET funds_raised = NULL 
WHERE funds_raised = '';

SELECT DISTINCT stage
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET stage = NULL 
WHERE stage = '';

SELECT COUNT(*)
FROM layoffs_staging2
WHERE percentage_laid_off = ''
AND total_laid_off = '';

DELETE 
FROM layoffs_staging2
WHERE percentage_laid_off = ''
AND total_laid_off = '';

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;