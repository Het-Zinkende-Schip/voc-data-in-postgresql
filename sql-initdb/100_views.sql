--Elke rij vertegenwoordigt één persoon (person_cluster_id) en bevat een overzicht van zijn contracthistorie.
CREATE VIEW voc.person_summary AS
SELECT 
    vpc.person_cluster_id,
    MAX(vpc.full_name) AS example_name,
    MAX(vpc.place_of_origin) AS example_origin,
    COUNT(vpc.vocop_id) AS num_contracts,
    MIN(vpc.date_begin_contract) AS first_contract,
    MAX(vpc.date_end_contract) AS last_contract
FROM
    voc.voc_persons_contracts vpc
WHERE
    vpc.disambiguated_person = TRUE
GROUP BY
    vpc.person_cluster_id
ORDER BY
    num_contracts DESC;

-- De view voc.person_detail_view geeft een verzicht per persoon met:
-- naam en basisgegevens,
-- contractinformatie,
-- alle reizen (uitgaand, wissel, terug),
-- en bijbehorende scheeps- en ranginformatie.
CREATE OR REPLACE VIEW voc.person_detail_view AS
SELECT 
    vpc.person_cluster_id,
    vpc.vocop_id,
    vn.full_name_normalized,
    ps.num_contracts,
    vpc.person_cluster_row,
    vpc.reason_end_contract,
    vvoy.direction,
    vvoy.chamber,
    vvoy.ship_name,
    vvoy.ship_tonnage,
    vvoy.voyage_type,
    vvoy.departure_date,
    vvoy.arrival_date_cape,
    vvoy.departure_date_cape,
    vvoy.arrival_date,
    vvoy.departure_place,
    vvoy.arrival_place,
    vvoy.das_voyage_id,
    vr.*
FROM voc.voc_persons_contracts vpc
LEFT JOIN voc.voc_names vn 
    ON vn.vocop_id = vpc.vocop_id
LEFT JOIN voc.voc_ranks vr 
    ON vr.rank_id = vpc.rank_id
LEFT JOIN LATERAL (
    SELECT *
    FROM (
        SELECT 
            'outward' AS voyage_type,
            vv.*
        FROM voc.voc_voyages vv 
        WHERE vv.das_voyage_id = vpc.outward_voyage_id

        UNION ALL

        SELECT 
            'changed_ship' AS voyage_type,
            vv.*
        FROM voc.voc_voyages vv 
        WHERE vv.das_voyage_id = vpc.changed_ship_at_cape_voyage_id

        UNION ALL

        SELECT 
            'return' AS voyage_type,
            vv.*
        FROM voc.voc_voyages vv 
        WHERE vv.das_voyage_id = vpc.return_voyage_id
    ) t
) vvoy ON TRUE
LEFT JOIN voc.person_summary ps 
    ON ps.person_cluster_id = vpc.person_cluster_id
ORDER BY 
    vpc.person_cluster_row, 
    vpc.person_cluster_row ASC,
    vvoy.departure_date asc;
