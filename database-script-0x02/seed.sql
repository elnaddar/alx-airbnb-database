-- Property Booking Database Seeder
-- This script populates the database with sample data for testing and development

-- Clear existing data (optional - uncomment if needed)
-- TRUNCATE TABLE Payment, Review, Message, Booking, Property, "User", Location RESTART IDENTITY CASCADE;

-- Insert sample users
INSERT INTO "User" (first_name, last_name, email, password_hash, phone_number, role) VALUES
-- Hosts
('Sarah', 'Johnson', 'sarah.johnson@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewdo.btV6vZlxJFa', '+1-555-0101', 'host'),
('Michael', 'Chen', 'michael.chen@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewdo.btV6vZlxJFb', '+1-555-0102', 'host'),
('Elena', 'Rodriguez', 'elena.rodriguez@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewdo.btV6vZlxJFc', '+1-555-0103', 'host'),
('David', 'Thompson', 'david.thompson@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewdo.btV6vZlxJFd', '+1-555-0104', 'host'),
('Lisa', 'Park', 'lisa.park@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewdo.btV6vZlxJFe', '+1-555-0105', 'host'),

-- Guests
('John', 'Smith', 'john.smith@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewdo.btV6vZlxJFf', '+1-555-0201', 'guest'),
('Emma', 'Wilson', 'emma.wilson@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewdo.btV6vZlxJFg', '+1-555-0202', 'guest'),
('James', 'Brown', 'james.brown@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewdo.btV6vZlxJFh', '+1-555-0203', 'guest'),
('Sophia', 'Davis', 'sophia.davis@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewdo.btV6vZlxJFi', '+1-555-0204', 'guest'),
('William', 'Miller', 'william.miller@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewdo.btV6vZlxJFj', '+1-555-0205', 'guest'),
('Olivia', 'Garcia', 'olivia.garcia@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewdo.btV6vZlxJFk', '+1-555-0206', 'guest'),
('Benjamin', 'Martinez', 'benjamin.martinez@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewdo.btV6vZlxJFl', '+1-555-0207', 'guest'),

-- Admin
('Admin', 'User', 'admin@propertybook.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewdo.btV6vZlxJFm', '+1-555-0001', 'admin');

-- Insert sample locations
INSERT INTO Location (city, state, country, postal_code) VALUES
('New York', 'NY', 'USA', '10001'),
('Los Angeles', 'CA', 'USA', '90210'),
('Chicago', 'IL', 'USA', '60601'),
('Miami', 'FL', 'USA', '33101'),
('San Francisco', 'CA', 'USA', '94102'),
('Seattle', 'WA', 'USA', '98101'),
('Austin', 'TX', 'USA', '73301'),
('Boston', 'MA', 'USA', '02101'),
('Denver', 'CO', 'USA', '80201'),
('Portland', 'OR', 'USA', '97201');

-- Insert sample properties
INSERT INTO Property (host_id, name, description, price_per_night, location_id) VALUES
-- Sarah's properties
((SELECT user_id FROM "User" WHERE email = 'sarah.johnson@email.com'),
 'Cozy Manhattan Studio',
 'A beautifully decorated studio apartment in the heart of Manhattan. Perfect for solo travelers or couples. Walking distance to Central Park and major subway lines.',
 150.00,
 (SELECT location_id FROM Location WHERE city = 'New York' LIMIT 1)),

((SELECT user_id FROM "User" WHERE email = 'sarah.johnson@email.com'),
 'Brooklyn Loft with View',
 'Spacious loft apartment with stunning Manhattan skyline views. Modern amenities, full kitchen, and rooftop access. Great for families or groups.',
 220.00,
 (SELECT location_id FROM Location WHERE city = 'New York' LIMIT 1)),

-- Michael's properties
((SELECT user_id FROM "User" WHERE email = 'michael.chen@email.com'),
 'Hollywood Hills Villa',
 'Luxury villa with infinity pool overlooking Los Angeles. 4 bedrooms, home theater, and chef''s kitchen. Perfect for special occasions.',
 450.00,
 (SELECT location_id FROM Location WHERE city = 'Los Angeles' LIMIT 1)),

((SELECT user_id FROM "User" WHERE email = 'michael.chen@email.com'),
 'Santa Monica Beach House',
 'Charming beach house just steps from the pier. Ocean views, private deck, and bike rentals included. Ideal for beach lovers.',
 320.00,
 (SELECT location_id FROM Location WHERE city = 'Los Angeles' LIMIT 1)),

-- Elena's properties
((SELECT user_id FROM "User" WHERE email = 'elena.rodriguez@email.com'),
 'Downtown Chicago Penthouse',
 'Modern penthouse with floor-to-ceiling windows and city views. Premium finishes, gym access, and concierge service.',
 380.00,
 (SELECT location_id FROM Location WHERE city = 'Chicago' LIMIT 1)),

