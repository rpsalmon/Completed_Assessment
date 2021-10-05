-- Data Preparation 2
-- fct_bookings and fct_cancellations
-- HAVING COUNT(DISTINCT id_reservations) > 50
-- 2018 bookings
-- id_reservations(count), m_booking_value(sum), cancellation_rate
-- , price_p_night, booking_share, id_entity(join), m_nights_booked(sum)
-- ORDER BY COUNT(id_reservations) DESC
--
SELECT EXTRACT(YEAR from (CAST(fct_bookings.Ds as DATE))) as year_, fct_bookings.id_entity as entity
, COUNT(DISTINCT fct_bookings.id_reservation) as total_bookings
, sum(cast(fct_bookings.m_booking_value as bigint)) as total_value
, COUNT(DISTINCT fct_cancellations.id_reservation) as cancellations
, round(COUNT(DISTINCT fct_cancellations.id_reservation)/CAST(COUNT(DISTINCT fct_bookings.id_reservation) as DECIMAL),2) as cancellation_rate
, round(sum(cast(fct_bookings.m_booking_value as bigint))/CAST(sum(cast(fct_bookings.m_nights_booked as BIGINT)) as DECIMAL),2) as price_per_night
, round(CAST(COUNT(DISTINCT fct_bookings.id_reservation)/avg(A.reserves) as DECIMAL),2) as booking_share
from fct_bookings
    LEFT JOIN fct_cancellations
    ON fct_bookings.id_listing = fct_cancellations.id_listing
    LEFT JOIN (
        SELECT EXTRACT(YEAR from (CAST(fct_bookings.Ds as DATE))) as year_, 
        COUNT(DISTINCT fct_bookings.id_reservation) as reserves
        FROM fct_bookings
        WHERE EXTRACT(YEAR from (CAST(fct_bookings.Ds as DATE))) = 2018
        GROUP BY EXTRACT(YEAR from (CAST(fct_bookings.Ds as DATE)))
        HAVING COUNT(DISTINCT fct_bookings.id_reservation) > 50
    ) as A on EXTRACT(YEAR from (CAST(fct_bookings.Ds as DATE))) = A.year_
WHERE EXTRACT(YEAR from (CAST(fct_bookings.Ds as DATE))) = 2018
GROUP BY EXTRACT(YEAR from (CAST(fct_bookings.Ds as DATE))), fct_bookings.id_entity
HAVING COUNT(DISTINCT fct_bookings.id_reservation) > 50
ORDER BY COUNT(DISTINCT fct_bookings.id_reservation) DESC;
-- 
-- the above query will return 7 columns (entity, total_bookings, cancelaltions, cancellations_rate, price_per_night, booking_share)
-- booking_share can be accomplished more efficiently
-- 