CREATE SCHEMA IF NOT EXISTS voc_extra;


-- CREATE TABLE voc_extra.voc_ship_pics (
--     ship_name TEXT PRIMARY KEY,
--     ship_pic TEXT
-- );

-- INSERT INTO voc_extra.voc_ship_pics (ship_name)
-- SELECT DISTINCT vv.ship_name
-- FROM voc_raw.voc_voyages vv
-- ORDER BY vv.ship_name ASC;