-- David's properties
((SELECT user_id FROM "User" WHERE email = 'david.thompson@email.com'),
 'Miami Art Deco Apartment',
 'Stylish apartment in the historic Art Deco district. Walking distance to South Beach, restaurants, and nightlife.',
 180.00,
 (SELECT location_id FROM Location WHERE city = 'Miami' LIMIT 1)),

((SELECT user_id FROM "User" WHERE email = 'david.thompson@email.com'),
 'Coral Gables Family Home',
 'Spacious family home with pool and garden. Quiet neighborhood, 3 bedrooms, and easy access to downtown Miami.',
 250.00,
 (SELECT location_id FROM Location WHERE city = 'Miami' LIMIT 1)),

-- Lisa's properties
((SELECT user_id FROM "User" WHERE email = 'lisa.park@email.com'),
 'San Francisco Victorian',
 'Historic Victorian home in Nob Hill. Original hardwood floors, bay windows, and cable car access. Unique SF experience.',
 280.00,
 (SELECT location_id FROM Location WHERE city = 'San Francisco' LIMIT 1)),

((SELECT user_id FROM "User" WHERE email = 'lisa.park@email.com'),
 'Seattle Waterfront Condo',
 'Modern condo with Elliott Bay views. Walking distance to Pike Place Market and ferry terminals. Perfect city base.',
 200.00,
 (SELECT location_id FROM Location WHERE city = 'Seattle' LIMIT 1)),

((SELECT user_id FROM "User" WHERE email = 'lisa.park@email.com'),
 'Austin Music District Loft',
 'Hip loft in the heart of Austin''s music scene. Exposed brick, vintage decor, and walking distance to live music venues.',
 160.00,
 (SELECT location_id FROM Location WHERE city = 'Austin' LIMIT 1));

-- Insert sample bookings
INSERT INTO Booking (property_id, user_id, start_date, end_date, total_price, status) VALUES
-- Confirmed bookings
((SELECT property_id FROM Property WHERE name = 'Cozy Manhattan Studio' LIMIT 1),
 (SELECT user_id FROM "User" WHERE email = 'john.smith@email.com'),
 '2024-12-15',
 '2024-12-18',
 450.00,
 'confirmed'),

((SELECT property_id FROM Property WHERE name = 'Hollywood Hills Villa' LIMIT 1),
 (SELECT user_id FROM "User" WHERE email = 'emma.wilson@email.com'),
 '2024-12-20',
 '2024-12-25',
 2250.00,
 'confirmed'),

((SELECT property_id FROM Property WHERE name = 'Miami Art Deco Apartment' LIMIT 1),
 (SELECT user_id FROM "User" WHERE email = 'james.brown@email.com'),
 '2024-11-10',
 '2024-11-14',
 720.00,
 'confirmed'),

-- Pending bookings
((SELECT property_id FROM Property WHERE name = 'San Francisco Victorian' LIMIT 1),
 (SELECT user_id FROM "User" WHERE email = 'sophia.davis@email.com'),
 '2025-01-05',
 '2025-01-08',
 840.00,
 'pending'),

((SELECT property_id FROM Property WHERE name = 'Seattle Waterfront Condo' LIMIT 1),
 (SELECT user_id FROM "User" WHERE email = 'william.miller@email.com'),
 '2025-02-14',
 '2025-02-17',
 600.00,
 'pending'),

-- Canceled booking
((SELECT property_id FROM Property WHERE name = 'Austin Music District Loft' LIMIT 1),
 (SELECT user_id FROM "User" WHERE email = 'olivia.garcia@email.com'),
 '2024-10-01',
 '2024-10-05',
 640.00,
 'canceled'),

-- More confirmed bookings
((SELECT property_id FROM Property WHERE name = 'Brooklyn Loft with View' LIMIT 1),
 (SELECT user_id FROM "User" WHERE email = 'benjamin.martinez@email.com'),
 '2024-11-25',
 '2024-11-28',
 660.00,
 'confirmed'),

((SELECT property_id FROM Property WHERE name = 'Downtown Chicago Penthouse' LIMIT 1),
 (SELECT user_id FROM "User" WHERE email = 'john.smith@email.com'),
 '2025-03-10',
 '2025-03-13',
 1140.00,
 'confirmed');

-- Insert sample payments (only for confirmed bookings)
INSERT INTO Payment (booking_id, amount, payment_method) VALUES
((SELECT booking_id FROM Booking 
  WHERE property_id = (SELECT property_id FROM Property WHERE name = 'Cozy Manhattan Studio' LIMIT 1)
  AND status = 'confirmed' LIMIT 1),
 450.00,
 'credit_card'),

