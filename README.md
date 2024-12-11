# Flask Inventory Management System

This is a simple Flask-based Inventory Management System that allows users to manage customers, products, orders, and inventory transactions. The system also supports JWT authentication for secure access and role-based authorization (admin/customer).

## Features

- User authentication with JWT
- Customer management
- Product management
- Order placement and management
- Inventory transactions (IN/OUT)
- Role-based access control (Admin/Customer)

## Installation
```bash
pip install -r requirements.txt
```
## Configuration
To configure the database:
1. Upload the ```inventory``` MySQL database to your server or local machine.
2. Update the database configuration in the Flask app with your database connection details.

Environment variables needed:
- ```HOST```: The host for the MySQL database (e.g., localhost or IP address of the database server)
- ```USERNAME```: MySQL username (e.g., root)
- ```PASSWORD```: MySQL password
- ```DATABASE```: Name of the database (e.g., inventory)

## Endpoints
| Endpoint | Method | Description | Access |
|----------|--------|-------------|--------|
| /login	| POST	| User's login | users |
| /customers	| GET	| List all customers | anyone |
| /customers	| POST	| Add a new customer | anyone |
| /customers/<id>	| PUT	| Update a customer's details | owner/admin |
| /customers/<id>	| DELETE	| Delete a customer | admin |
| /products	| GET	| List all products | anyone |
| /products	| POST	| Add a new products | admin |
| /products/<id>	| PUT	| Update a product | admin |
| /orders/<id>	| GET	| List user's orders | owner |
| /orders	| POST	| Place your order | owner |
| /inventory_transactions	| GET	| List all inventory |


