# SQL-projects
Project Description: HR Analytics Using SQL
This project analyzes employee and organizational data to uncover HR trends, departmental behavior, and workforce stability. By using structured queries in MySQL, I cleaned, joined, and analyzed datasets related to employees, salaries, departments, and tenure.

🔍 Problem Statements
Which departments offer the highest and lowest salaries?

What is the average employee tenure, and how does it vary by department, city, or gender?

Which departments are most or least stable in terms of employee retention?

Who are the highest paid and longest-serving employees in each department?

How does attrition/stability vary between male and female employees?

What are the top cities with the most experienced staff?

✅ Solution Approach
I created and populated relational tables for employees, salary, and departments, and then joined them using a tenure bridge table. I used SQL to perform exploratory analysis, compute averages, compare department-level metrics, and isolate top performers across key attributes like tenure, salary, and location.

🧰 SQL Techniques & Functions Used
DDL: CREATE TABLE, ALTER, DROP, ADD COLUMN, RENAME

DML: INSERT INTO, UPDATE, SELECT, JOIN

Filtering: WHERE, IN, BETWEEN, CASE, IS NULL

Aggregation: COUNT(), SUM(), AVG(), MAX(), MIN()

Grouping: GROUP BY, HAVING, ORDER BY

Date Calculations: TIMESTAMPDIFF(YEAR, ...), CURDATE()

Nested Queries: Used for identifying top salaries per department, and highest tenure by city

Conditional Logic: CASE used to assign departments programmatically

Windowed Sorting (without functions): ORDER BY ... LIMIT used to simulate ranking logic

📊 Key Insights
HR is the most stable department, while IT and Security see more employee movement.

Employees in Dehradun, Agra, and Kolkata have the longest tenure.

Sales and Data Analytics offer some of the highest salaries.

Tenure varies slightly by gender, with male employees showing marginally longer service.

Longest-serving employees include Ruble, Ritik, and Yuvraj, indicating excellent loyalty.

📁 Files Included
pgsql
Copy
Edit
HR-Analytics-SQL/
├── jasbir_singh_sql_project.sql       # Full SQL script with tables, data inserts, and analysis
├── README.md                          # Project overview and documentation
"Exploratory Data Analysis on Real-World Dataset through SQL"
