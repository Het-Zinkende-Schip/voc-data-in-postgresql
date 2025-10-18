CREATE TABLE voc.voc_ranks (
    rank_id INTEGER PRIMARY KEY,
    rank TEXT,
    parent_rank TEXT,
    category TEXT,
    subcategory TEXT,
    hisco INTEGER,
    hisco_uri TEXT,
    rank_nl TEXT,
    rank_description_nl TEXT,
    rank_description_eng TEXT,
    median_wage NUMERIC
);


COPY voc.voc_ranks (
    rank_id,
    rank,
    parent_rank,
    category,
    subcategory,
    hisco,
    hisco_uri,
    rank_nl,
    rank_description_nl,
    rank_description_eng,
    median_wage
)
FROM '/csv/voc_ranks.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ',',
    QUOTE '"',
    ESCAPE '"',
    NULL '',
    ENCODING 'UTF8'
);


COMMENT ON COLUMN voc.voc_ranks.rank_id IS 'Record ID; each record describes a rank on board a VOC ship.';
COMMENT ON COLUMN voc.voc_ranks.rank IS 'Rank designation (possibly corrected or harmonized).';
COMMENT ON COLUMN voc.voc_ranks.parent_rank IS 'Parent rank grouping similar ranks.';
COMMENT ON COLUMN voc.voc_ranks.category IS 'Top-level category of rank (trade, sea, ship, medical, military, other).';
COMMENT ON COLUMN voc.voc_ranks.subcategory IS 'Further subdivision (e.g. commissioned/non-commissioned officers).';
COMMENT ON COLUMN voc.voc_ranks.hisco IS 'HISCO occupational code.';
COMMENT ON COLUMN voc.voc_ranks.hisco_uri IS 'URI for HISCO code.';
COMMENT ON COLUMN voc.voc_ranks.rank_nl IS 'Dutch-language rank name.';
COMMENT ON COLUMN voc.voc_ranks.rank_description_nl IS 'Description of rank in Dutch.';
COMMENT ON COLUMN voc.voc_ranks.rank_description_eng IS 'Description of rank in English.';
COMMENT ON COLUMN voc.voc_ranks.median_wage IS 'Median wage for rank, derived from wage samples.';
