from myapp import app, db, Customer
from flask_bcrypt import Bcrypt

bcrypt = Bcrypt()

# Create a hashed password for the admin user
admin_password = bcrypt.generate_password_hash('password').decode('utf-8')

# Create an admin customer
with app.app_context():  # Create the application context
    admin = Customer(
        first_name='Admin',
        last_name='User',
        email='john@example.com',
        role='admin',
        password=admin_password  # Set the hashed password here
    )

    # Add the admin user to the database
    db.session.add(admin)
    db.session.commit()

    print("Admin user created successfully!")
