import pytest
from myapp import app, db, Customer, Product, Order, OrderItem, InventoryTransaction
from flask_jwt_extended import create_access_token
from flask_bcrypt import Bcrypt
from unittest.mock import MagicMock

@pytest.fixture(scope='session')
def client():
    app.config['TESTING'] = True
    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///:memory:' 
    app.config['JWT_SECRET_KEY'] = 'test_secret'
    
    bcrypt = Bcrypt(app)

    with app.app_context():
        db.create_all()  
        yield app.test_client() 
        db.drop_all() 
        
@pytest.fixture
def admin_token():
    return create_access_token(identity='1', additional_claims={'role': 'admin'})

@pytest.fixture
def customer_token():
    return create_access_token(identity='2', additional_claims={'role': 'customer'})

@pytest.fixture(scope="function", autouse=True)
def clear_db():
    db.session.remove()
    db.drop_all()
    db.create_all()

def test_add_customer(client):
    data = {
        'first_name': 'John',
        'last_name': 'Doe',
        'email': 'john.doe@example.com',
        'password': 'securepassword'
    }
    response = client.post('/customers', json=data)
    assert response.status_code == 201
    assert response.json['email'] == 'john.doe@example.com'

def test_login(client):
    bcrypt = Bcrypt(app)
    hashed_password = bcrypt.generate_password_hash('securepassword').decode('utf-8')
    customer = Customer(first_name='Jane', last_name='Smith', email='jane.smith@example.com', password=hashed_password)
    db.session.add(customer)
    db.session.commit()

    data = {'email': 'jane.smith@example.com', 'password': 'securepassword'}
    response = client.post('/login', json=data)
    assert response.status_code == 200
    assert 'access_token' in response.json

import pytest
from unittest.mock import MagicMock
from myapp import app, db, Customer

@pytest.fixture
def mock_customers():
    
    return [
        Customer(id=1, first_name='John', last_name='Doe', email='john.doe@example.com'),
        Customer(id=2, first_name='Jane', last_name='Smith', email='jane.smith@example.com')
    ]

def test_get_customers(client, admin_token, mocker, mock_customers):
    mock_query = mocker.patch('myapp.db.session.query', autospec=True)
    mock_query.return_value.all.return_value = mock_customers
    
    headers = {'Authorization': f'Bearer {admin_token}'}
    response = client.get('/customers', headers=headers)

    assert response.status_code == 200
    assert len(response.json) == 2  
    assert response.json[0]['first_name'] == 'John'
    assert response.json[1]['first_name'] == 'Jane'
    
def test_add_product(client, admin_token):
    headers = {'Authorization': f'Bearer {admin_token}'}
    data = {
        'product_name': 'Widget',
        'unit_price': 9.99,
        'stock_quantity': 100
    }
    response = client.post('/products', json=data, headers=headers)
    assert response.status_code == 201
    assert response.json['product_id']

def test_get_products(client):
    response = client.get('/products')
    assert response.status_code == 200
    assert isinstance(response.json, list)

def test_place_order(client, customer_token):
    headers = {'Authorization': f'Bearer {customer_token}'}

    customer = Customer(id=2, first_name='Jane', last_name='Smith', email='jane.smith@example.com', password='securepassword')
    db.session.add(customer)
    db.session.commit()

    product = Product(product_name='Widget', unit_price=9.99, stock_quantity=100)
    db.session.add(product)
    db.session.commit()

    data = {
        'customer_id': customer.id,
        'order_items': [
            {'product_id': product.id, 'product_quantity': 2}
        ]
    }
    response = client.post('/orders', json=data, headers=headers)
    assert response.status_code == 201
    assert 'order_id' in response.json

def test_update_customer(client, customer_token):
    headers = {'Authorization': f'Bearer {customer_token}'}

    customer = Customer(id=2, first_name='Jane', last_name='Smith', email='jane.smith@example.com', password='securepassword')
    db.session.add(customer)
    db.session.commit()

    data = {'first_name': 'Janet'}
    response = client.put(f'/customers/{customer.id}', json=data, headers=headers)

    assert response.status_code == 200
    assert response.json['first_name'] == 'Janet'

def test_delete_customer(client, admin_token):
    headers = {'Authorization': f'Bearer {admin_token}'}

    customer = Customer(first_name='Mark', last_name='Twain', email='mark.twain@example.com', password='password123')
    db.session.add(customer)
    db.session.commit()

    response = client.delete(f'/customers/{customer.id}', headers=headers)
    assert response.status_code == 200
    assert response.json['message'] == f'Customer with ID {customer.id} and their orders have been deleted'

def test_get_inventory_transactions(client, admin_token):
    with app.app_context():
        headers = {'Authorization': f'Bearer {admin_token}'}
        response = client.get('/inventory_transactions', headers=headers)
        assert response.status_code == 200
