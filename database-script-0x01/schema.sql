CREATE TYPE status_enum AS ENUM('pending', 'confirmed', 'canceled');

CREATE TYPE payment_method_enum AS ENUM('credit_card', 'paypal', 'stripe');

CREATE TYPE role_enum AS ENUM('guest', 'host', 'admin');

CREATE TABLE Booking (
  booking_id UUID NOT NULL DEFAULT gen_random_uuid (),
  property_id UUID NOT NULL,
  user_id UUID NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  total_price DECIMAL NOT NULL,
  status status_enum NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (booking_id)
);

CREATE TABLE Location (
  location_id UUID NOT NULL DEFAULT gen_random_uuid (),
  city VARCHAR NOT NULL,
  state VARCHAR NOT NULL,
  country VARCHAR NOT NULL,
  postal_code VARCHAR,
  PRIMARY KEY (location_id)
);

CREATE TABLE Message (
  message_id UUID NOT NULL DEFAULT gen_random_uuid (),
  sender_id UUID NOT NULL,
  recipient_id UUID NOT NULL,
  message_body TEXT NOT NULL,
  sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (message_id)
);

CREATE TABLE Payment (
  payment_id UUID NOT NULL DEFAULT gen_random_uuid (),
  booking_id UUID NOT NULL,
  amount DECIMAL NOT NULL,
  payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  payment_method payment_method_enum NOT NULL,
  PRIMARY KEY (payment_id)
);

CREATE TABLE Property (
  property_id UUID NOT NULL DEFAULT gen_random_uuid (),
  host_id UUID NOT NULL,
  name VARCHAR NOT NULL,
  description TEXT NOT NULL,
  price_per_night DECIMAL NOT NULL,
  location_id UUID NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (property_id)
);

COMMENT ON COLUMN Property.updated_at IS 'ON UPDATE CURRENT_TIMESTAMP';

CREATE TABLE Review (
  review_id UUID NOT NULL DEFAULT gen_random_uuid (),
  property_id UUID NOT NULL,
  user_id UUID NOT NULL,
  rating INTEGER NOT NULL CHECK (
    rating >= 1
    AND rating <= 5
  ),
  comment TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (review_id)
);

COMMENT ON COLUMN Review.rating IS 'CHECK: rating >= 1 AND rating <= 5';

CREATE TABLE "User" (
  user_id UUID NOT NULL DEFAULT gen_random_uuid (),
  first_name VARCHAR NOT NULL,
  last_name VARCHAR NOT NULL,
  email VARCHAR NOT NULL UNIQUE,
  password_hash VARCHAR NOT NULL,
  phone_number VARCHAR,
  role role_enum NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id)
);

-- Constraints
ALTER TABLE Property
ADD CONSTRAINT FK_User_TO_Property FOREIGN KEY (host_id) REFERENCES "User" (user_id);

ALTER TABLE Booking
ADD CONSTRAINT FK_Property_TO_Booking FOREIGN KEY (property_id) REFERENCES Property (property_id);

ALTER TABLE Booking
ADD CONSTRAINT FK_User_TO_Booking FOREIGN KEY (user_id) REFERENCES "User" (user_id);

ALTER TABLE Payment
ADD CONSTRAINT FK_Booking_TO_Payment FOREIGN KEY (booking_id) REFERENCES Booking (booking_id);

ALTER TABLE Review
ADD CONSTRAINT FK_Property_TO_Review FOREIGN KEY (property_id) REFERENCES Property (property_id);

ALTER TABLE Review
ADD CONSTRAINT FK_User_TO_Review FOREIGN KEY (user_id) REFERENCES "User" (user_id);

ALTER TABLE Message
ADD CONSTRAINT FK_User_TO_Message FOREIGN KEY (sender_id) REFERENCES "User" (user_id);

ALTER TABLE Message
ADD CONSTRAINT FK_User_TO_Message1 FOREIGN KEY (recipient_id) REFERENCES "User" (user_id);

ALTER TABLE Property
ADD CONSTRAINT FK_Location_TO_Property FOREIGN KEY (location_id) REFERENCES Location (location_id);

-- Indexes
CREATE INDEX user_email_idx ON "User" (email);

CREATE INDEX booking_property_id_idx ON Booking (property_id);

CREATE INDEX payment_booking_id_idx ON Payment (booking_id);