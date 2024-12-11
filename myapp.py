from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import Enum
import re
from flask_jwt_extended import JWTManager, create_access_token, jwt_required, get_jwt
from flask_bcrypt import Bcrypt
from datetime import datetime
from functools import wraps


app = Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:JV2047labs.?@localhost/inventory'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False 
app.config['JWT_SECRET_KEY'] = 'admin'
db = SQLAlchemy(app)
bcrypt = Bcrypt(app)
jwt = JWTManager(app)  


#This is models part
class Customer(db.Model):
    __tablename__ = 'customers'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    first_name = db.Column(db.String(50), nullable=False)
    last_name = db.Column(db.String(50), nullable=False)
    email = db.Column(db.String(100), nullable=False, unique=True)
    password = db.Column(db.String(255), nullable=False)  
    role = db.Column(db.String(50), nullable=False, default='customer') 
    orders = db.relationship('Order', backref='customer', lazy=True)


class Product(db.Model):
    __tablename__ = 'products'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    product_name = db.Column(db.String(100), nullable=False)
    unit_price = db.Column(db.Numeric(10, 2), nullable=False)
    stock_quantity = db.Column(db.Integer, nullable=False, default=0)

    transactions = db.relationship('InventoryTransaction', backref='product', lazy=True)

class Order(db.Model):
    __tablename__ = 'orders'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    customer_id = db.Column(db.Integer, db.ForeignKey('customers.id'), nullable=False)
    date_of_order = db.Column(db.Date, nullable=False)
    items = db.relationship('OrderItem', backref='order', lazy=True)

class OrderItem(db.Model):
    __tablename__ = 'order_items'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    order_id = db.Column(db.Integer, db.ForeignKey('orders.id'), nullable=False)
    product_id = db.Column(db.Integer, db.ForeignKey('products.id'), nullable=False)
    product_quantity = db.Column(db.Integer, nullable=False)
    product = db.relationship('Product', backref='order_items', lazy=True)


class InventoryTransaction(db.Model):
    __tablename__ = 'inventory_transactions'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    product_id = db.Column(db.Integer, db.ForeignKey('products.id'), nullable=False)
    transaction_type = db.Column(Enum('IN', 'OUT', name='transaction_type_enum'), nullable=False)
    quantity = db.Column(db.Integer, nullable=False)
    transaction_date = db.Column(db.Date, nullable=False)
    
def is_valid_email(email):
    email_regex = r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)"
    return bool(re.match(email_regex, email))
 
def admin_required(fn):
    @wraps(fn)
    def wrapper(*args, **kwargs):
        current_user_claims = get_jwt()  
        if current_user_claims.get('role') != 'admin':
            return jsonify({'error': 'Access forbidden: Admins only'}), 403
        return fn(*args, **kwargs)
    return wrapper

@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    email = data.get('email')
    password = data.get('password')

    if not email or not password:
        return jsonify({'error': 'Missing email or password'}), 400

    customer = Customer.query.filter_by(email=email).first()
    if customer and bcrypt.check_password_hash(customer.password, password):
        access_token = create_access_token(identity=str(customer.id), additional_claims={
            'email': customer.email,
            'role': customer.role
        })
        return jsonify({'message': 'Login successful', 'access_token': access_token}), 200
    else:
        return jsonify({'error': 'Invalid credentials'}), 401

@app.route('/customers', methods=['GET'])
def get_customers():
    customers = Customer.query.all()  
    return jsonify([{
        'customer_id': customer.id,
        'first_name': customer.first_name,
        'last_name': customer.last_name,
        'email': customer.email
    } for customer in customers])

@app.route('/products', methods=['GET'])
def get_products():
    products = Product.query.all()
    return jsonify([{
        'product_id': product.id,
        'product_name': product.product_name,
        'unit_price': str(product.unit_price),
        'stock_quantity': product.stock_quantity
    } for product in products])

@app.route('/customers', methods=['POST'])
def add_customer():
    data = request.get_json()

    if not all(k in data for k in ('first_name', 'last_name', 'email', 'password')):
        return jsonify({'error': 'Missing required fields'}), 400

    email = data.get('email')
    if not is_valid_email(email):
        return jsonify({'error': 'Invalid email format'}), 400

    existing_customer = Customer.query.filter_by(email=email).first()
    if existing_customer:
        return jsonify({'error': 'Email already in use'}), 400

    hashed_password = bcrypt.generate_password_hash(data['password']).decode('utf-8')

    try:
        new_customer = Customer(
            first_name=data['first_name'],
            last_name=data['last_name'],
            email=email,
            password=hashed_password 
        )
        db.session.add(new_customer)
        db.session.commit()

        return jsonify({
            'customer_id': new_customer.id,
            'first_name': new_customer.first_name,
            'last_name': new_customer.last_name,
            'email': new_customer.email
        }), 201
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)}), 500
    
