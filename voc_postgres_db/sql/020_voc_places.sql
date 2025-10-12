CREATE TABLE voc.voc_places (
    place_id INTEGER PRIMARY KEY,
    place_original TEXT NOT NULL,
    place_normalized TEXT,
    place_standardized_id NUMERIC,
    provenance NUMERIC
);

COPY voc.voc_places (
    place_id,
    place_original,
    place_normalized,
    place_standardized_id,
    provenance
)
FROM '/csv/voc_places.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ',',
    QUOTE '"',
    ESCAPE '"',
    NULL '',
    ENCODING 'UTF8'
);
