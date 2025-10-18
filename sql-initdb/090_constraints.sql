-- voc_names > voc_persons_contracts
ALTER TABLE voc.voc_names
ADD CONSTRAINT fk_voc_names_person
FOREIGN KEY (vocop_id)
REFERENCES voc.voc_persons_contracts (vocop_id)
ON UPDATE CASCADE
ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_voc_names_vocop_id
    ON voc.voc_names (vocop_id);


-- Fix missing vocop_id in voc_persons_contracts
INSERT INTO voc.voc_persons_contracts (vocop_id)
SELECT DISTINCT b.vocop_id
FROM voc.voc_beneficiaries b
LEFT JOIN voc.voc_persons_contracts p USING (vocop_id)
WHERE p.vocop_id IS NULL
  AND b.vocop_id IS NOT NULL;


-- voc_beneficiaries > voc_persons_contracts
ALTER TABLE voc.voc_beneficiaries
ADD CONSTRAINT fk_voc_beneficiaries_person
FOREIGN KEY (vocop_id)
REFERENCES voc.voc_persons_contracts (vocop_id)
ON UPDATE CASCADE
ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_voc_beneficiaries_vocop_id
    ON voc.voc_beneficiaries (vocop_id);


-- voc_persons_contracts > voc_ranks
ALTER TABLE voc.voc_persons_contracts
ADD CONSTRAINT fk_voc_persons_contracts_rank
FOREIGN KEY (rank_id)
REFERENCES voc.voc_ranks (rank_id)
ON UPDATE CASCADE
ON DELETE SET NULL;

CREATE INDEX IF NOT EXISTS idx_voc_persons_contracts_rank_id
    ON voc.voc_persons_contracts (rank_id);


-- voc_persons_contracts > voc_places
ALTER TABLE voc.voc_persons_contracts
ADD CONSTRAINT fk_voc_persons_contracts_place
FOREIGN KEY (place_id)
REFERENCES voc.voc_places (place_id)
ON UPDATE CASCADE
ON DELETE SET NULL;

CREATE INDEX IF NOT EXISTS idx_voc_persons_contracts_place_id
    ON voc.voc_persons_contracts (place_id);

-- voc_places > voc_places_standardized
ALTER TABLE voc.voc_places
ADD CONSTRAINT fk_voc_places_standardized
FOREIGN KEY (place_standardized_id)
REFERENCES voc.voc_places_standardized (place_standardized_id)
ON UPDATE CASCADE
ON DELETE SET NULL;

CREATE INDEX IF NOT EXISTS idx_voc_places_place_standardized_id
    ON voc.voc_places (place_standardized_id);

-- voc_persons_contracts > voc_sources
ALTER TABLE voc.voc_persons_contracts
ADD CONSTRAINT fk_voc_persons_contracts_source_id
FOREIGN KEY (source_id)
REFERENCES voc.voc_sources (source_id)
ON UPDATE CASCADE
ON DELETE SET NULL;

CREATE INDEX IF NOT EXISTS idx_voc_persons_contracts_source_id
    ON voc.voc_persons_contracts (source_id);

-- voc_persons_contracts > voc_voyages (drie relaties)

-- 1. outward_voyage_id
ALTER TABLE voc.voc_persons_contracts
ADD CONSTRAINT fk_voc_persons_contracts_outward_voyage
FOREIGN KEY (outward_voyage_id)
REFERENCES voc.voc_voyages (das_voyage_id)
ON UPDATE CASCADE
ON DELETE SET NULL;

CREATE INDEX IF NOT EXISTS idx_voc_persons_contracts_outward_voyage_id
    ON voc.voc_persons_contracts (outward_voyage_id);

-- 2. changed_ship_at_cape_voyage_id
ALTER TABLE voc.voc_persons_contracts
ADD CONSTRAINT fk_voc_persons_contracts_changed_ship_at_cape_voyage
FOREIGN KEY (changed_ship_at_cape_voyage_id)
REFERENCES voc.voc_voyages (das_voyage_id)
ON UPDATE CASCADE
ON DELETE SET NULL;

CREATE INDEX IF NOT EXISTS idx_voc_persons_contracts_changed_ship_at_cape_voyage_id
    ON voc.voc_persons_contracts (changed_ship_at_cape_voyage_id);

-- 3. return_voyage_id
ALTER TABLE voc.voc_persons_contracts
ADD CONSTRAINT fk_voc_persons_contracts_return_voyage
FOREIGN KEY (return_voyage_id)
REFERENCES voc.voc_voyages (das_voyage_id)
ON UPDATE CASCADE
ON DELETE SET NULL;

CREATE INDEX IF NOT EXISTS idx_voc_persons_contracts_return_voyage_id
    ON voc.voc_persons_contracts (return_voyage_id);


-- Vul ontbrekende voyages in vanuit voc_sources
INSERT INTO voc.voc_voyages (das_voyage_id)
SELECT DISTINCT s.das_voyage_id
FROM voc.voc_sources s
LEFT JOIN voc.voc_voyages v USING (das_voyage_id)
WHERE s.das_voyage_id IS NOT NULL
  AND v.das_voyage_id IS NULL;


-- voc_sources > voc_voyages
ALTER TABLE voc.voc_sources
ADD CONSTRAINT fk_voc_sources_voyage
FOREIGN KEY (das_voyage_id)
REFERENCES voc.voc_voyages (das_voyage_id)
ON UPDATE CASCADE
ON DELETE SET NULL;

CREATE INDEX IF NOT EXISTS idx_voc_sources_das_voyage_id
    ON voc.voc_sources (das_voyage_id);
