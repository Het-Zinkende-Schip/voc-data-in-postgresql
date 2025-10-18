CREATE TABLE voc.voc_beneficiaries (
    beneficiary_id INTEGER PRIMARY KEY,
    full_name TEXT,
    first_name TEXT,
    patronymic TEXT,
    family_name_prefix TEXT,
    family_name TEXT,
    place_of_origin TEXT,
    relation TEXT,
    remark TEXT,
    vocop_id INTEGER,
    uid UUID
);


COPY voc.voc_beneficiaries (
    beneficiary_id,
    full_name,
    first_name,
    patronymic,
    family_name_prefix,
    family_name,
    place_of_origin,
    relation,
    remark,
    vocop_id,
    uid
)
FROM '/unzipped/enriched/voc_beneficiaries.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ',',
    QUOTE '"',
    ESCAPE '"',
    NULL '',
    ENCODING 'UTF8'
);


COMMENT ON COLUMN voc.voc_beneficiaries.beneficiary_id IS 'Record ID; each record describes the beneficiary of a month letter.';
COMMENT ON COLUMN voc.voc_beneficiaries.full_name IS 'Full name of the beneficiary.';
COMMENT ON COLUMN voc.voc_beneficiaries.first_name IS 'First name of beneficiary.';
COMMENT ON COLUMN voc.voc_beneficiaries.patronymic IS 'Patronymic of beneficiary.';
COMMENT ON COLUMN voc.voc_beneficiaries.family_name_prefix IS 'Family name prefix of beneficiary.';
COMMENT ON COLUMN voc.voc_beneficiaries.family_name IS 'Family name of beneficiary.';
COMMENT ON COLUMN voc.voc_beneficiaries.place_of_origin IS 'Place of origin of the beneficiary.';
COMMENT ON COLUMN voc.voc_beneficiaries.relation IS 'Relation of the beneficiary to the VOC employee.';
COMMENT ON COLUMN voc.voc_beneficiaries.remark IS 'Remark on the month letter or beneficiary relation (often institution name).';
COMMENT ON COLUMN voc.voc_beneficiaries.vocop_id IS 'VOC employee record ID this beneficiary relates to (refers to voc_persons_contracts.vocop_id).';
COMMENT ON COLUMN voc.voc_beneficiaries.uid IS 'Unique record ID in the National Archives database.';
