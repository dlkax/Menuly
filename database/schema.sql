CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE restaurants (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    email VARCHAR(200) UNIQUE NOT NULL,
    phone VARCHAR(20) NOT NULL,
    plan VARCHAR(20) DEFAULT 'basic',
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE locations (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    restaurant_id UUID REFERENCES restaurants(id),
    name VARCHAR(150) NOT NULL,
    address TEXT NOT NULL,
    whatsapp_number VARCHAR(20) UNIQUE NOT NULL,
    opening_hours JSONB,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE users (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    restaurant_id UUID REFERENCES restaurants(id),
    name VARCHAR(100) NOT NULL,
    email VARCHAR(200) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    role VARCHAR(20) DEFAULT 'manager',
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE categories (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    location_id UUID REFERENCES locations(id),
    name VARCHAR(100) NOT NULL,
    sort_order INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT true
);

CREATE TABLE dishes (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    category_id UUID REFERENCES categories(id),
    name VARCHAR(150) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    photo_url TEXT,
    is_available BOOLEAN DEFAULT true,
    is_dish_of_day BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE reservations (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    location_id UUID REFERENCES locations(id),
    customer_name VARCHAR(100) NOT NULL,
    customer_phone VARCHAR(20) NOT NULL,
    date DATE NOT NULL,
    time TIME NOT NULL,
    people_count INTEGER NOT NULL,
    status VARCHAR(20) DEFAULT 'pending',
    notes TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE orders (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    location_id UUID REFERENCES locations(id),
    customer_name VARCHAR(100) NOT NULL,
    customer_phone VARCHAR(20) NOT NULL,
    delivery_address TEXT NOT NULL,
    status VARCHAR(20) DEFAULT 'pending',
    total DECIMAL(10,2) NOT NULL,
    notes TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE order_items (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    order_id UUID REFERENCES orders(id),
    dish_id UUID REFERENCES dishes(id),
    quantity INTEGER NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL
);

CREATE TABLE messages (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    location_id UUID REFERENCES locations(id),
    customer_phone VARCHAR(20) NOT NULL,
    direction VARCHAR(10) NOT NULL,
    content TEXT NOT NULL,
    message_type VARCHAR(20) DEFAULT 'text',
    session_state VARCHAR(50),
    created_at TIMESTAMP DEFAULT NOW()
);

ALTER TABLE restaurants ADD COLUMN updated_at TIMESTAMP DEFAULT NOW();
ALTER TABLE locations ADD COLUMN updated_at TIMESTAMP DEFAULT NOW();
ALTER TABLE locations ADD COLUMN has_delivery BOOLEAN DEFAULT true;
ALTER TABLE locations ADD COLUMN has_reservations BOOLEAN DEFAULT true;
ALTER TABLE dishes ADD COLUMN updated_at TIMESTAMP DEFAULT NOW();
ALTER TABLE orders ADD COLUMN updated_at TIMESTAMP DEFAULT NOW();
ALTER TABLE reservations ADD COLUMN updated_at TIMESTAMP DEFAULT NOW();