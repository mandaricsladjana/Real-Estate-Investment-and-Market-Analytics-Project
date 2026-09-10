/****** Object:  View [dbo].[vw_HousingDataCLEAN]    Script Date: 7.8.2026. 16:32:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



ALTER VIEW [dbo].[vw_HousingDataCLEAN] AS

WITH CleanedData AS
  (
    SELECT
        [UniqueID],
        [ParcelID],
        [LandUse],
        [SalePrice],
        [LegalReference],
        [OwnerName],
        [Acreage],
        [TaxDistrict],
        [LandValue],
        [BuildingValue],
        [TotalValue],
        [YearBuilt],
        [Bedrooms],
        [FullBath],
        [HalfBath],

-- DATE CLEANING
        CAST(SaleDate AS date) AS SaleDateConverted,

-- SOLD AS VACANT CLEANING
        CASE 
            WHEN SoldAsVacant = 'N' THEN 'No'
            WHEN SoldAsVacant = 'Y' THEN 'Yes'
            ELSE SoldAsVacant
        END AS SoldAsVacant,

-- PROPERTY ADDRESS
   -- Keep the original address if available - If it is NULL, use an address from another row with the same ParcelID

        COALESCE(
            h.PropertyAddress,
            p.PropertyAddress
        ) AS PropertyAddress,

-- PROPERTY ADDRESS CLEANING
        LEFT(
            COALESCE(h.PropertyAddress, p.PropertyAddress),
            CHARINDEX(
                ',',
                COALESCE(h.PropertyAddress, p.PropertyAddress) + ','
            ) - 1
        ) AS PropertyAddressSplit,

     LTRIM(
            SUBSTRING(
                COALESCE(h.PropertyAddress, p.PropertyAddress),
                CHARINDEX(
                    ',',
                    COALESCE(h.PropertyAddress, p.PropertyAddress) + ','
                ) + 1,
                100
            )
        ) AS PropertyCitySplit,

-- OWNER ADDRESS CLEANING
        LEFT(
            h.OwnerAddress,
            CHARINDEX(',', h.OwnerAddress + ',') - 1
        ) AS OwnerAddressSplit,

PARSENAME(
            REPLACE(h.OwnerAddress, ',', '.'),
            2
        ) AS OwnerCitySplit,

PARSENAME(
            REPLACE(h.OwnerAddress, ',', '.'),
            1
        ) AS OwnerStateSplit

FROM dbo.Stg_HousingRaw h

-- FIND A PROPERTY ADDRESS FROM ANOTHER ROW WITH THE SAME PARCEL ID
    OUTER APPLY
    (
        SELECT TOP 1
            h2.PropertyAddress
        FROM dbo.Stg_HousingRaw h2
        WHERE h2.ParcelID = h.ParcelID
          AND h2.UniqueID <> h.UniqueID
          AND h2.PropertyAddress IS NOT NULL
    ) p
),

QualityChecks AS
(
    SELECT
        *,
-- VALIDATION CHECK
        CASE
WHEN SalePrice <= 0 
                THEN 'Invalid SalePrice'
WHEN TotalValue <= 0 
                THEN 'Invalid TotalValue'
WHEN BuildingValue < 0
                THEN 'Invalid BuildingValue'
WHEN LandValue <= 0
                THEN 'Invalid LandValue'
WHEN Acreage <= 0
                THEN 'Invalid Acreage'
WHEN SaleDateConverted > CAST(GETDATE() AS DATE)
                THEN 'Future SaleDate'
WHEN SaleDateConverted < '1900-01-01'
                THEN 'Very Old SaleDate'
WHEN OwnerName IN ('N/A','NA','Unknown','?','0','None')
                THEN 'Invalid OwnerName'
WHEN ParcelID IN ('N/A','NA','Unknown','?','0','None')
                THEN 'Invalid ParcelID'
WHEN LandUse IN ('N/A','NA','Unknown','?','0','None')
                THEN 'Invalid LandUse'
WHEN LegalReference IN ('N/A','NA','Unknown','?','0','None')
                THEN 'Invalid LegalReference'
WHEN SoldAsVacant IN ('N/A','NA','Unknown','?','0','None')
                THEN 'Invalid SoldAsVacant'
WHEN TaxDistrict IN ('N/A','NA','Unknown','?','0','None')
                THEN 'Invalid TaxDistrict'
WHEN LEN(TaxDistrict) < 10
                THEN 'Short TaxDistrict'
WHEN LEN(LegalReference) < 16
                THEN 'Short LegalReference'
WHEN LEN(OwnerName) < 5
                THEN 'Short OwnerName'
WHEN PropertyAddressSplit IN ('N/A','NA','Unknown','?','0','None')
                THEN 'Invalid PropertyAddress'
WHEN PropertyCitySplit IN ('N/A','NA','Unknown','?','0','None')
                THEN 'Invalid PropertyCity'
WHEN OwnerAddressSplit IN ('N/A','NA','Unknown','?','0','None')
                THEN 'Invalid OwnerAddress'
WHEN OwnerCitySplit IN ('N/A','NA','Unknown','?','0','None')
                THEN 'Invalid OwnerCity'
ELSE 'Valid Entry'
END AS DataValidationStatus,
-- ANOMALY CHECK
        CASE
WHEN SalePrice < TotalValue * 0.1
                THEN 'Extreme Undervaluation'
WHEN SalePrice > TotalValue * 3
                THEN 'Extreme Overvaluation'
WHEN SalePrice < 1000
                THEN 'Suspiciously Low Sale Price'
WHEN TotalValue > 10000000
                THEN 'Ultra High Value Property'
ELSE 'Normal Market Behavior'
END AS SaleValueAnomalyFlag
FROM CleanedData
)
SELECT
*,
-- FINAL ANOMALY STATUS
    CASE
        WHEN SaleValueAnomalyFlag = 'Normal Market Behavior'
            THEN 'No Anomaly'
        ELSE 'Anomaly Detected'
    END AS AnomalyStatus
FROM QualityChecks;

GO





SELECT 
    COLUMN_NAME,
    LEN(COLUMN_NAME) AS NameLength,
    DATALENGTH(COLUMN_NAME) AS ByteLength
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'vw_HousingDataClean';