((SELECT booking_id FROM Booking 
  WHERE property_id = (SELECT property_id FROM Property WHERE name = 'Hollywood Hills Villa' LIMIT 1)
  AND status = 'confirmed' LIMIT 1),
 2250.00,
 'stripe'),

((SELECT booking_id FROM Booking 
  WHERE property_id = (SELECT property_id FROM Property WHERE name = 'Miami Art Deco Apartment' LIMIT 1)
  AND status = 'confirmed' LIMIT 1),
 720.00,
 'paypal'),

((SELECT booking_id FROM Booking 
  WHERE property_id = (SELECT property_id FROM Property WHERE name = 'Brooklyn Loft with View' LIMIT 1)
  AND status = 'confirmed' LIMIT 1),
 660.00,
 'credit_card'),

((SELECT booking_id FROM Booking 
  WHERE property_id = (SELECT property_id FROM Property WHERE name = 'Downtown Chicago Penthouse' LIMIT 1)
  AND status = 'confirmed' LIMIT 1),
 1140.00,
 'stripe');

-- Insert sample reviews (only for past confirmed bookings)
INSERT INTO Review (property_id, user_id, rating, comment) VALUES
((SELECT property_id FROM Property WHERE name = 'Cozy Manhattan Studio' LIMIT 1),
 (SELECT user_id FROM "User" WHERE email = 'john.smith@email.com'),
 5,
 'Amazing location! The studio was clean, well-decorated, and had everything we needed. Sarah was a fantastic host and very responsive.'),

((SELECT property_id FROM Property WHERE name = 'Hollywood Hills Villa' LIMIT 1),
 (SELECT user_id FROM "User" WHERE email = 'emma.wilson@email.com'),
 5,
 'Absolutely stunning property! The views are breathtaking and the amenities are top-notch. Perfect for our anniversary celebration.'),

((SELECT property_id FROM Property WHERE name = 'Miami Art Deco Apartment' LIMIT 1),
 (SELECT user_id FROM "User" WHERE email = 'james.brown@email.com'),
 4,
 'Great location in South Beach. The apartment has character and is close to everything. Only minor issue was the AC could be stronger.'),

((SELECT property_id FROM Property WHERE name = 'Brooklyn Loft with View' LIMIT 1),
 (SELECT user_id FROM "User" WHERE email = 'benjamin.martinez@email.com'),
 5,
 'Incredible space with amazing views of Manhattan. The loft is spacious and modern. Highly recommend for anyone visiting NYC!'),

-- Additional reviews for variety
((SELECT property_id FROM Property WHERE name = 'San Francisco Victorian' LIMIT 1),
 (SELECT user_id FROM "User" WHERE email = 'william.miller@email.com'),
 4,
 'Beautiful historic home with lots of character. Great location but parking can be challenging. Overall a wonderful stay.'),

((SELECT property_id FROM Property WHERE name = 'Santa Monica Beach House' LIMIT 1),
 (SELECT user_id FROM "User" WHERE email = 'sophia.davis@email.com'),
 5,
 'Perfect beach getaway! The house is exactly as described and the location cannot be beat. Will definitely book again.'),

((SELECT property_id FROM Property WHERE name = 'Seattle Waterfront Condo' LIMIT 1),
 (SELECT user_id FROM "User" WHERE email = 'olivia.garcia@email.com'),
 4,
 'Nice condo with great water views. Modern amenities and close to attractions. Would have liked better kitchen supplies.'),

((SELECT property_id FROM Property WHERE name = 'Austin Music District Loft' LIMIT 1),
 (SELECT user_id FROM "User" WHERE email = 'james.brown@email.com'),
 5,
 'Perfect location for experiencing Austin nightlife! Cool industrial vibe and you can walk to all the best venues.'),

-- Some 3-star reviews for realism
((SELECT property_id FROM Property WHERE name = 'Coral Gables Family Home' LIMIT 1),
 (SELECT user_id FROM "User" WHERE email = 'emma.wilson@email.com'),
 3,
 'Good family space but could use some updates. Pool was nice but the house felt a bit dated. Decent value for the area.'),

((SELECT property_id FROM Property WHERE name = 'Downtown Chicago Penthouse' LIMIT 1),
 (SELECT user_id FROM "User" WHERE email = 'john.smith@email.com'),
 4,
 'Luxury property with amazing views. Some minor issues with WiFi and the building elevator was slow, but overall excellent.');

-- Insert sample messages
INSERT INTO Message (sender_id, recipient_id, message_body) VALUES
-- Guest inquiring about property
((SELECT user_id FROM "User" WHERE email = 'john.smith@email.com'),
 (SELECT user_id FROM "User" WHERE email = 'sarah.johnson@email.com'),
 'Hi Sarah! I''m interested in booking your Manhattan studio for December 15-18. Is it available? Also, is there parking available nearby?'),

