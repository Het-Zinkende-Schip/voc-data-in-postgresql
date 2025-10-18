
--RAW
CREATE TABLE voc_raw.voc_places (
    place_id TEXT,
    place_original TEXT,
    place_normalized TEXT,
    place_standardized_id TEXT,
    provenance TEXT
);


COPY voc_raw.voc_places (
    place_id,
    place_original,
    place_normalized,
    place_standardized_id,
    provenance
)
FROM '/unzipped/enriched/voc_places.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ',',
    QUOTE '"',
    ESCAPE '"',
    NULL '',
    ENCODING 'UTF8'
);

--FINAL

CREATE TABLE voc.voc_places (
    place_id INTEGER PRIMARY KEY,
    place_original TEXT NOT NULL,
    place_normalized TEXT,
    place_standardized_id INTEGER,
    provenance INTEGER
);


INSERT INTO voc.voc_places (
    place_id,
    place_original,
    place_normalized,
    place_standardized_id,
    provenance
)
SELECT
    NULLIF(place_id, '')::INTEGER AS place_id,
    NULLIF(place_original, '') AS place_original,
    NULLIF(place_normalized, '') AS place_normalized,
    NULLIF(place_standardized_id, '')::NUMERIC::INTEGER AS place_standardized_id,
    NULLIF(place_standardized_id, '')::NUMERIC::INTEGER AS  provenance
FROM voc_raw.voc_places;


COMMENT ON COLUMN voc.voc_places.place_id IS 'Record ID for each place of origin mentioned in the muster records.';
COMMENT ON COLUMN voc.voc_places.place_original IS 'Toponym as attested in the original dataset.';
COMMENT ON COLUMN voc.voc_places.place_normalized IS 'Normalized toponym form.';
COMMENT ON COLUMN voc.voc_places.place_standardized_id IS 'ID of standardized place (refers to voc_places_standardized.place_standardized_id).';
COMMENT ON COLUMN voc.voc_places.provenance IS 'Code specifying source of standardization (1–6).';
