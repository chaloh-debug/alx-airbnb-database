# Normalization of the Airbnb Database entities

#### 1. First Normal Form (1NF)

Ensuring that each table in the database has a primary key and that each column in the table contains atomic values. 

The Attribute 'location' can be further broken down to:
- City
- Zip code
- Town
- Street

#### 2. Second Normal Form (2NF)

Ensuring that each non-key column in a table is dependent on the primary key.
No partial dependencies were present in the tables.

#### 3. Third Normal Form (3NF)

Ensuring that each non-key column in a table is not transitively dependent on the primary key.
There were no transitive dependencies in the tables.

# Final Normalized ER diagram

![Image Alt](https://github.com/chaloh-debug/alx-airbnb-database/blob/main/Normalized_AirBnB_ER_Diagram.png)
