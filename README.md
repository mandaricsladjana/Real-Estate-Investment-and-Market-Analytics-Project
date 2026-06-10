<p align="center">
  <img src="assets/images/bannernew.png" alt="Portfolio Banner" width="100%">
</p>

# Real Estate Investment & Market Analytics Project (IN PROGRESS)

## 👋 Welcome

This is my first data analytics portfolio project, created to demonstrate practical skills in SQL and Power BI. The goal is to show the ability to work with real-world data by cleaning, transforming, and analyzing it to generate meaningful business insights.

The project focuses on real estate data analysis, including property valuation, city-level market performance, ROI evaluation, and investment categorization.
The main purpose of the project is to demonstrate the ability to work with a real-life dataset by cleaning, transforming, and analyzing it in order to give meaningful business insights and answer key analytical questions.

---

## 🔷 Tools Used

- SQL queries in SQL Server Management Studio (Data Cleaning & Analysis)  
- Power BI (Dashboards & Visualization)  
- GitHub (Documentation & Version Control)
- notion.com (KPI & visualization Planner Template /Downloadable/ ) - link
- medium.com (Article case study documenting) - link
- lucidcharts.com (Process flow visualization)

### SQL Skills Demonstrated

* SELECT, WHERE, GROUP BY
* CASE statements
* Aggregate functions
* Common Table Expressions (CTEs)
* Window functions
* Data quality validation
* Data preparation for BI reporting (VIEWS)

---

## 📁 Data Source

The dataset used in this project is the Nashville Housing dataset from Kaggle:
https://www.kaggle.com/datasets/tmthyjames/nashville-housing-data/data

This is a large and detailed real estate dataset that, despite requiring significant cleaning, provides a very strong foundation for a first analytical project due to its real-world complexity and variety of property attributes.

### Dataset Overview of key columns

| Column | Type | Description |
|---------|---------|---------|
| UniqueID | FLOAT | Unique property identifier |
| ParcelID | NVARCHAR | Property parcel reference |
| SalePrice | FLOAT | Final sale price of the property at transaction |
| OwnerName | NVARCHAR | Name of the current or registered property owner |
| Acreage | FLOAT | Size of the property in acres |
| LandValue | FLOAT | Assessed value of the land only (excluding structures) |
| BuildingValue | FLOAT |  Assessed value of buildings/structures on the property |
| TotalValue | FLOAT | Total assessed property value (land + building) |


---

## ⚙️ Project Workflow

The analysis follows an end-to-end data pipeline:

```text
Raw Dataset
    ↓
Data Exploration
    ↓
KPI & Visualization Planning
    ↓
SQL Data Cleaning & Validation
    ↓
SQL KPI Data Preparation
    ↓
Power BI Dashboard Development
    ↓
Insights & Recommendations
```
The workflow includes:

* Data exploration and understanding structure
* Cleaning and handling missing, duplicate, or inconsistent values
* Transforming data for analysis
* Deciding business questions to answer
* Defining KPIs such as ROI and property value categories
* Building interactive dashboards in Power BI to showcase results

---

## 🔷 Project Structure

The project is divided into two main components:

* Business Analysis – focusing on property performance, pricing trends, and investment insights
* Data Quality Assessment – ensuring the dataset is clean, consistent, and reliable for analysis

---

🔹 Data Quality Assessment

What was done:
- Handled missing values  
- Standardized categorical fields  
- Removed inconsistencies  
- Fixed data types  
- Created clean analysis-ready dataset
- Identified Invalid entries
- Visualized data quality report using Power BI dashboard 

SQL Scripts:
- [Data Cleaning Script](SQL/01_data_cleaning.sql)
- [Data Quality Checks](SQL/02_data_quality.sql)

(Screenshots coming soon):
- Raw vs cleaned data comparison
- Key SQL transformations

---

## 📊 KEY BUSINESS QUESTIONS

### ◻ Property Pricing
- How are property prices distributed across Nashville?
- What affects property value the most?

### ◻ Market Performance
- Which areas have the strongest property sales activity?
- How do prices vary by location?

### ◻ Investment Analysis
- Which properties generate the highest ROI?
- What defines a good investment property?

### ◻ Segmentation
- How can properties be grouped by investment potential?

---
  
## 📈 KPI Development

The following KPIs were created to support analysis:

- **ROI (Return on Investment)** – profitability measure of properties  
- **Property Value Categories** – segmentation into Low / Medium / High value  
- **City Performance Metrics** – comparison of market strength by location  

▫ Purpose:
To identify investment opportunities and evaluate property performance across regions.

---

## 📊 Power BI Dashboard

The final stage of this project was the development of an interactive Power BI dashboard to provide a clear overview of property performance, market trends, and investment opportunities across the Nashville real estate market. It allows viewers to explore the data dynamically through filters and visual interactions, enabling deeper analysis of specific regions, property types, and value ranges. These visualisations have played a key role in generating final conclusions from the analysis.

### Dashboard Pages:
- Data Quality Overview 
- Property Value Analysis  
- City Performance  
- Investment & ROI Analysis  

Dashboard Preview:

(screenshot coming soon)

---

## 🔷 Key Insights


<script>
window.TallyConfig = {
  "formId": "81rvjO",
  "popup": {
    "emoji": {
      "text": "👋",
      "animation": "wave"
    },
    "open": {
      "trigger": "time",
      "ms": 13000
    },
    "autoClose": 3000,
    "doNotShowAfterSubmit": true
  }
};
</script>

<script async src="https://tally.so/widgets/embed.js"></script>












