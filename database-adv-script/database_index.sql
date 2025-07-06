CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

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
