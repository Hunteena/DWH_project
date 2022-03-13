CREATE SCHEMA fact;
CREATE SCHEMA dim;

CREATE TABLE dim.passengers (
	id varchar(20) PRIMARY KEY,
	name text NOT NULL,
	phone varchar(20),
	email varchar(100)
);

CREATE TABLE dim.aircrafts (
	code char(3) PRIMARY KEY,
	model TEXT NOT NULL,
	"range" integer NOT NULL 
);

CREATE TABLE dim.airports (
	code char(3) PRIMARY KEY,
	name TEXT NOT NULL,
	city TEXT NOT NULL,
	longitude float8 NOT NULL,
	latitude float8 NOT NULL,
	timezone TEXT NOT null
);

CREATE TABLE dim.tariffs (
	id serial PRIMARY KEY,
	fare_conditions varchar(20) NOT NULL
);

CREATE TABLE dim.calendar AS
	WITH dates AS (
	    SELECT 	dd::date AS dt
	    FROM 	generate_series(
	            	'2010-01-01'::timestamp, 
	            	'2030-01-01'::timestamp,
	            	'1 day'::INTERVAL
	            ) AS dd
	)
	SELECT
	    to_char(dt, 'YYYYMMDD')::int AS id,
	    dt AS date,
	    to_char(dt, 'YYYY-MM-DD') AS ansi_date,
	    date_part('isodow', dt)::int AS day,
	    date_part('week', dt)::int AS week_number,
	    date_part('month', dt)::int AS month,
	    date_part('isoyear', dt)::int AS year,
	    (date_part('isodow', dt)::smallint BETWEEN 1 AND 5)::int AS week_day
	FROM dates
	ORDER BY dt;
ALTER TABLE dim.calendar ADD PRIMARY KEY (id);

CREATE TABLE fact.flights (
	date_key integer REFERENCES dim.calendar(id),
	passenger_key varchar(20) REFERENCES dim.passengers(id),
	departure_dt timestamp,
	arrival_dt timestamp,
	departure_delay integer,
	arrival_delay integer,
	aircraft_code char(3) REFERENCES dim.aircrafts(code),
	departure_airport char(3) REFERENCES dim.airports(code),
	arrival_airport char(3) REFERENCES dim.airports(code),
	tariff_key integer REFERENCES dim.tariffs(id),
	price numeric(10,2) 
);

CREATE TABLE public.rejected_flights (
	date_key integer,
	passenger_key varchar(20),
	scheduled_departure timestamp,
	scheduled_arrival timestamp,
	departure_dt timestamp,
	arrival_dt timestamp,
	departure_delay integer,
	arrival_delay integer,
	aircraft_code char(3),
	departure_airport char(3),
	arrival_airport char(3),
	fare_conditions varchar(20),
	price numeric(10,2),
	error text
);


