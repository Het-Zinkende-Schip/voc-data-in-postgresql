--RAW--
CREATE TABLE voc_raw.voc_voyages (
    das_voyage_id TEXT,
    direction TEXT,
    ship_name TEXT,
    ship_tonnage TEXT,
    chamber TEXT,
    departure_date TEXT,
    departure_place TEXT,
    arrival_date_cape TEXT,
    departure_date_cape TEXT,
    arrival_date TEXT,
    arrival_place TEXT
);


COPY voc_raw.voc_voyages (
    das_voyage_id,
    direction,
    ship_name,
    ship_tonnage,
    chamber,
    departure_date,
    departure_place,
    arrival_date_cape,
    departure_date_cape,
    arrival_date,
    arrival_place
)
FROM '/csv/voc_voyages.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ',',
    QUOTE '"',
    ESCAPE '"',
    NULL '',
    ENCODING 'UTF8'
);


-- HELPER FUNCTION--

CREATE OR REPLACE FUNCTION voc.safe_to_date(raw text)
RETURNS date AS $$
DECLARE
    clean text;
    y int;
    m int;
    d int;
    maxd int;
BEGIN
    IF raw IS NULL OR raw IN ('', 'nan') THEN
        RETURN NULL;
    END IF;

    --remove everything except digits and dashes
    clean := regexp_replace(raw, '[^0-9\-]', '', 'g');

    --case year only: YYYY
    IF clean ~ '^[0-9]{4}$' THEN
        RETURN TO_DATE(clean || '-01-01', 'YYYY-MM-DD');
    END IF;

    --case year + month: YYYY-MM
    IF clean ~ '^[0-9]{4}-[0-9]{2}$' THEN
        m := SUBSTRING(clean FROM 6 FOR 2)::INT;
        IF m BETWEEN 1 AND 12 THEN
            RETURN TO_DATE(clean || '-01', 'YYYY-MM-DD');
        ELSE
            RETURN NULL;
        END IF;
    END IF;

    --full date: YYYY-MM-DD
    IF clean ~ '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' THEN
        y := SUBSTRING(clean FROM 1 FOR 4)::INT;
        m := SUBSTRING(clean FROM 6 FOR 2)::INT;
        d := SUBSTRING(clean FROM 9 FOR 2)::INT;

        --validate month
        IF m NOT BETWEEN 1 AND 12 THEN
            RETURN NULL;
        END IF;

        --max valid day for that month/year
        SELECT EXTRACT(DAY FROM (DATE_TRUNC('month', MAKE_DATE(y, m, 1)) + INTERVAL '1 month - 1 day'))
        INTO maxd;

        --validate day
        IF d NOT BETWEEN 1 AND maxd THEN
            RETURN NULL;
        END IF;

        RETURN MAKE_DATE(y, m, d);
    END IF;

    RETURN NULL;
EXCEPTION
    WHEN OTHERS THEN
        RETURN NULL;
END;
$$ LANGUAGE plpgsql IMMUTABLE;


--FINAL TABLE--

CREATE TABLE voc.voc_voyages (
    das_voyage_id INTEGER PRIMARY KEY,
    direction TEXT,
    ship_name TEXT,
    ship_tonnage INTEGER,
    chamber TEXT,
    departure_date DATE,
    departure_place TEXT,
    arrival_date_cape DATE,
    departure_date_cape DATE,
    arrival_date DATE,
    arrival_place TEXT
);


INSERT INTO voc.voc_voyages (
    das_voyage_id,
    direction,
    ship_name,
    ship_tonnage,
    chamber,
    departure_date,
    departure_place,
    arrival_date_cape,
    departure_date_cape,
    arrival_date,
    arrival_place
)
SELECT
    NULLIF(das_voyage_id, '')::INTEGER AS das_voyage_id,
    NULLIF(direction, '') AS direction,
    NULLIF(ship_name, '') AS ship_name,

    --bij meerdere tonnages (bijv. 400/500  450)
    CASE
        WHEN ship_tonnage IS NULL OR ship_tonnage IN ('', 'nan') THEN NULL
        WHEN ship_tonnage ~ '^[0-9]+(/[0-9]+)+$' THEN (
            SELECT AVG(val::NUMERIC)
            FROM regexp_split_to_table(ship_tonnage, '/') AS val
        )
        WHEN ship_tonnage ~ '^[0-9]+(\.[0-9]+)?$' THEN ship_tonnage::NUMERIC
        ELSE NULL
    END::INTEGER AS ship_tonnage,

    NULLIF(chamber, '') AS chamber,

    voc.safe_to_date(departure_date) AS departure_date,

    NULLIF(departure_place, '') AS departure_place,

    voc.safe_to_date(arrival_date_cape) AS arrival_date_cape,
    voc.safe_to_date(departure_date_cape) AS departure_date_cape,
    voc.safe_to_date(arrival_date) AS arrival_date,

    NULLIF(arrival_place, '') AS arrival_place

FROM voc_raw.voc_voyages;



COMMENT ON COLUMN voc.voc_voyages.das_voyage_id IS 'Record ID; each record describes a voyage of a VOC ship.';
COMMENT ON COLUMN voc.voc_voyages.direction IS 'Voyage direction indicator (outward or return).';
COMMENT ON COLUMN voc.voc_voyages.ship_name IS 'Name of the VOC ship.';
COMMENT ON COLUMN voc.voc_voyages.ship_tonnage IS 'Ship tonnage (possibly averaged if multiple tonnages given).';
COMMENT ON COLUMN voc.voc_voyages.chamber IS 'VOC chamber that managed the voyage.';
COMMENT ON COLUMN voc.voc_voyages.departure_date IS 'Date of departure from the Netherlands.';
COMMENT ON COLUMN voc.voc_voyages.departure_place IS 'Departure location (port).';
COMMENT ON COLUMN voc.voc_voyages.arrival_date_cape IS 'Date of arrival at the Cape of Good Hope.';
COMMENT ON COLUMN voc.voc_voyages.departure_date_cape IS 'Date of departure from the Cape of Good Hope.';
COMMENT ON COLUMN voc.voc_voyages.arrival_date IS 'Date of arrival at destination.';
COMMENT ON COLUMN voc.voc_voyages.arrival_place IS 'Destination place.';
