-- create the cancellatinos db
CREATE TABLE fct_cancellations (
id_reservation varchar, id_listing varchar, id_guest varchar, id_traveler varchar
, id_host varchar
, dim_cancellation_reason varchar, ts_cancelled varchar, ds date
);
-- load data from the csv to the cancellations db
COPY fct_cancellations
FROM '/Users/myrsmpb/Desktop/Coding/OperationsAnalyst/fct_cancellations.csv'
DELIMITER ','
CSV HEADER;
-- check the data
select * from fct_cancellations limit 5;