@app.route('/orders/<int:customer_id>', methods=['GET'])
def get_customer_orders(customer_id):
    orders = Order.query.filter_by(customer_id=customer_id).all()
    return jsonify([{
        'order_id': order.id,
        'date_of_order': order.date_of_order.isoformat(),
        'order_items': [{
            'product_id': item.product_id,
            'product_name': item.product.product_name,  
            'unit_price': str(item.product.unit_price),  
            'product_quantity': item.product_quantity,
            'total_price': str(item.product.unit_price * item.product_quantity)  
        } for item in order.items]
    } for order in orders])
    
@app.route('/orders', methods=['POST']) 
def place_order():
    data = request.get_json()
    
    order = Order(customer_id=data['customer_id'], date_of_order=datetime.now())
    db.session.add(order)
    db.session.commit()

    for item in data['order_items']:
        product = Product.query.get(item['product_id'])
        if not product:
            return jsonify({'error': f'Product with ID {item["product_id"]} not found'}), 404
        if product.stock_quantity < item['product_quantity']:
            return jsonify({'error': f'Insufficient stock for product_id {item["product_id"]}'}), 400

        order_item = OrderItem(order_id=order.id, product_id=product.id, product_quantity=item['product_quantity'])
        product.stock_quantity -= item['product_quantity']

        transaction = InventoryTransaction(
            product_id=product.id,
            transaction_type='OUT',
            quantity=item['product_quantity'],
            transaction_date=datetime.now()
        )
        db.session.add(order_item)
        db.session.add(transaction)

    db.session.commit()
    return jsonify({'order_id': order.id}), 201
@app.route('/customers/<int:id>', methods=['PUT'])
def update_customer(id):
    customer = Customer.query.get(id)

    if not customer:
        return jsonify({'error': 'Customer not found'}), 404
    data = request.get_json()

    if 'email' in data and not is_valid_email(data['email']):
        return jsonify({'error': 'Invalid email format'}), 400
    customer.first_name = data.get('first_name', customer.first_name)
    customer.last_name = data.get('last_name', customer.last_name)
    customer.email = data.get('email', customer.email)
    try:
        db.session.commit()
        return jsonify({
            'customer_id': customer.id,
            'first_name': customer.first_name,
            'last_name': customer.last_name,
            'email': customer.email
        }), 200
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)}), 500
    
@app.route('/products', methods=['POST'])
def add_product():
    try:
        data = request.get_json()
        if not data or not all(k in data for k in ('product_name', 'unit_price', 'stock_quantity')):
            return jsonify({'error': 'Invalid input'}), 400

        new_product = Product(
            product_name=data['product_name'],
            unit_price=data['unit_price'],
            stock_quantity=data['stock_quantity']
        )
        db.session.add(new_product)
        db.session.commit()
        return jsonify({'product_id': new_product.id}), 201
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    
@app.route('/customers/<int:id>', methods=['DELETE'])
def delete_customer(id):
    customer = Customer.query.get(id)
    if not customer:
        return jsonify({'error': 'Customer not found'}), 404

    orders = Order.query.filter_by(customer_id=id).all()
    for order in orders:
        for item in order.items:
            db.session.delete(item)
        db.session.delete(order)

    db.session.delete(customer)

    try:
        db.session.commit()
        return jsonify({'message': f'Customer with ID {id} and their orders have been deleted'}), 200
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)}), 500
    
@app.route('/products/<int:id>', methods=['PUT'])
def update_product(id):
    data = request.get_json()
    product = Product.query.get(id)
    if not product:
        return jsonify({'error': 'Product not found'}), 404

    product.product_name = data.get('product_name', product.product_name)
    product.unit_price = data.get('unit_price', product.unit_price)
    product.stock_quantity = data.get('stock_quantity', product.stock_quantity)

    try:
        db.session.commit()
        return jsonify({
            'product_id': product.id,
            'product_name': product.product_name,
            'unit_price': str(product.unit_price),
            'stock_quantity': product.stock_quantity
        }), 200
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)}), 500
    
@app.route('/inventory_transactions', methods=['GET'])
@jwt_required()
@admin_required
def get_inventory_transactions():
    transactions = InventoryTransaction.query.all()
    return jsonify([{
        'transaction_id': transaction.id,
        'product_id': transaction.product_id,
        'product_name': transaction.product.product_name,
        'transaction_type': transaction.transaction_type,
        'quantity': transaction.quantity,
        'transaction_date': transaction.transaction_date.isoformat()
    } for transaction in transactions])
    
if __name__ == '__main__':
    app.run(debug=True)