# Real Estate Investment & Market Analytics Project


## Dataset Overview

| Column | Type | Description |
|---------|---------|---------|
| UniqueID | FLOAT | Unique property identifier |
| ParcelID | NVARCHAR | Property parcel reference |
| LandUse | NVARCHAR | Type of land usage (e.g., residential, commercial, industrial) |
| SalePrice | FLOAT | Final sale price of the property at transaction |
| LegalReference | NVARCHAR | Official legal document or reference ID for the sale |
| SoldAsVacant | NVARCHAR | Indicates whether the property was sold as vacant land or with structures |
| OwnerName | NVARCHAR | Name of the current or registered property owner |
| Acreage | FLOAT | Size of the property in acres |
| TaxDistrict | NVARCHAR | Tax jurisdiction area where the property is located |
| LandValue | FLOAT | Assessed value of the land only (excluding structures) |
| BuildingValue | FLOAT |  Assessed value of buildings/structures on the property |
| TotalValue | FLOAT | Total assessed property value (land + building) |
| YearBuilt | FLOAT | Year the main structure on the property was built |
| Bedrooms | FLOAT | Number of bedrooms in the property |
| FullBath | FLOAT | Number of full bathrooms (toilet, sink, shower/bath) |
| Halfbath | FLOAT | Number of half bathrooms (typically toilet + sink only) |


## Query Catalog

This document lists all SQL queries used in the project.
---

## 1. Data Cleaning

*1*
- **File:** [01_data_cleaning.sql](queries/01_data_cleaning.sql)
- **Purpose:** 
    *Cleaned and standardized DATETIME column by eliminating timestamp values (converted to DATA format) and updating the dataset to maintain consistent date formatting.*

ALTER TABLE [Nashwile Housing Portfolio Project].[dbo].[NashvilleHousing]
ADD SaleDateConverted DATE;

UPDATE [Nashwile Housing Portfolio Project].[dbo].[NashvilleHousing]
SET SaleDateConverted = CONVERT(DATE, SaleDate);
---

*2*
- **File:** [01_data_cleaning.sql](queries/01_data_cleaning.sql)
- **Purpose:** 
   *Filled missing PropertyAddress values by matching records with identical ParcelID values as a reference key using self JOINS and ISNULL.*

SELECT
    a.ParcelID,
    a.PropertyAddress,
    b.ParcelID,
    b.PropertyAddress
FROM [Nashwile Housing Portfolio Project].[dbo].[NashvilleHousing] a
JOIN [Nashwile Housing Portfolio Project].[dbo].[NashvilleHousing] b
    ON a.ParcelID = b.ParcelID
    AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL;

Update a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM [Nashwile Housing Portfolio Project].[dbo].[NashvilleHousing] a
JOIN [Nashwile Housing Portfolio Project].[dbo].[NashvilleHousing] b
    ON a.ParcelID = b.ParcelID
    AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL; 
---

*3*
- **File:** [01_data_cleaning.sql](queries/01_data_cleaning.sql)
- **Purpose:** 
   *Split PropertyAddress into separate address and city columns using SQL string functions (SUBSTRING/CHARINDEX) to improve data structure and usability.*

SELECT 
    SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1),
    SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress))
FROM [Nashwile Housing Portfolio Project].[dbo].[NashvilleHousing] 


ALTER TABLE [Nashwile Housing Portfolio Project].[dbo].[NashvilleHousing] 
ADD PropertyAddressSplit NVARCHAR(100);

UPDATE [Nashwile Housing Portfolio Project].[dbo].[NashvilleHousing] 
SET PropertyAddressSplit = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1);


ALTER TABLE [Nashwile Housing Portfolio Project].[dbo].[NashvilleHousing] 
ADD PropertyCitySplit NVARCHAR(100);

