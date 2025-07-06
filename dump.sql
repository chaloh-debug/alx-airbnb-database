CREATE TYPE user_role AS ENUM('guest', 'host', 'admin');
CREATE TYPE booking_status AS ENUM('pending', 'confirmed', 'canceled');
CREATE TYPE payment_method_type AS ENUM('credit_card', 'paypal', 'stripe');

-- Table: users (renamed from User to avoid keyword conflict)
CREATE TABLE users (
    user_id text PRIMARY KEY,
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
    property_id text PRIMARY KEY,
    host_id text NOT NULL,
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
    booking_id text PRIMARY KEY,
    property_id text NOT NULL,
    user_id text NOT NULL,
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
    payment_id text PRIMARY KEY,
    booking_id text NOT NULL,
    amount decimal(10,2) NOT NULL,
    payment_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    payment_method payment_method_type NOT NULL,
    CONSTRAINT payment_booking_fk FOREIGN KEY (booking_id) REFERENCES booking(booking_id) ON DELETE CASCADE
);

-- Table: review
CREATE TABLE review (
    review_id text PRIMARY KEY,
    property_id text NOT NULL,
    user_id text NOT NULL, -- Corrected data type
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment text NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT review_user_fk FOREIGN KEY (user_id) REFERENCES users(user_id),
    CONSTRAINT review_property_fk FOREIGN KEY (property_id) REFERENCES property(property_id) ON DELETE CASCADE
);

-- Table: message
CREATE TABLE message (
    message_id text PRIMARY KEY,
    sender_id text NOT NULL,    -- Corrected data type
    recipient_id text NOT NULL, -- Corrected data type
    message_body text NOT NULL, -- Corrected data type
    sent_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT message_sender_fk FOREIGN KEY (sender_id) REFERENCES users(user_id),
    CONSTRAINT message_recipient_fk FOREIGN KEY (recipient_id) REFERENCES users(user_id)
);


INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
('user-alice-host-01', 'Alice', 'Smith', 'alice.s@example.com', 'hash_placeholder_alice', '111-222-3333', 'host', NOW() - INTERVAL '90 day'),
('user-bob-host-02', 'Bob', 'Johnson', 'bob.j@example.com', 'hash_placeholder_bob', '222-333-4444', 'host', NOW() - INTERVAL '85 day'),
('user-charlie-guest-03', 'Charlie', 'Davis', 'charlie.d@example.com', 'hash_placeholder_charlie', '333-444-5555', 'guest', NOW() - INTERVAL '80 day');

-- Table: property
INSERT INTO property (property_id, host_id, name, location, description, price_per_night) VALUES
('prop-beach-house-01', 'user-alice-host-01', 'Sunny Beach House', 'Malibu, CA', 'A beautiful house right on the beach.', 550.00),
('prop-mountain-cabin-02', 'user-alice-host-01', 'Cozy Mountain Cabin', 'Aspen, CO', 'A rustic cabin perfect for a ski trip.', 275.00),
('prop-urban-loft-03', 'user-bob-host-02', 'Urban Loft Downtown', 'New York, NY', 'A stylish loft in the heart of the city.', 350.00);

-- Table: booking
INSERT INTO booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES
('book-01', 'prop-beach-house-01', 'user-charlie-guest-03', '2024-03-10', '2024-03-15', 2750.00, 'confirmed', NOW() - INTERVAL '70 day'),
('book-02', 'prop-urban-loft-03', 'user-charlie-guest-03', '2024-09-05', '2024-09-10', 1750.00, 'confirmed', NOW() - INTERVAL '20 day'),
('book-03', 'prop-mountain-cabin-02', 'user-charlie-guest-03', '2024-04-20', '2024-04-24', 1100.00, 'confirmed', NOW() - INTERVAL '45 day');

-- Table: payment
INSERT INTO payment (payment_id, booking_id, amount, payment_date, payment_method) VALUES
('pay-01', 'book-01', 2750.00, NOW() - INTERVAL '69 day', 'credit_card'),
('pay-02', 'book-02', 1750.00, NOW() - INTERVAL '19 day', 'paypal'),
('pay-03', 'book-03', 1100.00, NOW() - INTERVAL '44 day', 'stripe');

-- Table: review
INSERT INTO review (review_id, property_id, user_id, rating, comment, created_at) VALUES
('rev-01', 'prop-beach-house-01', 'user-charlie-guest-03', 5, 'Absolutely stunning location and a beautiful home. Alice was a great host!', '2024-03-16 10:00:00'),
('rev-02', 'prop-mountain-cabin-02', 'user-charlie-guest-03', 4, 'Very cozy and perfect for our mountain trip. A little smaller than expected, but wonderful overall.', '2024-04-25 12:30:00'),
('rev-03', 'prop-urban-loft-03', 'user-alice-host-01', 5, 'As a fellow host, I was very impressed. The loft was immaculate and Bob was very communicative. Highly recommend.', '2024-02-10 09:00:00');

-- Table: message
INSERT INTO message (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
('msg-01', 'user-charlie-guest-03', 'user-bob-host-02', 'Hi Bob, looking forward to our stay in September! Is early check-in possible?', NOW() - INTERVAL '18 day'),
('msg-02', 'user-bob-host-02', 'user-charlie-guest-03', 'Hi Charlie, thanks for booking! Early check-in depends on the previous guest, but I will certainly let you know if it becomes available.', NOW() - INTERVAL '18 day' + INTERVAL '1 hour'),
('msg-03', 'user-charlie-guest-03', 'user-bob-host-02', 'That sounds great, thank you for the quick reply!', NOW() - INTERVAL '18 day' + INTERVAL '2 hour');
