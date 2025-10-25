Joris van Spilbergen

## Macau (china)

person_cluster_id

35766 > Wilhelm van Meeseberg (gestorven in 1767 te Macau)
37061 > Pieter Kintsius (gestorven in 1786 te Macau)
37666 > Egbent van Karnebeek
32478 > Jaen Henri Rabinel (gestorven op 24 maart 1816 te Macau)

TO BE CONTINUED, WORK IN PROGRESS

## Niet op komen dagen

```sql
select * 
from voc.voc_persons_contracts vpc
where vpc.reason_end_contract = 'Absent upon departure'
and person_cluster_id is not null;
```

## Death penalty

```sql
SELECT pd.person_cluster_id, pd2.*
FROM voc.person_detail_view pd
LEFT JOIN voc.person_detail_view pd2
ON pd.person_cluster_id = pd2.person_cluster_id
WHERE  pd.person_cluster_id IS NOT null
AND pd.reason_end_contract = 'Death penalty'
ORDER BY pd.person_cluster_id, pd2.person_cluster_row ASC, departure_date asc
```

```
--het aantal unieke personen (clusters) die geëindigd zijn met de reden Death penalty.
SELECT COUNT(*) AS num_persons
FROM (
    SELECT pd.person_cluster_id
    FROM voc.person_detail_view pd
    WHERE pd.person_cluster_id IS NOT NULL
      AND pd.reason_end_contract = 'Death penalty'
    GROUP BY pd.person_cluster_id
) sub;
```