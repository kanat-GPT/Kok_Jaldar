# K .JALDAR — AI Text-to-SQL Agent for E-commerce

**Final Project · Databases Course 2025 · Lecturer: Nargiza Zhumalieva**


**1st presentations link: https://www.canva.com/design/DAG5g5fJvSI/-yB799S38ei6-kn8VBERmA/edit?utm_content=DAG5g5fJvSI&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton**
**2nd presentation link : https://www.canva.com/design/DAG54gzrnZo/ymaoFgNuVNZt6vQI-gHu3w/edit?utm_content=DAG54gzrnZo&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton**

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
1️⃣ Analyze Marketing
We need to understand which countries to invest marketing budget in.

2️⃣ Segment customers by behavior.
Group customers (regulars, rare buyers, wholesalers) and find out who contributes the most to revenue.

3️⃣ Analyze seasonality and sales patterns over time.
Discover which months, weekdays, or hours have the highest and lowest sales.

4️⃣ Giant identification. Need to identify top customers by LTV who generate the most revenue and give them discounts/VIP status.





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
- 

- ## Role: SQL Developer – Azimbai (@yaxaxaw)

- Implemented full 7-table schema exactly according to the ER diagram  
  (Countries → Customers → Orders → Order_Items → Products → Categories → Payments)
- Wrote automated Python normalization script  
  → transforms original 541 909-row CSV into 7 clean tables
- Populated the database (all required tables exceed 1 000 rows):
  - Order_Items 
  - Customers   
  - Products     
  - Orders       
  - Payments
    
- Created script for create tables     
- Created 7 performance indexes
- Provided complete DDL:
  - `sql/create_tables.sql`
  - `sql/indexes.sql`
  - `sql/normalization_script.py` + 7 ready-to-import CSVs
- Successfully loaded and verified everything in MySQL Workbench
  
SQL Developer role — completed 


## Role: AI Engenner - Emirkhan

## My Responsibilities :
 Connecting MySQL database to Python (Jupyter Notebook)
 Setting up LangChain environment + Gemini LLM
 Implementing a text-to-SQL AI agent
 Automating SQL query generation from natural language
 Solve all 4 business problems with the help of an AI agent.
 Creating analytical VIEWs based on AI-generated insights.


 ## What I actually did :
 Connected to our final MySQL database delivered by azimbay kokjal
 Checked the tables, relationships, and overall structure
 Looked through the data to understand how everything is linked
 Prepared database context so the AI could understand the schema
 Turned business questions into clear analytical tasks

 Ai Engineer role — completed !

 







