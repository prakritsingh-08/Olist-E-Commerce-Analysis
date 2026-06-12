# 🛒 Olist E-Commerce Business Analysis

![Python](https://img.shields.io/badge/Python-3.x-blue?logo=python&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-336791?logo=postgresql&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?logo=powerbi&logoColor=black)
![Pandas](https://img.shields.io/badge/Pandas-Data%20Cleaning-150458?logo=pandas&logoColor=white)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen)

> **End-to-end data analytics project** on the Olist Brazilian E-Commerce dataset — covering data cleaning in Python, business analysis in SQL (36 queries), and an interactive Power BI dashboard.

---

## 📋 Table of Contents

- [Project Overview](#-project-overview)
- [Dataset](#-dataset)
- [Tech Stack](#-tech-stack)
- [Project Workflow](#-project-workflow)
- [Data Cleaning Summary](#-data-cleaning-summary)
- [SQL Analysis Highlights](#-sql-analysis-highlights)
- [Key Insights](#-key-insights)
- [Business Recommendations](#-business-recommendations)
- [Power BI Dashboard](#-power-bi-dashboard)
- [Project Structure](#-project-structure)
- [How to Run](#-how-to-run)
- [Author](#-author)

---

## 📌 Project Overview

| Attribute | Detail |
|-----------|--------|
| **Project Title** | Olist E-Commerce Business Analysis |
| **Analyst** | Prakrit Singh |
| **Period** | 01 June 2026 – 09 June 2026 |
| **Dataset Source** | [Kaggle — Olist Brazilian E-Commerce Public Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) |

**Objective:** Clean, transform, and analyze the Olist multi-table e-commerce dataset to answer key business questions and deliver actionable insights via SQL queries and a Power BI dashboard.

**Business Problem:** Olist is a Brazilian e-commerce marketplace connecting small merchants to customers across Brazil. Despite millions of transactions, the business lacked consolidated visibility into:
- Revenue trends and top-performing product categories
- Customer behavior and satisfaction drivers
- Seller performance disparities
- Logistics efficiency and delivery impact on reviews

---

## 📦 Dataset

The dataset consists of **7 interlinked tables** sourced from Kaggle:

| Table | Description | Clean Rows | Clean Columns |
|-------|-------------|------------|---------------|
| `customers` | Customer profile & location | 99,441 | 4 |
| `orders` | Order lifecycle & timestamps | 99,441 | 6 |
| `order_items` | Line items per order | 112,650 | 6 |
| `payments` | Payment method & value | 103,886 | 4 |
| `products` | Product catalogue & categories | 32,951 | 2 |
| `reviews` | Customer review scores | 99,224 | 3 |
| `sellers` | Seller profile & location | 3,095 | 3 |

> Total data volume: ~550K+ rows across all tables (~47.7 MB compressed)

---

## 🛠 Tech Stack

| Tool | Purpose |
|------|---------|
| **Python** (Pandas, NumPy) | Data loading, cleaning, transformation, export |
| **Matplotlib / Seaborn** | Exploratory visualizations |
| **SQLAlchemy + psycopg2** | Python → PostgreSQL database connection |
| **PostgreSQL 15** | SQL-based business analysis (36 queries) |
| **Power BI Desktop** | Interactive dashboard & KPI reporting |

---

## 🔄 Project Workflow

```
Raw CSVs (Kaggle)
      │
      ▼
Python / Pandas ──► Data Profiling ──► Cleaning ──► Export Clean CSVs
      │
      ▼
SQLAlchemy ──► PostgreSQL (olist_db)
      │
      ▼
36 SQL Queries ──► Business Insights
      │
      ▼
Power BI Dashboard ──► Interactive Reporting
```

**Step-by-step pipeline:**

1. Raw data ingestion — 7 CSV files imported from Kaggle
2. Data profiling — shape, dtypes, nulls, duplicates checked per table
3. Column removal — irrelevant columns dropped across all tables
4. Data type correction — timestamp columns converted from `object` to `datetime`
5. Null handling — strategic fill (`'unknow'`) or intentional retention
6. Export to clean CSV — all 7 tables saved
7. Database load — clean data pushed to PostgreSQL via SQLAlchemy
8. SQL Analysis — 36 business questions answered
9. Power BI — interactive dashboard created from DB connection

---

## 🧹 Data Cleaning Summary

| Table | Key Cleaning Actions |
|-------|---------------------|
| `customers` | Dropped `customer_zip_code_prefix` (redundant) |
| `orders` | Converted 3 timestamp columns to `datetime`; dropped 2 high-null columns |
| `products` | Reduced from 9 → 2 columns; filled 610 null category names with `'unknow'` |
| `payments` | Dropped `payment_sequential` (no analytical value) |
| `reviews` | Dropped 4 columns (88% null in comment title, 59% in comment message) |
| `sellers` | Dropped `seller_zip_code_prefix` (redundant) |
| `order_items` | Dropped `shipping_limit_date` (not required for analysis) |

**Result:** Zero analytical nulls across all tables after cleaning.

---

## 🔍 SQL Analysis Highlights

A total of **36 SQL queries** were written covering:
- Basic metrics (counts, totals, averages)
- Multi-table JOIN analysis
- Time-series trends
- Window functions (LAG, SUM OVER)
- Advanced business analysis

### Key Query Results

| Business Question | Result |
|-------------------|--------|
| Total Revenue | **R$ 13,591,643.70** |
| Total Orders | **99,441** |
| Total Customers | **99,441** |
| Total Sellers | **3,095** |
| Avg Order Value | **R$ 137.75** |
| Delivery Success Rate | **97%** |
| Avg Review Score | **4.07 / 5** |
| Top Payment Method | **Credit Card (74%)** |
| Top Revenue State | **São Paulo — R$ 5.2M (38%)** |
| Top Revenue Category | **beleza_saude — R$ 1.26M** |
| YoY Revenue Growth | **+20% (2017 → 2018)** |
| Fastest Delivery Month | **August (avg 8 days)** |
| Delivery vs Reviews | **5-star = 10 days | 1-star = 20 days** |

---

## 💡 Key Insights

### Revenue & Business Performance
- Total platform revenue of **R$13.59M** across 99,441 orders
- Revenue grew **20% from 2017 (R$6.16M) to 2018 (R$7.39M)**
- **São Paulo contributes 38%** of total customer revenue
- Credit card drives **77% of revenue (R$12.72M)**
- Top 3 revenue categories: `beleza_saude`, `relogios_presentes`, `cama_mesa_banho`

### Customer Satisfaction & Delivery
- Average review score: **4.07/5**
- Clear delivery-review correlation: **5-star orders delivered in 10 days vs 1-star in 20 days**
- **97% order delivery success rate** — only 0.6% cancelled
- August = fastest avg delivery (8 days); February = slowest (15 days)

### Seller Performance
- Top seller (Guariba) generated **R$249,640 — 80x more than the bottom seller**
- São Paulo state generates the most seller revenue (**R$8.75M**)
- 3,095 sellers serve 99,441 customers (~32 customers/seller on average)

### Risk Areas
- 3 high-revenue categories have review scores **below 4.0** — quality gap risk
- Delivery times in Q1 (Jan–Feb) and Q4 (Nov–Dec) are significantly longer
- September shows a sudden **55% revenue drop** — possible dataset cutoff or seasonal effect
- Bottom 10 sellers earn under **R$25** — performance disparity is massive

---

## 📊 Business Recommendations

| Priority | Recommendation | Expected Impact |
|----------|---------------|-----------------|
| 🔴 HIGH | Launch delivery improvement initiative in Q1 & Q4 — target under 12 days avg | Increase review scores by 0.3–0.5 points |
| 🔴 HIGH | Introduce quality standards for `cama_mesa_banho` & `informatica_acessorios` sellers | Protect R$2M+ in at-risk revenue |
| 🟡 MED | Run targeted marketing campaigns in Sep–Oct to fill seasonal gap | Potential R$300–400K additional revenue |
| 🟡 MED | Create seller performance tiers — reward top, support bottom sellers | Improve marketplace average revenue |
| 🟡 MED | Offer loyalty rewards for Monday shoppers (peak day: 16,196 orders) | Sustain high weekday order volume |
| 🟢 LOW | Expand boleto & debit card promotions | Increase transaction volume by 5–10% |
| 🟢 LOW | Open marketing campaigns targeting RJ, MG, RS states | Diversify revenue concentration from SP |

### Growth Opportunities
- Expand into underserved states (AC, AP, RR — under R$20K each)
- Weekend promotions & flash sales to boost Sat/Sun order volumes by 10–15%
- `relogios_presentes` (4.02 score, R$1.21M revenue) — prime candidate for premium promotion
- Strong 20% YoY growth signals: **now is the time to scale seller onboarding**

---

## 📈 Power BI Dashboard

The dashboard was built in **Power BI Desktop** connected directly to the PostgreSQL `olist_db` database.

**KPIs tracked:** Total Revenue · Total Orders · Total Customers · Total Sellers · Avg Order Value · Avg Review Score · Total Products · Delivery Rate

**Visuals included:**
- Revenue by Product Category (Bar Chart)
- Monthly Revenue Trend (Line Chart)
- Order Status Distribution (Pie Chart)
- Payment Method Analysis (Bar Chart)
- Revenue by Brazilian State (Map/Bar)
- Review Score Distribution
- Delivery Time vs Review Score
- Top 10 Sellers by Revenue
- Year-over-Year Revenue (Column Chart)
- High Revenue / Low Score Categories (Scatter Plot)

**Filters/Slicers:** Product Category · Customer State · Payment Type · Order Status · Year / Month

---

## 📁 Project Structure

```
olist-ecommerce-analysis/
│
├── data/
│   ├── raw/                    # Original Kaggle CSV files
│   └── clean/                  # Cleaned CSV files (output of Python)
│       ├── clean_customers.csv
│       ├── clean_orders.csv
│       ├── clean_order_items.csv
│       ├── clean_payments.csv
│       ├── clean_products.csv
│       ├── clean_reviews.csv
│       └── clean_sellers.csv
│
├── notebooks/
│   └── olist_cleaning.ipynb    # Data profiling & cleaning (Python/Pandas)
│
├── sql/
│   └── olist_queries.sql       # All 36 business SQL queries
│
├── dashboard/
│   └── olist_dashboard.pbix    # Power BI dashboard file
│
├── report/
│   └── Olist_Report_Final.pdf  # Full project report
│
└── README.md
```

---

## ▶️ How to Run

### 1. Clone the Repository
```bash
git clone https://github.com/your-username/olist-ecommerce-analysis.git
cd olist-ecommerce-analysis
```

### 2. Install Python Dependencies
```bash
pip install pandas numpy matplotlib seaborn sqlalchemy psycopg2-binary
```

### 3. Run Data Cleaning Notebook
Open `notebooks/olist_cleaning.ipynb` in Jupyter and run all cells. This will:
- Profile all 7 raw tables
- Clean and transform the data
- Export 7 clean CSV files to `data/clean/`
- Load data into PostgreSQL (`olist_db`)

### 4. Set Up PostgreSQL Database
Make sure PostgreSQL is running locally on `localhost:5432`.
```sql
CREATE DATABASE olist_db;
```
Update the connection string in the notebook if needed:
```python
engine = create_engine("postgresql://postgres:your_password@localhost:5432/olist_db")
```

### 5. Run SQL Queries
Open `sql/olist_queries.sql` in your PostgreSQL client (pgAdmin, DBeaver, etc.) and execute the queries.

### 6. Open Power BI Dashboard
Open `dashboard/olist_dashboard.pbix` in Power BI Desktop and refresh the data connection to your local PostgreSQL instance.

---

## 👤 Author

**Prakrit Singh** — Data Analyst

> *"This project demonstrates my ability to work across the full data analyst stack: data cleaning in Python, business analysis in SQL, and storytelling with Power BI."*

---

⭐ **If you found this project useful, consider giving it a star!**
