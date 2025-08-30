# Property Booking Database Schema

A PostgreSQL database schema for a property booking system similar to Airbnb, supporting property listings, user management, bookings, payments, reviews, and messaging.

## Schema Overview

This schema supports a complete property rental platform with the following core functionality:

- **User Management**: Guest, host, and admin roles
- **Property Listings**: Properties with location details and pricing
- **Booking System**: Date-based reservations with status tracking
- **Payment Processing**: Multiple payment methods with transaction records
- **Review System**: 1-5 star ratings with comments
- **Messaging**: Communication between users

## Database Structure

### Custom Types

```sql
-- Booking status options
status_enum: 'pending', 'confirmed', 'canceled'

-- Supported payment methods
payment_method_enum: 'credit_card', 'paypal', 'stripe'

-- User role hierarchy
role_enum: 'guest', 'host', 'admin'
```

### Core Tables

#### User

Manages all platform users with role-based access.

| Column        | Type      | Description                  |
| ------------- | --------- | ---------------------------- |
| user_id       | UUID      | Primary key (auto-generated) |
| first_name    | VARCHAR   | User's first name            |
| last_name     | VARCHAR   | User's last name             |
| email         | VARCHAR   | Unique email address         |
| password_hash | VARCHAR   | Hashed password              |
| phone_number  | VARCHAR   | Optional contact number      |
| role          | role_enum | User permission level        |
| created_at    | TIMESTAMP | Account creation date        |

#### Property

Property listings with details and pricing.

| Column          | Type      | Description                   |
| --------------- | --------- | ----------------------------- |
| property_id     | UUID      | Primary key (auto-generated)  |
| host_id         | UUID      | Foreign key to User table     |
| name            | VARCHAR   | Property title                |
| description     | TEXT      | Detailed property description |
| price_per_night | DECIMAL   | Nightly rate                  |
| location_id     | UUID      | Foreign key to Location table |
| created_at      | TIMESTAMP | Listing creation date         |
| updated_at      | TIMESTAMP | Last modification date        |

#### Location

Geographic information for properties.

| Column      | Type    | Description                  |
| ----------- | ------- | ---------------------------- |
| location_id | UUID    | Primary key (auto-generated) |
| city        | VARCHAR | City name                    |
| state       | VARCHAR | State/province               |
| country     | VARCHAR | Country name                 |
| postal_code | VARCHAR | ZIP/postal code              |

#### Booking

Reservation records with date ranges and pricing.

| Column      | Type        | Description                       |
| ----------- | ----------- | --------------------------------- |
| booking_id  | UUID        | Primary key (auto-generated)      |
| property_id | UUID        | Foreign key to Property table     |
| user_id     | UUID        | Foreign key to User table (guest) |
| start_date  | DATE        | Check-in date                     |
| end_date    | DATE        | Check-out date                    |
| total_price | DECIMAL     | Total booking cost                |
| status      | status_enum | Current booking status            |
| created_at  | TIMESTAMP   | Booking creation date             |

#### Payment

Payment transaction records.

| Column         | Type                | Description                  |
| -------------- | ------------------- | ---------------------------- |
| payment_id     | UUID                | Primary key (auto-generated) |
| booking_id     | UUID                | Foreign key to Booking table |
| amount         | DECIMAL             | Payment amount               |
| payment_date   | TIMESTAMP           | Transaction timestamp        |
| payment_method | payment_method_enum | Payment processor used       |

#### Review

Property reviews and ratings.

| Column      | Type      | Description                          |
| ----------- | --------- | ------------------------------------ |
| review_id   | UUID      | Primary key (auto-generated)         |
| property_id | UUID      | Foreign key to Property table        |
| user_id     | UUID      | Foreign key to User table (reviewer) |
| rating      | INTEGER   | Rating (1-5 stars)                   |
| comment     | TEXT      | Review text                          |
| created_at  | TIMESTAMP | Review submission date               |

#### Message

User-to-user messaging system.

| Column       | Type      | Description                           |
| ------------ | --------- | ------------------------------------- |
| message_id   | UUID      | Primary key (auto-generated)          |
| sender_id    | UUID      | Foreign key to User table (sender)    |
| recipient_id | UUID      | Foreign key to User table (recipient) |
| message_body | TEXT      | Message content                       |
| sent_at      | TIMESTAMP | Message timestamp                     |

## Installation

### Prerequisites

- PostgreSQL 12+ (required for `gen_random_uuid()` function)
- Database with UUID extension enabled

### Setup

1. **Create the database:**

   ```sql
   CREATE DATABASE property_booking;
   ```

2. **Enable UUID extension:**

   ```sql
   CREATE EXTENSION IF NOT EXISTS "pgcrypto";
   ```

3. **Run the schema file:**
   ```bash
   psql -d property_booking -f schema.sql
   ```

## Key Features

### Data Integrity

- Foreign key constraints ensure referential integrity
- Check constraints validate rating values (1-5)
- Unique constraints prevent duplicate emails
- UUID primary keys prevent ID conflicts

### Indexing

Optimized queries with indexes on:

- User email lookups
- Booking searches by property
- Payment lookups by booking

### Audit Trail

- Timestamps track creation dates for all entities
- Property updates are timestamped
- Payment and message history preserved

## Usage Examples

### Create a new user

```sql
INSERT INTO "User" (first_name, last_name, email, password_hash, role)
VALUES ('John', 'Doe', 'john@example.com', 'hashed_password', 'guest');
```

### List available properties in a city

```sql
SELECT p.name, p.price_per_night, l.city, l.state
FROM Property p
JOIN Location l ON p.location_id = l.location_id
WHERE l.city = 'New York';
```

### Get booking history for a user

```sql
SELECT b.start_date, b.end_date, b.total_price, p.name
FROM Booking b
JOIN Property p ON b.property_id = p.property_id
WHERE b.user_id = 'user-uuid-here'
ORDER BY b.created_at DESC;
```

## Business Rules

### Booking Logic

- End date must be after start date
- Overlapping bookings for the same property should be prevented (implement in application logic)
- Only confirmed bookings should generate payments

### User Permissions

- **Guests**: Can book properties and leave reviews
- **Hosts**: Can list properties and manage bookings
- **Admins**: Full system access

### Review System

- Users can only review properties they have booked
- One review per user per property (implement in application logic)
- Ratings must be between 1-5 stars

## Notes

- The `"User"` table name is quoted because `User` is a PostgreSQL reserved keyword
- UUID primary keys provide better distributed system support
- Decimal types should specify precision for production use
- Consider adding triggers for `updated_at` timestamp automation

## Contributing

When modifying this schema:

1. Always test changes in a development environment
2. Consider migration scripts for existing data
3. Update this README with any structural changes
4. Maintain referential integrity in all modifications
