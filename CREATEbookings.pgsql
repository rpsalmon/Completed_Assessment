-- creating the bookings db
CREATE TABLE fct_bookings (
id_entity varchar, id_reservation varchar, dim_source varchar
, id_guest varchar, id_traveler varchar, id_listing varchar
, m_nights_booked varchar, m_guests varchar, m_booking_value varchar
, ds_checkin date, ds_checkout date, is_business_travel_ready varchar
, is_self_checkin varchar, ts_booking varchar, ds date
);
-- loading the csv to the bookings db
COPY fct_bookings
FROM '/Users/myrsmpb/Desktop/Coding/OperationsAnalyst/fct_bookings.csv'
DELIMITER ','
CSV HEADER;
-- check the data
select * from fct_bookings limit 5;