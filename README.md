# K .JALDAR — AI Text-to-SQL Agent for E-commerce

**Final Project · Databases Course 2025 · Lecturer: Nargiza Zhumalieva**


## Team Members
| Role            | Name              | GitHub           |
|-----------------|-------------------|------------------|
| DB Architect    | Kanat             | @kanat-GPT       |
| DB Analyst      | Beksultan         | @user1919191919  |
| SQL Developer   | Azimbai           | @yaxaxaw         |
| AI Engineer     | Emirkhan          | @emirkhanq       |

## Dataset
**Online Retail Transaction Data**  
[Link to Kaggle](https://www.kaggle.com/datasets/thedevastator/online-retail-transaction-data)  
541,909 real transactions (UK online store, 2010–2011)  
→ Normalized into 6+ relational tables

## Business Problems (Problem Statement)
1️⃣ Identify the most profitable categories and products.
Determine which categories and items generate the highest revenue and which ones perform poorly.

2️⃣ Segment customers by behavior.
Group customers (regulars, rare buyers, wholesalers) and find out who contributes the most to revenue.

3️⃣ Analyze seasonality and sales patterns over time.
Discover which months, weekdays, or hours have the highest and lowest sales.

4️⃣ Analyze payments and forecast revenue.
Identify the most used payment types and build a revenue forecast for the next month.


## Project Structure
├── ER_diagram/          ER diagram (PNG + source)

├── sql/                 create_tables.sql, views.sql, indexes

├── data/                online_retail.csv

├── notebook/            Online_Retail_Text_to_SQL_Agent.ipynb

├── docs/                Technical Report + Presentation slides

├── screenshots/         Agent demo GIFs

├── requirements.txt

└── .env.example




 
## Role: DB Analyst  Akmatbek uulu Beksultan
Date: November 2025  

## What I Delivered 

1. Took one huge CSV → 541 909 rows  
2. Normalized to 3NF  
3. Created 7 clean tables (exceeded the minimum of 5)  
4. Drew complete ER diagram with PK, FK and relationship types    
5. Separated payments into its own table – ready for future extensions  

## Final Database Structure – 7 Tables

| Table         | Purpose                                         | Connected to                  |
|---------------|-------------------------------------------------|-------------------------------|
| Countries     | Country reference                               | ← Customers                   |
| Customers     | Customers + country                             | → Orders                      |
| Categories    | Product categories                              | ← Products                    |
| Products      | Items (StockCode + Description)                 | → Order_Items                 |
| Orders        | Orders (date, invoice, customer)                | → Order_Items, → Payments     |
| Order_Items   | Order lines (quantity × unit price)             | –                             |
| Payments      | Payment amount per order (separate entity)      | ← Orders (currently 1:1)      |

## Why This Design?

- No duplication: country, category, product description stored only once  
- Payments in separate table → ready for partial payments, refunds, multiple transactions later  
- All relationships via FOREIGN KEY constraints  

## Repository Files

- ER_Diagram.png – full schema with PK/FK and cardinalities  

