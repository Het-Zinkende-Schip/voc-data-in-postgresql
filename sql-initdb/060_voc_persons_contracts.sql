
-- RAW TABLE FOR DATA IMPORT --

CREATE TABLE voc_raw.voc_persons_contracts (
    vocop_id TEXT,
    full_name TEXT,
    place_of_origin TEXT,
    place_id TEXT,
    disambiguated_person TEXT,
    person_cluster_id TEXT,
    person_cluster_row TEXT,
    rank TEXT,
    rank_corrected TEXT,
    rank_id TEXT,
    debt_letter TEXT,
    month_letter TEXT,
    date_begin_contract TEXT,
    date_end_contract TEXT,
    contract_length TEXT,
    reason_end_contract TEXT,
    could_muster_again TEXT,
    location_end_contract TEXT,
    outward_voyage_id TEXT,
    changed_ship_at_cape TEXT,
    changed_ship_at_cape_voyage_id TEXT,
    return_voyage_id TEXT,
    remark TEXT,
    source_id TEXT,
    source_reference TEXT,
    uid TEXT,
    scan_permalink TEXT
);


COPY voc_raw.voc_persons_contracts (
    vocop_id,
    full_name,
    place_of_origin,
    place_id,
    disambiguated_person,
    person_cluster_id,
    person_cluster_row,
    rank,
    rank_corrected,
    rank_id,
    debt_letter,
    month_letter,
    date_begin_contract,
    date_end_contract,
    contract_length,
    reason_end_contract,
    could_muster_again,
    location_end_contract,
    outward_voyage_id,
    changed_ship_at_cape,
    changed_ship_at_cape_voyage_id,
    return_voyage_id,
    remark,
    source_id,
    source_reference,
    uid,
    scan_permalink
)
FROM '/csv/voc_persons_contracts.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ',',
    QUOTE '"',
    ESCAPE '"',
    NULL '',
    ENCODING 'UTF8'
);

-- FINAL TABLE --

CREATE TABLE voc.voc_persons_contracts (
    vocop_id INTEGER PRIMARY KEY,
    full_name TEXT,
    place_of_origin TEXT,
    place_id INTEGER,
    disambiguated_person BOOLEAN,
    person_cluster_id INTEGER,
    person_cluster_row INTEGER,
    rank TEXT,
    rank_corrected BOOLEAN,
    rank_id INTEGER,
    debt_letter BOOLEAN,
    month_letter BOOLEAN,
    date_begin_contract DATE,
    date_end_contract DATE,
    contract_length INTEGER,
    reason_end_contract TEXT,
    could_muster_again BOOLEAN,
    location_end_contract TEXT,
    outward_voyage_id INTEGER,
    changed_ship_at_cape BOOLEAN,
    changed_ship_at_cape_voyage_id INTEGER,
    return_voyage_id INTEGER,
    remark TEXT,
    source_id INTEGER,
    source_reference TEXT,
    uid UUID,
    scan_permalink TEXT
);

INSERT INTO voc.voc_persons_contracts (
    vocop_id,
    full_name,
    place_of_origin,
    place_id,
    disambiguated_person,
    person_cluster_id,
    person_cluster_row,
    rank,
    rank_corrected,
    rank_id,
    debt_letter,
    month_letter,
    date_begin_contract,
    date_end_contract,
    contract_length,
    reason_end_contract,
    could_muster_again,
    location_end_contract,
    outward_voyage_id,
    changed_ship_at_cape,
    changed_ship_at_cape_voyage_id,
    return_voyage_id,
    remark,
    source_id,
    source_reference,
    uid,
    scan_permalink
)
SELECT
    vocop_id::INTEGER,
    full_name,
    place_of_origin,
    NULLIF(place_id, '')::INTEGER,
    CASE
        WHEN disambiguated_person ILIKE 'ja' THEN TRUE
        WHEN disambiguated_person ILIKE 'nee' THEN FALSE
        WHEN disambiguated_person IN ('1','true','t') THEN TRUE
        WHEN disambiguated_person IN ('0','false','f') THEN FALSE
        ELSE NULL
    END AS disambiguated_person,
    NULLIF(person_cluster_id, '')::NUMERIC::INTEGER AS person_cluster_id,
    NULLIF(person_cluster_row, '')::NUMERIC::INTEGER AS person_cluster_row,
    rank,
    CASE
        WHEN rank_corrected ILIKE 'ja' THEN TRUE
        WHEN rank_corrected ILIKE 'nee' THEN FALSE
        WHEN rank_corrected IN ('1','true','t') THEN TRUE
        WHEN rank_corrected IN ('0','false','f') THEN FALSE
        ELSE NULL
    END AS rank_corrected,
    NULLIF(rank_id, '')::INTEGER AS rank_id,
    CASE
        WHEN debt_letter ILIKE 'ja' THEN TRUE
        WHEN debt_letter ILIKE 'nee' THEN FALSE
        WHEN debt_letter IN ('1','true','t') THEN TRUE
        WHEN debt_letter IN ('0','false','f') THEN FALSE
        ELSE NULL
    END AS debt_letter,
    CASE
        WHEN month_letter ILIKE 'ja' THEN TRUE
        WHEN month_letter ILIKE 'nee' THEN FALSE
        WHEN month_letter IN ('1','true','t') THEN TRUE
        WHEN month_letter IN ('0','false','f') THEN FALSE
        ELSE NULL
    END AS month_letter,
    NULLIF(date_begin_contract, '')::DATE AS date_begin_contract,
    NULLIF(date_end_contract, '')::DATE AS date_end_contract,
    NULLIF(contract_length, '')::INTEGER AS contract_length,
    reason_end_contract,
    CASE
        WHEN could_muster_again ILIKE 'ja' THEN TRUE
        WHEN could_muster_again ILIKE 'nee' THEN FALSE
        WHEN could_muster_again IN ('1','true','t') THEN TRUE
        WHEN could_muster_again IN ('0','false','f') THEN FALSE
        ELSE NULL
    END AS could_muster_again,
    location_end_contract,
    NULLIF(outward_voyage_id, '')::INTEGER AS outward_voyage_id,
    CASE
        WHEN changed_ship_at_cape ILIKE 'ja' THEN TRUE
        WHEN changed_ship_at_cape ILIKE 'nee' THEN FALSE
        WHEN changed_ship_at_cape IN ('1','true','t') THEN TRUE
        WHEN changed_ship_at_cape IN ('0','false','f') THEN FALSE
        ELSE NULL
    END AS changed_ship_at_cape,
    NULLIF(changed_ship_at_cape_voyage_id, '')::INTEGER AS changed_ship_at_cape_voyage_id,
    NULLIF(return_voyage_id, '')::INTEGER AS return_voyage_id,
    remark,
    NULLIF(source_id, '')::INTEGER AS source_id,
    source_reference,
    uid::UUID,
    scan_permalink
