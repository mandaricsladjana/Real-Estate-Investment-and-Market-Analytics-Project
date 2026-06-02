# Real-Estate-Investment-and-Market-Analytics-Project

## A Data Analytics portfolio project created to practice and showcase skills in analytical tools such as SQL, Excel, and Power BI. 

The main purpose of the project is to demonstrate the ability to work with real-life dataset by cleaning, transforming, and analyzing it in order to generate meaningful business insights and answer key analytical questions.

This project analyzes the Nashville Housing dataset using SQL and Power BI, combining data cleaning, property valuation analysis, city-level market performance, ROI calculations, and investment categorization to identify high-value real estate opportunities and generate actionable business insights.

The project follows an end-to-end data workflow, starting from raw data exploration, followed by data cleaning and adjustment (handling missing values, correcting inconsistencies, and filtering invalid records), then moving into data transformation and KPI creation, and finally visualizing results in Power BI to support data-driven decision-making.

```markdown id="fix1"
## Project Workflow

```mermaid
flowchart LR

A[Raw Data] --> B[Data Exploration]
B --> C[Business Questions Definition]
C --> D[Data Quality Assessment]
D --> E[SQL Data Cleaning]
E --> F[KPI Development ROI Property Value City Performance]
F --> G[Power BI Dashboard]
G --> H[Insights & Conclusions]






The Project is divided into two key components: 

* BUSINESS ANALYSIS/ focused on real estate and investment insights
* DATA QUALITY ASSESMENT/ ensuring the dataset is reliable, cleaned, and in a format suitable for analysis

## Data Quality Assessment Questions

Before performing any analysis, the dataset was evaluated to ensure accuracy, consistency, and reliability. The following questions were used to guide the data quality assessment:

### 1. Missing Data
- Which columns contain missing or null values?
- How significant is the amount of missing data in key fields?
- Does missing data affect the reliability of pricing or ROI analysis?

### 2. Data Consistency
- Are there inconsistencies in categorical fields (e.g., SoldAsVacant values)?
- Are all property records formatted consistently across the dataset?
- Do any fields contain incorrect or unexpected values?

### 3. Data Validity
- Are there any unrealistic or invalid values (e.g., zero or negative prices)?
- Are numerical fields (e.g., Bedrooms, YearBuilt) within logical ranges?
- Do property values align logically (LandValue + BuildingValue ≈ TotalValue)?

### 4. Data Completeness Impact
- How does missing or inconsistent data impact KPI calculations?
- Which variables had to be cleaned or transformed before analysis?
- What assumptions were made during data cleaning?
  
## KEY BUSINESS QUESTIONS

This analysis was designed to answer the following business questions related to property performance, market trends, and investment potential in the Nashville real estate market:

### 5. Data Quality & Integrity
- What is the extent of missing or inconsistent data in the dataset?
- Which fields have the highest data quality issues?
- How does data cleaning impact the reliability of the analysis results?
- 
### 1. Property Value & Pricing
- How are property sale prices distributed across different areas of Nashville?
- What is the relationship between land value, building value, and total property value?
- Which property characteristics (size, bedrooms, year built) influence higher sale prices?

### 2. City / Area Performance
- Which areas or tax districts have the highest property sales activity?
- How does average property value vary across different locations?
- Which regions show the strongest real estate market performance?

### 3. Investment Performance (ROI Analysis)
- Which properties generate the highest estimated return on investment?
- What is the distribution of ROI across the dataset?
- Which property types or categories represent the best investment opportunities?

### 4. Property Classification & Segmentation
- How can properties be grouped based on investment potential (low, medium, high value)?
- What characteristics define high-value vs low-value investment properties?
- Are there patterns in property features that indicate strong investment potential?

