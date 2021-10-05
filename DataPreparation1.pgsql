-- Data Preparation 1
-- fct_booking and fct_cancellation
-- booking b/w 9/1/18 and 11/30/18
-- entity_id, id_listing (join), id_reservation (count)
-- 
SELECT fct_bookings.Ds as booking_date
    , fct_bookings.id_entity as entity
    , COUNT(DISTINCT fct_bookings.id_listing) as listings
    , COUNT(DISTINCT fct_bookings.id_reservation) as bookings
    , COUNT(fct_cancellations.id_reservation) as cancellations
FROM fct_bookings
    LEFT JOIN fct_cancellations
    ON fct_bookings.id_listing = fct_cancellations.id_listing
WHERE fct_bookings.Ds >= '9/1/18' and fct_bookings.Ds < '11/30/18'  
GROUP BY booking_date, entity;
--
-- the above query will return the daily volume of
-- listings, resereves(bookings) and cancellations by entity 
-- 