FROM voc_raw.voc_persons_contracts;


COMMENT ON COLUMN voc.voc_persons_contracts.vocop_id IS 'Muster record ID; each record describes a VOC employee in the pay ledger of a voyage.';
COMMENT ON COLUMN voc.voc_persons_contracts.full_name IS 'Full name of the VOC employee.';
COMMENT ON COLUMN voc.voc_persons_contracts.place_of_origin IS 'Place of origin of the employee.';
COMMENT ON COLUMN voc.voc_persons_contracts.place_id IS 'ID of place of origin (refers to voc_places.place_id).';
COMMENT ON COLUMN voc.voc_persons_contracts.disambiguated_person IS 'TRUE if record belongs to a disambiguated person (merged across voyages).';
COMMENT ON COLUMN voc.voc_persons_contracts.person_cluster_id IS 'Cluster ID grouping all records belonging to the same disambiguated person.';
COMMENT ON COLUMN voc.voc_persons_contracts.person_cluster_row IS 'Ordinal rank of the voyage in a disambiguated person’s career (e.g., 3 = third contract).';
COMMENT ON COLUMN voc.voc_persons_contracts.rank IS 'Rank designation in the original dataset (possibly corrected by Huygens).';
COMMENT ON COLUMN voc.voc_persons_contracts.rank_corrected IS 'TRUE if rank corrected for transcription or post-1783 rank change.';
COMMENT ON COLUMN voc.voc_persons_contracts.rank_id IS 'Unique ID of the rank (refers to voc_ranks.rank_id).';
COMMENT ON COLUMN voc.voc_persons_contracts.debt_letter IS 'TRUE if employee signed a debt letter.';
COMMENT ON COLUMN voc.voc_persons_contracts.month_letter IS 'TRUE if employee signed a month letter.';
COMMENT ON COLUMN voc.voc_persons_contracts.date_begin_contract IS 'Start date of the employment contract.';
COMMENT ON COLUMN voc.voc_persons_contracts.date_end_contract IS 'End date of the contract (possibly supplemented from return ship data).';
COMMENT ON COLUMN voc.voc_persons_contracts.contract_length IS 'Length of contract in days.';
COMMENT ON COLUMN voc.voc_persons_contracts.reason_end_contract IS 'Reason why the employment contract ended.';
COMMENT ON COLUMN voc.voc_persons_contracts.could_muster_again IS 'TRUE if employee could muster again on a later voyage given the end reason.';
COMMENT ON COLUMN voc.voc_persons_contracts.location_end_contract IS 'Location where contract ended (often name of return ship).';
COMMENT ON COLUMN voc.voc_persons_contracts.outward_voyage_id IS 'DAS voyage ID of the outward voyage (refers to voc_voyages.das_voyage_id).';
COMMENT ON COLUMN voc.voc_persons_contracts.changed_ship_at_cape IS 'TRUE if employee changed ship at the Cape of Good Hope.';
COMMENT ON COLUMN voc.voc_persons_contracts.changed_ship_at_cape_voyage_id IS 'DAS voyage ID of the outward voyage joined from the Cape.';
COMMENT ON COLUMN voc.voc_persons_contracts.return_voyage_id IS 'DAS voyage ID of the return voyage.';
COMMENT ON COLUMN voc.voc_persons_contracts.remark IS 'General remark (in Dutch).';
COMMENT ON COLUMN voc.voc_persons_contracts.source_id IS 'ID of source record from which the muster record originates (refers to voc_sources.source_id).';
COMMENT ON COLUMN voc.voc_persons_contracts.source_reference IS 'Reference to physical record in VOC archives (inventory number and page).';
COMMENT ON COLUMN voc.voc_persons_contracts.uid IS 'Unique record ID in the National Archives database.';
COMMENT ON COLUMN voc.voc_persons_contracts.scan_permalink IS 'Permalink to scan of the original muster record.';
