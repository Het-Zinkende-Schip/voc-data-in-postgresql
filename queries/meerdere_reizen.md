# Wie reisde er meer dan 1 keer?

## Relatie tussen vocop_id en person_cluster_id

Monsteren = formeel in dienst treden op een schip.

| kolom | betekenis  | niveau |
| ----- | -----      | ------- |
| vocop_id| ID van één monsterrecord | reisniveau | 
| person_cluster_id| ID van een geïdentificeerde persoon, samengesteld uit meerdere vocop_id records die bij dezelfde persoon horen | persoonsniveau|


### context

* In het oorspronkelijke systeem kreeg iedere opvarende per reis een **vocop_id**.
  
  Dus als iemand **4 reizen** maakte, heeft hij **4 verschillende vocop_id’s**.

* De onderzoekers hebben met behulp van **namen, plaatsen en data** geprobeerd om die samen te voegen tot een **disambiguated person**.

  Die persoon kreeg:

  * **person_cluster_id** identificeert *dezelfde persoon over meerdere reizen*.
  * **person_cluster_row** de *volgorde* van zijn reizen (bijv. 1 = eerste contract, 2 = tweede contract...).

Dus bijvoorbeeld:

|vocop_id|person_cluster_id|person_cluster_row|full_name       |
|--------|-----------------|------------------|----------------|
|104,946 |1                |1                 |Arnoldus Coutrel|
|142,988 |1                |2                 |Arnoldus Coetrel|
|147,977 |1                |3                 |Arnoldus Cotrel |
|155,217 |1                |4                 |Arnoldus Cortrel|

```sql
SELECT
	vpc.vocop_id ,
	vpc.person_cluster_id, 
	vpc.person_cluster_row,
	vpc.full_name
FROM
	voc.voc_persons_contracts vpc
LEFT JOIN voc.voc_names vn 
ON
	vpc.vocop_id = vn.vocop_id
ORDER BY
	vpc.person_cluster_id,
	vpc.person_cluster_row ASC
```


## Personen die meerdere keren voeren

lijst van alle geïdentificeerde personen die meerdere keren voeren, inclusief hun naam, afkomst en hun eerste/laatste contractdata.

```sql
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
HAVING
    COUNT(vpc.vocop_id) > 1
ORDER BY
    num_contracts DESC;
```

Voorbeeld:

|person_cluster_id|example_name             |example_origin|num_contracts|first_contract|last_contract|
|-----------------|-------------------------|--------------|-------------|--------------|-------------|
|35,855           |Hendrik Korier           |St hage       |12           |1754-05-20    |1789-09-04   |
|22,405           |Jan Mijndertsz van Hoijen|Amsterdam     |12           |1712-10-27    |1747-11-25   |
|35,709           |Fridrik Woutersz         |Koppenhagen   |12           |1753-11-09    |1780-06-09   |
