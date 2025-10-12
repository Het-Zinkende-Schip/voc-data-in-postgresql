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
FROM '/csv/voc_names.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ',',
    QUOTE '"',
    ESCAPE '"',
    NULL '',
    ENCODING 'UTF8'
);
