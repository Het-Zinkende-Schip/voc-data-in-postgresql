

--RAW--

CREATE TABLE voc_raw.voc_places_standardized (
    place_standardized_id TEXT,
    place_standardized TEXT,
    country_code TEXT,
    place_standardized_cc TEXT,
    authority_file_uri TEXT,
    latitude TEXT,
    longitude TEXT,
    region TEXT
);


COPY voc_raw.voc_places_standardized (
    place_standardized_id,
    place_standardized,
    country_code,
    place_standardized_cc,
    authority_file_uri,
    latitude,
    longitude,
    region
)
FROM '/csv/voc_places_standardized.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ',',
    QUOTE '"',
    ESCAPE '"',
    NULL '',
    ENCODING 'UTF8'
);
--FINAL TABLE--

CREATE TABLE voc.voc_places_standardized (
    place_standardized_id INTEGER PRIMARY KEY,
    place_standardized TEXT,
    country_code CHAR(2),
    place_standardized_cc TEXT,
    authority_file_uri TEXT,
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    region CHAR(1)
);

INSERT INTO voc.voc_places_standardized (
    place_standardized_id,
    place_standardized,
    country_code,
    place_standardized_cc,
    authority_file_uri,
    latitude,
    longitude,
    region
)
SELECT
    NULLIF(place_standardized_id, '')::INTEGER AS place_standardized_id,
    NULLIF(place_standardized, '') AS place_standardized,
    UPPER(LEFT(TRIM(country_code), 2)) AS country_code,
    NULLIF(place_standardized_cc, '') AS place_standardized_cc,
    NULLIF(authority_file_uri, '') AS authority_file_uri,
CASE
    WHEN latitude IS NULL OR latitude IN ('', 'nan', 'NaN', '#N/A', '#N/B') THEN NULL
    ELSE latitude::DOUBLE PRECISION
END AS latitude,

CASE
    WHEN longitude IS NULL OR longitude IN ('', 'nan', 'NaN', '#N/A', '#N/B') THEN NULL
    ELSE longitude::DOUBLE PRECISION
END AS longitude,
    LEFT(TRIM(region), 1) AS region
FROM voc_raw.voc_places_standardized;


COMMENT ON COLUMN voc.voc_places_standardized.place_standardized_id IS 'Record ID for each standardized place of origin.';
COMMENT ON COLUMN voc.voc_places_standardized.place_standardized IS 'Standardized place name.';
COMMENT ON COLUMN voc.voc_places_standardized.country_code IS 'ISO 3166-1 alpha-2 country code of modern location.';
COMMENT ON COLUMN voc.voc_places_standardized.place_standardized_cc IS 'Concatenation of standardized name and country code.';
COMMENT ON COLUMN voc.voc_places_standardized.authority_file_uri IS 'GeoNames or Wikidata URI for standardized place.';
COMMENT ON COLUMN voc.voc_places_standardized.latitude IS 'Latitude of standardized place.';
COMMENT ON COLUMN voc.voc_places_standardized.longitude IS 'Longitude of standardized place.';
COMMENT ON COLUMN voc.voc_places_standardized.region IS 'Region code (A–I) indicating geographical/cultural area.';
