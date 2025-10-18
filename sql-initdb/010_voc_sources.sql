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

COMMENT ON COLUMN voc.voc_sources.source_id IS 'Record ID; each record describes a physical archival document about the crew of a particular voyage.';
COMMENT ON COLUMN voc.voc_sources.ship_name IS 'Name of the VOC ship for which the source document provides crew data.';
COMMENT ON COLUMN voc.voc_sources.chamber IS 'VOC chamber that managed the ship voyage and its crew.';
COMMENT ON COLUMN voc.voc_sources.remarks IS 'General remarks on the archival record (Dutch).';
COMMENT ON COLUMN voc.voc_sources.archival_reference IS 'Reference to the inventory number in the VOC archives (Nationaal Archief).';
COMMENT ON COLUMN voc.voc_sources.uid IS 'Unique record ID in the database of the Dutch National Archives.';
COMMENT ON COLUMN voc.voc_sources.source_type IS 'Type of archival source (e.g., pay ledger, request book, regiment book).';
COMMENT ON COLUMN voc.voc_sources.das_voyage_id IS 'Unique ID of the voyage (refers to voc_voyages.das_voyage_id).';
