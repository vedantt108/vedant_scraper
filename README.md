🛒 Amazon Price Tracker & Automated ETL Pipeline

An end-to-end Data Engineering and Analytics project designed to extract real-time product metrics from Amazon, transform and process unstructured DOM data into relational datasets, execute advanced SQL analytics, and report price volatility trends using Power BI.

📌 Project Overview

E-commerce prices on platforms like Amazon fluctuate frequently due to dynamic pricing algorithms. This project automates the extraction, transformation, and historical analysis of product metrics—tracking price trends, stock availability, customer ratings, and target price alerts over time.

  Key Capabilities
  
- **Web Scraping Pipeline:** Extracts real-time title, current price, star ratings, review counts, availability status, and timestamps.
- **Relational Data Modeling:** Stores normalized master product records and time-series transactional price logs in MySQL.
- **SQL Analytics & Target Alert System:** Evaluates target price completion status, historical min/max/average price ranges, and rank-ordered market pricing using window functions.
- **Power BI Dashboard:** Visualizes dynamic pricing trends, stock trends, and volatility metrics across monitored catalog categories.

🚀 How to Run the Project
Prerequisites

Python 3.8+ installed

MySQL Server & MySQL Workbench installed

Power BI Desktop installed (optional, to open .pbix)

Setup Instructions
Clone the repository:

Bash
git clone [https://github.com/your-username/amazon-price-tracker.git](https://github.com/your-username/amazon-price-tracker.git)
cd amazon-price-tracker
Install required Python packages:

Bash
pip install requests beautifulsoup4 pandas numpy
Initialize the MySQL Database:

Open MySQL Workbench.

Run load table.sql to initialize the amazon_price_tracker database and table schemas.

Run the Scraper Pipeline:

Execute scraper.ipynb in Jupyter Notebook or VS Code to scrape fresh data, generate CSVs, and update MySQL tables via connecting mysql and jupyter.sql.

Run SQL Reports & Power BI Dashboard:

Execute queries inside sql analysis.sql and sql analysis 2.sql for analytical reporting.

Open amazon_scraper.pbix in Power BI Desktop to interact with visual price trends and stock summaries.

