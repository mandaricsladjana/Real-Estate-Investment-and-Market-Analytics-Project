/****** Object:  View [dbo].[vw_HousingMasterData]    Script Date: 7.8.2026. 17:53:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[vw_HousingMasterData] AS
SELECT 
    h.*,

    -- Data Quality by Month
    YEAR(h.SaleDateConverted) AS SaleYear,
    MONTH(h.SaleDateConverted) AS SaleMonth,
    DATENAME(MONTH, h.SaleDateConverted) AS MonthName,
    FORMAT(h.SaleDateConverted, 'yyyy-MM') AS YearMonth,

    -- Data Quality by City
    UPPER(LTRIM(RTRIM(REPLACE(h.PropertyCitySplit, CHAR(160), '')))) AS City,

 -- Completeness % by Record Category - Missing Data Importance
    CASE 
        WHEN 
            SalePrice IS NULL
            OR TotalValue IS NULL
            OR Acreage IS NULL 
        THEN 'Critical'

        WHEN LandValue IS NULL
            OR UniqueID IS NULL
            OR OwnerName IS NULL
            OR BuildingValue IS NULL 
            OR SaleDateConverted IS NULL
            OR TaxDistrict IS NULL
        THEN 'Important'

        WHEN LegalReference IS NULL
            OR SoldAsVacant IS NULL   
            OR LandUse IS NULL
            OR YearBuilt IS NULL 
        THEN 'Minor'
        ELSE 'Clean'
        END AS DataQualityFlag,

-- Data Quality by City
    m.Latitude,
    m.Longitude

FROM [dbo].[vw_HousingDataCLEAN] h

LEFT JOIN LocationMapping m
  ON UPPER(LTRIM(RTRIM(REPLACE(h.PropertyCitySplit, CHAR(160), ''))))
   =
   UPPER(LTRIM(RTRIM(REPLACE(m.PropertyCitySplit, CHAR(160), ''))))
GO


sp_helptext 'dbo.vw_HousingMasterData'
EXEC sp_refreshview 'dbo.vw_HousingMasterData';