UPDATE [Nashwile Housing Portfolio Project].[dbo].[NashvilleHousing] 
SET PropertyCitySplit = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress));
---

   *Split the OwnerAddress into separate columns - street address, city, and state to normalize and structure data for easier analysis.[replaced delimiters (',' to '.')|PARSENAME function]*

SELECT
    PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
    PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
    PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
FROM [Nashwile Housing Portfolio Project].[dbo].[NashvilleHousing];


ALTER TABLE [Nashwile Housing Portfolio Project].[dbo].[NashvilleHousing] 
ADD OwnerAddressSplit NVARCHAR(100);

UPDATE [Nashwile Housing Portfolio Project].[dbo].[NashvilleHousing] 
SET OwnerAddressSplit = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3);


ALTER TABLE [Nashwile Housing Portfolio Project].[dbo].[NashvilleHousing] 
ADD OwnerCitySplit NVARCHAR(100);

UPDATE [Nashwile Housing Portfolio Project].[dbo].[NashvilleHousing] 
SET OwnerCitySplit = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2);


ALTER TABLE [Nashwile Housing Portfolio Project].[dbo].[NashvilleHousing] 
ADD OwnerStateSplit NVARCHAR(100);

UPDATE [Nashwile Housing Portfolio Project].[dbo].[NashvilleHousing] 
SET OwnerStateSplit = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1); 
---

*4*
- **File:** [01_data_cleaning.sql](queries/01_data_cleaning.sql)
- **Purpose:** 
   *Standardized the SoldAsVacant field by replacing abbreviated values (“Y”, “N”) with full descriptive labels (“Yes”, “No”) for better readability.*

SELECT DISTINCT(SoldAsVacant)
FROM [Nashwile Housing Portfolio Project].[dbo].[NashvilleHousing];

SELECT
    SoldASVacant,
    CASE
    WHEN SoldAsVacant = 'N' THEN 'No'
    WHEN SoldAsVacant = 'Y' THEN 'Yes'
    ELSE SoldAsVacant
    END
FROM [Nashwile Housing Portfolio Project].[dbo].[NashvilleHousing];

UPDATE [Nashwile Housing Portfolio Project].[dbo].[NashvilleHousing]
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'N' THEN 'No'
    WHEN SoldAsVacant = 'Y' THEN 'Yes'
    ELSE SoldAsVacant
    END;
---

*5*
- **File:** [01_data_cleaning.sql](queries/01_data_cleaning.sql)
- **Purpose:** 
    *Identified and removed duplicate records by using the ROW_NUMBER() window function to assign unique row rankings within grouped data, ensuring only one record was retained per duplicate set.*
    *Tested and validated query result & safely executed changes within a controlled environment [BEGIN TRAN|COMMIT], allowing verification of results before permanently applying updates to the dataset.*

BEGIN TRAN;

WITH RowNumTemp AS(
   SELECT 
       *,
       ROW_NUMBER() OVER(
       PARTITION BY ParcelID,
       PropertyAddress,
       SalePrice,
       SaleDate,
       LegalReference
       ORDER BY UniqueID
        ) AS row_num
    FROM [Nashwile Housing Portfolio Project].[dbo].[NashvilleHousing]
)
DELETE
FROM RowNumTemp
WHERE row_num > 1;
 
COMMIT; 
---

*5*
- **File:** [01_data_cleaning.sql](queries/01_data_cleaning.sql)
- **Purpose:** 
    *Deleted unnecessary columns (the original columns after transforming and splitting their data into separate columns) ensuring a cleaner and more efficient dataset. Results validated before data deletion*

BEGIN TRANSACTION;

ALTER TABLE [Nashwile Housing Portfolio Project].[dbo].[NashvilleHousing]
DROP COLUMN 
    OwnerAddress,
    PropertyAddress, 
    SaleDate;

 COMMIT;


## 4. CASE Statements
*1*
- **File:** [04_case_statements.sql](queries/04_case_statements.sql)
- **Purpose:** Categorize products into Low / Medium / High price groups for easier filtering.
