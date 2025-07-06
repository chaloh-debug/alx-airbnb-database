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
) PARTITION BY RANGE(start_date);


-- analyze example file

EXPLAIN ANALYZE
SELECT count(*)
FROM bookings_non_partitioned
WHERE start_date >= '2023-01-08' AND start_date < '2023-01-15';
