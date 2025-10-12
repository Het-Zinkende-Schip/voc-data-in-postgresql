CREATE TABLE voc.voc_sources (
    source_id INTEGER PRIMARY KEY,
    ship_name TEXT NOT NULL,
    chamber TEXT,
    remarks TEXT,
    archival_reference TEXT,
    uid UUID NOT NULL,
    source_type TEXT,
    das_voyage_id INTEGER
);

COPY voc.voc_sources (
    source_id,
    ship_name,
    chamber,
    remarks,
    archival_reference,
    uid,
    source_type,
    das_voyage_id
)
FROM '/csv/voc_sources.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ',',
    QUOTE '"',
    ESCAPE '"',
    NULL '',
    ENCODING 'UTF8'
);
