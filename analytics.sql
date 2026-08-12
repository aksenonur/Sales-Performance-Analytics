-- Sales Performance Analytical Queries

-- 1. Total Revenue and Sales Volume by Product Category
SELECT 
    p.category,
    SUM(st.quantity) AS total_units_sold,
    SUM(st.quantity * p.unit_price) AS total_revenue
FROM sales_transactions st
JOIN products p ON st.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

-- 2. Monthly Sales Trend
SELECT 
    strftime('%Y-%m', st.transaction_date) AS sales_month,
    COUNT(DISTINCT st.transaction_id) AS total_transactions,
    SUM(st.quantity * p.unit_price) AS monthly_revenue
FROM sales_transactions st
JOIN products p ON st.product_id = p.product_id
GROUP BY sales_month
ORDER BY sales_month ASC;

-- 3. Top 5 Customers by Total Spending
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(st.quantity * p.unit_price) AS total_spent
FROM sales_transactions st
JOIN customers c ON st.customer_id = c.customer_id
JOIN products p ON st.product_id = p.product_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 5;
