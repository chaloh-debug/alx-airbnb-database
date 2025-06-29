-- Created by Chaloh-debug
-- Date: 2025-06-29
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create ENUM types first for PostgreSQL
CREATE TYPE user_role AS ENUM('guest', 'host', 'admin');
CREATE TYPE booking_status AS ENUM('pending', 'confirmed', 'canceled');
CREATE TYPE payment_method_type AS ENUM('credit_card', 'paypal', 'stripe');

-- Table: users (renamed from User to avoid keyword conflict)
CREATE TABLE users (
    user_id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    first_name varchar(36) NOT NULL,
    last_name varchar(36) NOT NULL,
    email varchar(128) NOT NULL UNIQUE,
    password_hash varchar(128) NOT NULL,
    phone_number varchar(36) NULL,
    role user_role NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Table: property
CREATE TABLE property (
    property_id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    host_id uuid NOT NULL,
    name varchar(128) NOT NULL,
    location varchar(128) NOT NULL,
    description text NOT NULL,
    price_per_night decimal(9,2) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT property_host_fk FOREIGN KEY (host_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Table: booking
CREATE TABLE booking (
    booking_id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    property_id uuid NOT NULL,
    user_id uuid NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price decimal(10,2) NOT NULL,
    status booking_status NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT booking_user_fk FOREIGN KEY (user_id) REFERENCES users(user_id),
    CONSTRAINT booking_property_fk FOREIGN KEY (property_id) REFERENCES property(property_id) ON DELETE CASCADE
);

-- Table: payment
CREATE TABLE payment (
    payment_id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    booking_id uuid NOT NULL,
    amount decimal(10,2) NOT NULL,
    payment_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    payment_method payment_method_type NOT NULL,
    CONSTRAINT payment_booking_fk FOREIGN KEY (booking_id) REFERENCES booking(booking_id) ON DELETE CASCADE
);

-- Table: review
CREATE TABLE review (
    review_id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    property_id uuid NOT NULL,
    user_id uuid NOT NULL, -- Corrected data type
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment text NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT review_user_fk FOREIGN KEY (user_id) REFERENCES users(user_id),
    CONSTRAINT review_property_fk FOREIGN KEY (property_id) REFERENCES property(property_id) ON DELETE CASCADE
);

-- Table: message
CREATE TABLE message (
    message_id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    sender_id uuid NOT NULL,    -- Corrected data type
    recipient_id uuid NOT NULL, -- Corrected data type
    message_body text NOT NULL, -- Corrected data type
    sent_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT message_sender_fk FOREIGN KEY (sender_id) REFERENCES users(user_id),
    CONSTRAINT message_recipient_fk FOREIGN KEY (recipient_id) REFERENCES users(user_id)
);

-- End of file.

