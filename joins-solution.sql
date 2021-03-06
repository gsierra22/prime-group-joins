--1--
SELECT * FROM
customers JOIN addresses ON
customers.id=addresses.id;
--2--
SELECT * 
FROM orders JOIN line_items ON
orders.id=line_items.id;

--3 Delta has cheetos--
SELECT (warehouse) FROM warehouse 
JOIN warehouse_product ON warehouse.id=warehouse_product.warehouse_id 
JOIN products ON warehouse_product.product_id=products.id
WHERE products.description ='cheetos';

--4 Alpha, Delta, Gamma have diet pepsi --
SELECT (warehouse) FROM warehouse 
JOIN warehouse_product ON warehouse.id=warehouse_product.warehouse_id 
JOIN products ON warehouse_product.product_id=products.id
WHERE products.description ='diet pepsi';
--5--
SELECT customers.first_name, customers.last_name, COUNT(orders.id) FROM customers 
JOIN addresses ON customers.id=addresses.customer_id 
JOIN orders ON addresses.id=orders.address_id
GROUP BY customers.id, customers.first_name;
--6--
SELECT COUNT(id) AS customer_count FROM customers; 
--7--
SELECT COUNT(id) FROM products; 
--8 There are 92 available--
SELECT SUM(warehouse_product.on_hand) FROM 
warehouse_product JOIN products ON warehouse_product.product_id=products.id WHERE
products.description='diet pepsi';

--9 --
SELECT orders.id, orders.order_date, SUM(products.unit_price *line_items.quantity)
FROM orders
JOIN line_items ON orders.id=line_items.order_id
JOIN products ON products.id= line_items.product_id
GROUP BY orders.id, orders.order_date ORDER BY orders.order_date DESC;
--10--
SELECT customers.first_name, customers.last_name, SUM(products.unit_price * line_items.quantity) AS total_price
FROM orders
JOIN line_items ON orders.id = line_items.order_id
JOIN products ON products.id = line_items.product_id
JOIN addresses ON addresses.id = orders.address_id
JOIN customers ON addresses.customer_id = customers.id
GROUP BY customers.first_name, customers.last_name ORDER BY customers.last_name DESC;
--11--
SELECT customers.first_name, customers.last_name, SUM (unit_price*quantity) AS total_order_price
        FROM customers 
        JOIN addresses ON addresses.customer_id=customers.id
        LEFT JOIN orders ON orders.address_id=addresses.id
        LEFT JOIN line_items ON orders.id=line_items.order_id
        LEFT JOIN products ON line_items.product_id=products.id
        GROUP BY customers.first_name, customers.last_name
        ORDER BY customers.last_name ASC;
