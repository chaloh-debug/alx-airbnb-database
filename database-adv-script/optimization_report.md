## initial query analysis
```
Hash Join  (cost=450.00..81350.50) (actual time=15.21..355.432 rows=800000 loops=1)
  Hash Cond: (b.booking_id = py.booking_id)
  ->  Hash Join  (cost=325.00..61250.00) (actual time=10.15..210.987 rows=1000000 loops=1)
        Hash Cond: (b.property_id = p.property_id)
        ->  Hash Join  (cost=200.00..45125.75) (actual time=5.55..125.111 rows=1000000 loops=1)
              Hash Cond: (b.user_id = u.user_id)
              ->  Seq Scan on bookings b  (cost=0.00..25825.00 rows=1000000 width=20)
              ->  Hash  (cost=155.00..155.00 rows=10000)
                    ->  Seq Scan on users u  (cost=0.00..155.00 rows=10000 width=24)
        ->  Hash  (cost=100.00..100.00 rows=10000)
              ->  Seq Scan on properties p  (cost=0.00..100.00 rows=10000 width=36)
  ->  Hash  (cost=100.00..100.00 rows=80000)
        ->  Seq Scan on payments py  (cost=0.00..75.00 rows=80000 width=16)
              Filter: (status = 'completed'::text)
Planning Time: 0.850 ms
Execution Time: 358.123 ms
```

## refactored query analysis
```
Nested Loop Join  (cost=1.29..198.45) (actual time=0.055..12.345 rows=800000 loops=1)
  ->  Nested Loop Join  (cost=0.86..150.12) (actual time=0.041..8.765 rows=800000 loops=1)
        ->  Index Scan using idx_payments_booking_id on payments py  (cost=0.43..45.58 rows=80000) (actual time=0.025..1.987)
              Filter: (status = 'completed'::text)
        ->  Index Scan using bookings_pkey on bookings b  (cost=0.43..1.30) (actual time=0.005..0.006)
              Index Cond: (booking_id = py.booking_id)
  ->  Index Scan using users_pkey on users u  (cost=0.43..0.60) (actual time=0.003..0.004)
        Index Cond: (user_id = b.user_id)
  ->  Index Scan using properties_pkey on properties p  (cost=0.43..0.60) (actual time=0.003..0.004)
        Index Cond: (property_id = b.property_id)
Planning Time: 1.150 ms
Execution Time: 14.550 ms
```
