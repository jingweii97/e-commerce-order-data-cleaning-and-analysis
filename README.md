# E-Commerce Order Data Cleaning and Analysis

## Project Overview
Performing ETL on various source of data to gain insights on the sales performance, biggest pain point is the non-standardized order data from different platform and lack of product information from order income. The goal is to standardize this data using Python, store it in a SQL database, and use various JOINs and queries, SQL views and procedures to extract key business metrics such as income and costs.

## Project Structure

- **/notebooks/**: Contains Jupyter notebooks for cleaning and transforming raw data exported from marketplaces.
   - **/data/**: Sample data used for testing the notebooks and SQL queries.
- **/sql/**: SQL scripts used to create, validate, and update data in the `Kaizen_db` database.


## Workflow
1. **Python for Data Standardization**: 
   - Python scripts are used to clean and standardize raw income data from different marketplaces using Pandas.
   - Cleaned data is written to the SQL database.

2. **SQL Database**:
   - MSSQL database with tables for Shopee_Income, Lazada_Income, OrderData, and SkuMaster.
   - SQL scripts are provided for creating tables, views, and stored procedures.

## How to Run
1. **Clone the repository**:
   ```
   git clone https://github.com/jingweii97/e-commerce-order-data-cleaning-and-analysis.git
   ```

2. **Set up the Python environment**:
   ```
   pip install -r requirements.txt
   ```

3. **Run Python Scripts**:
   Use the provided Python scripts to clean data and push it to the SQL database.

4. **Load SQL Tables and Views**:
   Execute the SQL scripts provided in the `sql` directory to create tables and views.

## Tech Stack
- **Python** (with Pandas) for data cleaning and transformation
- **MSSQL** for database management and querying



