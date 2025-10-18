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
