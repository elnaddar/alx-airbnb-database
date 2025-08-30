# Property Booking Database Seeder

A comprehensive SQL seeder script that populates the property booking database with realistic sample data for development and testing purposes.

## Overview

This seeder creates a complete dataset that simulates a functioning property rental platform with users, properties, bookings, payments, reviews, and messages. The data is designed to be realistic and interconnected, following proper business logic.

## What Gets Seeded

### Users (13 total)
- **5 Hosts**: Property owners with multiple listings
- **7 Guests**: Users who book properties and leave reviews
- **1 Admin**: System administrator account

All users include realistic names, email addresses, phone numbers, and bcrypt-hashed passwords.

### Locations (10 cities)
Major US metropolitan areas:
- New York, NY
- Los Angeles, CA
- Chicago, IL
- Miami, FL
- San Francisco, CA
- Seattle, WA
- Austin, TX
- Boston, MA
- Denver, CO
- Portland, OR

### Properties (10 listings)
Diverse property portfolio including:
- **Studio apartments** ($150/night)
- **Beach houses** ($320/night) 
- **Luxury villas** ($450/night)
- **Urban lofts** ($160-280/night)
- **Penthouses** ($380/night)

Each property has detailed descriptions, realistic pricing, and proper host assignments.

### Bookings (8 reservations)
Realistic booking scenarios:
- **5 Confirmed** bookings with payments
- **2 Pending** bookings awaiting confirmation
- **1 Canceled** booking for testing edge cases

Date ranges span past, present, and future with calculated totals.

### Payments (5 transactions)
- Only created for confirmed bookings
- Multiple payment methods: credit_card, paypal, stripe
- Amounts exactly match booking totals

### Reviews (10 reviews)
- Ratings from 3-5 stars for realism
- Detailed, authentic comments
- Only for properties with completed stays
- Various review perspectives and experiences

### Messages (10 conversations)
Real-world communication patterns:
- Property inquiries and responses
- Booking confirmations
- Check-in instructions
- Amenity questions
- Post-stay thank you messages

## Prerequisites

- PostgreSQL database with the property booking schema already created
- Database must have the `pgcrypto` extension enabled for UUID generation
- Proper permissions to INSERT data into all tables

## Installation

### 1. Prepare Your Database
Ensure your schema is already created:
```bash
psql -d your_database -f schema.sql
```

### 2. Run the Seeder
Execute the seeder script:
```bash
psql -d your_database -f seeder.sql
```

### 3. Verify Installation
The script automatically displays a summary:
```
┌─────────────────────┬─────────────────┐
│       status        │ Data Counts     │
├─────────────────────┼─────────────────┤
│ Data Seeding        │ 13 users        │
│ Complete!           │ 10 locations    │
│                     │ 10 properties   │
│                     │ 8 bookings      │
│                     │ 5 payments      │
│                     │ 10 reviews      │
│                     │ 10 messages     │
└─────────────────────┴─────────────────┘
```

## Sample User Accounts

### Test Hosts
```
Email: sarah.johnson@email.com (2 properties in NYC)
Email: michael.chen@email.com (2 properties in LA)  
Email: elena.rodriguez@email.com (1 property in Chicago)
Email: david.thompson@email.com (2 properties in Miami)
Email: lisa.park@email.com (3 properties in SF/Seattle/Austin)
```

### Test Guests
```
Email: john.smith@email.com
Email: emma.wilson@email.com
Email: james.brown@email.com
Email: sophia.davis@email.com
Email: william.miller@email.com
Email: olivia.garcia@email.com
Email: benjamin.martinez@email.com
```

### Admin Account
```
Email: admin@propertybook.com
Role: admin
```

**Note**: All passwords are hashed. For testing, you'll need to implement proper authentication in your application.

## Data Relationships

The seeded data maintains proper referential integrity:

- **Properties** are correctly linked to hosts and locations
- **Bookings** reference valid properties and users
- **Payments** only exist for confirmed bookings
- **Reviews** are only for properties users have actually booked
- **Messages** show realistic host-guest communication

## Sample Queries

### Get all properties with their hosts and locations
```sql
SELECT p.name, u.first_name || ' ' || u.last_name as host_name, 
       l.city, l.state, p.price_per_night
FROM Property p
JOIN "User" u ON p.host_id = u.user_id
JOIN Location l ON p.location_id = l.location_id
ORDER BY p.price_per_night DESC;
```

### View booking history with payment status
```sql
SELECT b.start_date, b.end_date, p.name, b.status,
       CASE WHEN pay.payment_id IS NOT NULL THEN 'Paid' ELSE 'Unpaid' END as payment_status
FROM Booking b
JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id
ORDER BY b.created_at DESC;
```

### Get property ratings and review counts
```sql
SELECT p.name, ROUND(AVG(r.rating::numeric), 2) as avg_rating, 
       COUNT(r.review_id) as review_count
FROM Property p
LEFT JOIN Review r ON p.property_id = r.property_id
GROUP BY p.property_id, p.name
ORDER BY avg_rating DESC NULLS LAST;
```

## Resetting Data

To clear all seeded data and start fresh:

```sql
TRUNCATE TABLE Payment, Review, Message, Booking, Property, "User", Location RESTART IDENTITY CASCADE;
```

Then re-run the seeder script.

## Customization

### Adding More Data
You can extend the seeder by:
- Adding more users with different roles
- Creating properties in new locations
- Generating additional booking scenarios
- Adding more review variety
- Creating complex message threads

### Modifying Existing Data
Key areas to customize:
- **Pricing**: Adjust `price_per_night` values for your market
- **Dates**: Update booking dates to fit your testing timeline
- **Locations**: Add international cities or specific regions
- **Content**: Modify property descriptions and reviews

### Business Logic Considerations
The seeder follows these rules:
- Payments only exist for confirmed bookings
- Reviews only from users who have booked the property
- Message timestamps flow logically
- Booking totals calculated from date ranges and nightly rates

## Development Tips

### For Testing Scenarios
The seeded data supports testing:
- **Booking workflow**: pending → confirmed → payment
- **Cancellation handling**: includes canceled booking example
- **Rating systems**: variety of review scores
- **User communication**: realistic message exchanges
- **Multi-property hosts**: some hosts have multiple listings

### For Application Development
Use this data to test:
- User authentication with different roles
- Property search and filtering
- Booking availability checking
- Payment processing workflows
- Review and rating displays
- Messaging system functionality

## Notes

- All UUIDs are auto-generated using PostgreSQL's `gen_random_uuid()`
- Timestamps use realistic dates spanning several months
- Password hashes are bcrypt format (not real passwords)
- Phone numbers use standard US format
- Email addresses are fictional but properly formatted

## Troubleshooting

### Common Issues

**Foreign key constraint errors**: 
Make sure the main schema is created before running the seeder.

**UUID generation errors**:
Ensure `pgcrypto` extension is enabled:
```sql
CREATE EXTENSION IF NOT EXISTS "pgcrypto";
```

**Duplicate key errors**:
Clear existing data before re-running:
```sql
TRUNCATE TABLE Payment, Review, Message, Booking, Property, "User", Location RESTART IDENTITY CASCADE;
```

## Contributing

When adding new seed data:
1. Maintain referential integrity
2. Use realistic data that follows business logic
3. Test all foreign key relationships
4. Update this README with new data descriptions
5. Ensure proper date/time sequencing for related records