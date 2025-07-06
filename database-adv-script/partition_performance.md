## Initial Table

```
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
```
## unpartitioned runtime

```
 Finalize Aggregate  (cost=6993.11..6993.12 rows=1 width=8) (actual time=27.967..31.995 rows=1 loops=1)
   ->  Gather  (cost=6992.99..6993.11 rows=1 width=8) (actual time=13.480..31.982 rows=2 loops=1)
         Workers Planned: 1
         Workers Launched: 1
         ->  Partial Aggregate  (cost=5992.99..5993.01 rows=1 width=8) (actual time=6.631..6.632 rows=1 loops=2)
               ->  Parallel Seq Scan on bookings_non_partitioned  (cost=0.00..5990.00 rows=1198 width=0) (actual time=6.627..6.627 rows=0 loops=2)
                     Filter: ((start_date >= '2023-01-08'::date) AND (start_date < '2023-01-15'::date))
 Planning Time: 0.396 ms
 Execution Time: 32.028 ms
```

## partitioned runtime
```
 Finalize Aggregate  (cost=14288.84..14288.85 rows=1 width=8) (actual time=83.178..88.293 rows=1 loops=1)
   ->  Gather  (cost=14288.63..14288.84 rows=2 width=8) (actual time=83.089..88.282 rows=3 loops=1)
         Workers Planned: 2
         Workers Launched: 2
         ->  Partial Aggregate  (cost=13288.63..13288.64 rows=1 width=8) (actual time=61.809..61.810 rows=1 loops=3)
               ->  Parallel Seq Scan on bookings_y2023m01 bookings_partitioned  (cost=0.00..13048.41 rows=96089 width=0) (actual time=0.016..56.374 rows=78060 loops=3)
                     Filter: ((start_date >= '2023-01-08'::date) AND (start_date < '2023-01-15'::date))
                     Rows Removed by Filter: 266601
 Planning Time: 0.157 ms
 Execution Time: 88.334 ms

```
