CREATE TABLE voc.voc_names (
    vocop_id INTEGER NOT NULL,
    full_name_original TEXT,
    first_name_original TEXT,
    patronymic_original TEXT,
    family_name_prefix_original TEXT,
    family_name_original TEXT,
    full_name_normalized TEXT,
    first_name_normalized TEXT,
    patronymic_normalized TEXT,
    family_name_prefix_normalized TEXT,
    family_name_normalized TEXT
);


COPY voc.voc_names (
    vocop_id,
    full_name_original,
    first_name_original,
    patronymic_original,
    family_name_prefix_original,
    family_name_original,
    full_name_normalized,
    first_name_normalized,
    patronymic_normalized,
    family_name_prefix_normalized,
    family_name_normalized
)
FROM '/unzipped/enriched/voc_names.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ',',
    QUOTE '"',
    ESCAPE '"',
    NULL '',
    ENCODING 'UTF8'
);


COMMENT ON COLUMN voc.voc_names.vocop_id IS 'Muster record ID from which the name originates (refers to voc_persons_contracts.vocop_id).';
COMMENT ON COLUMN voc.voc_names.full_name_original IS 'Full name of the employee as written in the original record.';
COMMENT ON COLUMN voc.voc_names.first_name_original IS 'Original first name of employee.';
COMMENT ON COLUMN voc.voc_names.patronymic_original IS 'Original patronymic of employee.';
COMMENT ON COLUMN voc.voc_names.family_name_prefix_original IS 'Original family name prefix (e.g., “de”, “van”).';
COMMENT ON COLUMN voc.voc_names.family_name_original IS 'Original family name of employee.';
COMMENT ON COLUMN voc.voc_names.full_name_normalized IS 'Normalized (standardized) full name of employee.';
COMMENT ON COLUMN voc.voc_names.first_name_normalized IS 'Normalized first name of employee.';
COMMENT ON COLUMN voc.voc_names.patronymic_normalized IS 'Normalized patronymic of employee.';
COMMENT ON COLUMN voc.voc_names.family_name_prefix_normalized IS 'Normalized family name prefix.';
COMMENT ON COLUMN voc.voc_names.family_name_normalized IS 'Normalized family name.';
