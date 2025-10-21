--Details about arrival places mentioned in the voc_voyages table.

--Gl¸ckstadt -> Glückstadt
--Patria?? De Republiek der Zeven Verenigde Nederlanden??

CREATE SCHEMA IF NOT EXISTS voc_extra;

CREATE TABLE voc_extra.voc_arrival_places (
    arrival_place TEXT PRIMARY KEY,
    streetmap_url TEXT NOT NULL,
    wikidata_url TEXT
);

-- INSERT INTO	voc_extra.voc_arrival_places (arrival_place)
-- SELECT DISTINCT vv.arrival_place
-- FROM voc.voc_voyages vv
-- WHERE vv.arrival_place IS NOT NULL
-- ORDER BY vv.arrival_place ASC;

COPY voc_extra.voc_arrival_places (
    arrival_place,
    streetmap_url,
    wikidata_url
)
FROM '/extra_data/voc_arrival_places.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ',',
    QUOTE '"',
    ESCAPE '"',
    NULL '',
    ENCODING 'UTF8'
);


COMMENT ON COLUMN voc_extra.voc_arrival_places.arrival_place IS 'Name of the arrival place as mentioned in the original voyages data.';
COMMENT ON COLUMN voc_extra.voc_arrival_places.streetmap_url IS 'Link to Streetmap.nl for the arrival place of the voyage.';
COMMENT ON COLUMN voc_extra.voc_arrival_places.wikidata_url IS 'Link to Wikidata for the arrival place of the voyage (if it exists).';
