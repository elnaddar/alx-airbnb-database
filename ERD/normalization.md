## Location

- **location_id**: Primary Key, UUID
- **city**: VARCHAR, NOT NULL
- **state/province**: VARCHAR, NOT NULL
- **country**: VARCHAR, NOT NULL
- **postal_code**: VARCHAR, NULL

## Property (updated)

- **location_id**: Foreign Key, references `Location(location_id)`