-- Host responding
((SELECT user_id FROM "User" WHERE email = 'sarah.johnson@email.com'),
 (SELECT user_id FROM "User" WHERE email = 'john.smith@email.com'),
 'Hello John! Yes, the studio is available for those dates. There''s a parking garage about 2 blocks away that offers daily rates. I can send you the details once you book. Looking forward to hosting you!'),

-- Guest booking confirmation
((SELECT user_id FROM "User" WHERE email = 'john.smith@email.com'),
 (SELECT user_id FROM "User" WHERE email = 'sarah.johnson@email.com'),
 'Perfect! I''ve just completed the booking. Thank you for the parking information. We''re really excited about our trip to NYC!'),

-- Host providing check-in details
((SELECT user_id FROM "User" WHERE email = 'sarah.johnson@email.com'),
 (SELECT user_id FROM "User" WHERE email = 'john.smith@email.com'),
 'Great! I''ve sent you the check-in instructions via email. The code for the lockbox is 4829. Feel free to reach out if you need any local recommendations!'),

-- Guest asking about amenities
((SELECT user_id FROM "User" WHERE email = 'emma.wilson@email.com'),
 (SELECT user_id FROM "User" WHERE email = 'michael.chen@email.com'),
 'Hi Michael! Your Hollywood Hills villa looks amazing. We''re planning a special celebration - does it have a sound system for music?'),

-- Host responding about amenities
((SELECT user_id FROM "User" WHERE email = 'michael.chen@email.com'),
 (SELECT user_id FROM "User" WHERE email = 'emma.wilson@email.com'),
 'Hi Emma! Yes, there''s a full Sonos sound system throughout the house and a professional setup by the pool area. Perfect for celebrations! Let me know if you need any other details.'),

-- Guest asking about early check-in
((SELECT user_id FROM "User" WHERE email = 'james.brown@email.com'),
 (SELECT user_id FROM "User" WHERE email = 'david.thompson@email.com'),
 'Hi David! Is it possible to check in a few hours early? Our flight arrives at 11 AM and we''d love to drop off our bags.'),

-- Host accommodating request
((SELECT user_id FROM "User" WHERE email = 'david.thompson@email.com'),
 (SELECT user_id FROM "User" WHERE email = 'james.brown@email.com'),
 'Absolutely! I can arrange early check-in for 11:30 AM. I''ll be available to meet you personally and show you around the neighborhood.'),

-- Post-stay thank you
((SELECT user_id FROM "User" WHERE email = 'benjamin.martinez@email.com'),
 (SELECT user_id FROM "User" WHERE email = 'sarah.johnson@email.com'),
 'Thank you for an incredible stay! The loft exceeded our expectations and your recommendations for local restaurants were spot on. We''ll definitely be back!'),

-- Host following up
((SELECT user_id FROM "User" WHERE email = 'sarah.johnson@email.com'),
 (SELECT user_id FROM "User" WHERE email = 'benjamin.martinez@email.com'),
 'So happy you enjoyed your stay! Thank you for being such wonderful guests. You''re welcome back anytime. Would love to have you again!');

-- Update some timestamps to show message flow
UPDATE Message 
SET sent_at = '2024-11-01 14:30:00' 
WHERE sender_id = (SELECT user_id FROM "User" WHERE email = 'john.smith@email.com')
AND recipient_id = (SELECT user_id FROM "User" WHERE email = 'sarah.johnson@email.com')
AND message_body LIKE 'Hi Sarah! I''m interested%';

UPDATE Message 
SET sent_at = '2024-11-01 15:45:00' 
WHERE sender_id = (SELECT user_id FROM "User" WHERE email = 'sarah.johnson@email.com')
AND recipient_id = (SELECT user_id FROM "User" WHERE email = 'john.smith@email.com')
AND message_body LIKE 'Hello John!%';

UPDATE Message 
SET sent_at = '2024-11-01 16:20:00' 
WHERE sender_id = (SELECT user_id FROM "User" WHERE email = 'john.smith@email.com')
AND recipient_id = (SELECT user_id FROM "User" WHERE email = 'sarah.johnson@email.com')
AND message_body LIKE 'Perfect! I''ve just%';

-- Display seeded data summary
SELECT 
  'Data Seeding Complete!' as status,
  (SELECT COUNT(*) FROM "User") as total_users,
  (SELECT COUNT(*) FROM Location) as total_locations,
  (SELECT COUNT(*) FROM Property) as total_properties,
  (SELECT COUNT(*) FROM Booking) as total_bookings,
  (SELECT COUNT(*) FROM Payment) as total_payments,
  (SELECT COUNT(*) FROM Review) as total_reviews,
  (SELECT COUNT(*) FROM Message) as total_messages;