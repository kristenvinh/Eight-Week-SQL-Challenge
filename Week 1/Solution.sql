/* --------------------
   Case Study Questions
   --------------------*/

-- 5. Which item was the most popular for each customer?
-- 6. Which item was purchased first by the customer after they became a member?
-- 7. Which item was purchased just before the customer became a member?
-- 8. What is the total items and amount spent for each member before they became a member?
-- 9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?

-- 1. What is the total amount each customer spent at the restaurant?
SELECT 
customer_id,
sum(menu.price) as amount_spent
FROM
    dannys_diner.sales
LEFT OUTER JOIN
    dannys_diner.menu
ON
    sales.product_id = menu.product_id
GROUP BY customer_id

-- 2. How many days has each customer visited the restaurant?
SELECT customer_id, COUNT (DISTINCT order_date) as days_visited
FROM sales
GROUP BY customer_id

-- 3. What was the first item from the menu purchased by each customer?
WITH added_row_number AS (SELECT
  *,
  ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_date ASC) as row_count
FROM dannys_diner.sales)
SELECT customer_id, menu.product_name
FROM 
added_row_number
LEFT OUTER JOIN
    dannys_diner.menu
ON
    added_row_number.product_id = menu.product_id
WHERE row_count = 1



-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
SELECT product_name as menu_item, count(order_date) as purchases
FROM dannys_diner.sales
LEFT OUTER JOIN
    dannys_diner.menu
ON
    sales.product_id = menu.product_id
GROUP BY menu_item
ORDER BY purchases DESC
Limit 1

