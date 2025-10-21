# Wie reisde er meer dan 1 keer?

De view person_summary laat zien hoe vaak personen die geclusterd konden worden op vocop_id hebben gereisd.

```sql
SELECT * FROM voc.person_summary
```

person_cluster_id=3895 (maakt veel reizen)

Interessante id's

Joseph Corties

person_cluster_id=43627 (maakt overstap)



```sql
SELECT
    vpc.person_cluster_id,
    vpc.vocop_id,
    vps.place_standardized_id,
    vn.full_name_normalized,
    vr.rank_nl,
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
LEFT JOIN voc.voc_places vp ON vp.place_id = vpc.place_id
LEFT JOIN voc.voc_places_standardized vps ON vp.place_standardized_id = vps.place_standardized_id
LEFT JOIN voc.voc_names vn ON vn.vocop_id = vpc.vocop_id
LEFT JOIN voc.voc_ranks vr ON vr.rank_id = vpc.rank_id
LEFT JOIN LATERAL (
    SELECT * FROM (
        SELECT 'outward' AS voyage_type, * FROM voc.voc_voyages vv WHERE vv.das_voyage_id = vpc.outward_voyage_id
        UNION ALL
        SELECT 'changed_ship', * FROM voc.voc_voyages vv WHERE vv.das_voyage_id = vpc.changed_ship_at_cape_voyage_id
        UNION ALL
        SELECT 'return', * FROM voc.voc_voyages vv WHERE vv.das_voyage_id = vpc.return_voyage_id
    ) t
) vvoy ON TRUE
LEFT JOIN voc.person_summary ps
ON ps.person_cluster_id = vpc.person_cluster_id
WHERE vpc.person_cluster_id = '3895'
ORDER BY vpc.person_cluster_row, vvoy.departure_date;
```

|person_cluster_id|vocop_id |full_name_normalized|rank_nl        |voyage_type |das_voyage_id|num_contracts|person_cluster_row|chamber  |ship_name        |ship_tonnage|direction|departure_date|arrival_date_cape|departure_date_cape|arrival_date|departure_place|arrival_place|rank_id|rank             |parent_rank  |category|subcategory              |hisco |hisco_uri                                             |rank_nl        |rank_description_nl                                                                                                                     |rank_description_eng                                                                                                                |median_wage|
|-----------------|---------|--------------------|---------------|------------|-------------|-------------|------------------|---------|-----------------|------------|---------|--------------|-----------------|-------------------|------------|---------------|-------------|-------|-----------------|-------------|--------|-------------------------|------|------------------------------------------------------|---------------|----------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------|-----------|
|43,627           |1,598,732|Dirk Renvoort       |jongen         |outward     |92,717       |8            |1                 |Amsterdam|Nichtevecht      |825         |outward  |1693-01-17    |1693-08-19       |1693-09-08         |1693-11-20  |Texel          |Batavia      |166    |ship's boy       |junior sailor|SEA     |sailors                  |98,140|https://iisg.amsterdam/resource/hisco/code/hisco/98140|jongen         |jonger dan 17 jaar, allerlei karweitjes aan boord                                                                                       |(dutch: jongen) younger than 17 years, various odd jobs onboard                                                                     |7          |
|43,627           |1,598,732|Dirk Renvoort       |jongen         |return      |96,879       |8            |1                 |Amsterdam|Gent             |816         |return   |1698-02-11    |1698-04-17       |1698-05-08         |1698-08-16  |Batavia        |Texel        |166    |ship's boy       |junior sailor|SEA     |sailors                  |98,140|https://iisg.amsterdam/resource/hisco/code/hisco/98140|jongen         |jonger dan 17 jaar, allerlei karweitjes aan boord                                                                                       |(dutch: jongen) younger than 17 years, various odd jobs onboard                                                                     |7          |
|43,627           |1,567,276|Dirk Remvoort       |bosschieter    |outward     |92,854       |8            |2                 |Amsterdam|Nichtevecht      |825         |outward  |1699-02-01    |                 |                   |1699-06-29  |Texel          |Batavia      |163    |ship gunner      |sailor       |SEA     |sailors                  |98,135|https://iisg.amsterdam/resource/hisco/code/hisco/98135|bosschieter    |ervaren matroos, ook belast met het afvuren van een kanon                                                                               |(dutch: busschieter) experienced seaman also responsible for firing a cannon                                                        |11         |
|43,627           |1,567,276|Dirk Remvoort       |bosschieter    |return      |96,964       |8            |2                 |Amsterdam|Geelvink         |380         |return   |1702-01-31    |1702-04-30       |1702-05-18         |1702-08-29  |Batavia        |Texel        |163    |ship gunner      |sailor       |SEA     |sailors                  |98,135|https://iisg.amsterdam/resource/hisco/code/hisco/98135|bosschieter    |ervaren matroos, ook belast met het afvuren van een kanon                                                                               |(dutch: busschieter) experienced seaman also responsible for firing a cannon                                                        |11         |
|43,627           |1,615,217|Dirk Remvoort       |kwartiermeester|outward     |92,978       |8            |3                 |Amsterdam|Berkel           |280         |outward  |1703-04-28    |1703-10-01       |1703-11-04         |1704-01-20  |Texel          |Batavia      |118    |quartermaster    |quartermaster|SEA     |non-commissioned officers|98,130|https://iisg.amsterdam/resource/hisco/code/hisco/98130|kwartiermeester|directe contole op groepen manschappen, ronddeling warm eten en ordehandhaving tijdens het schaften                                     |(dutch: kwartiermeester) has direct control over the crew and the distribution of warm meals and maintaining order during meal time.|14         |
|43,627           |1,615,217|Dirk Remvoort       |kwartiermeester|return      |97,037       |8            |3                 |Hoorn    |Huis Te Nieuwburg|618         |return   |1706-02-13    |1706-06-07       |1706-07-05         |1706-11-15  |Batavia        |Terschelling |118    |quartermaster    |quartermaster|SEA     |non-commissioned officers|98,130|https://iisg.amsterdam/resource/hisco/code/hisco/98130|kwartiermeester|directe contole op groepen manschappen, ronddeling warm eten en ordehandhaving tijdens het schaften                                     |(dutch: kwartiermeester) has direct control over the crew and the distribution of warm meals and maintaining order during meal time.|14         |
|43,627           |1,561,020|Dirk Remvoort       |kwartiermeester|outward     |92,978       |8            |4                 |Amsterdam|Berkel           |280         |outward  |1703-04-28    |1703-10-01       |1703-11-04         |1704-01-20  |Texel          |Batavia      |118    |quartermaster    |quartermaster|SEA     |non-commissioned officers|98,130|https://iisg.amsterdam/resource/hisco/code/hisco/98130|kwartiermeester|directe contole op groepen manschappen, ronddeling warm eten en ordehandhaving tijdens het schaften                                     |(dutch: kwartiermeester) has direct control over the crew and the distribution of warm meals and maintaining order during meal time.|14         |
|43,627           |1,561,020|Dirk Remvoort       |kwartiermeester|changed_ship|92,983       |8            |4                 |Amsterdam|Lek              |762         |outward  |1703-05-27    |1703-10-14       |1703-11-12         |1704-01-20  |Texel          |Batavia      |118    |quartermaster    |quartermaster|SEA     |non-commissioned officers|98,130|https://iisg.amsterdam/resource/hisco/code/hisco/98130|kwartiermeester|directe contole op groepen manschappen, ronddeling warm eten en ordehandhaving tijdens het schaften                                     |(dutch: kwartiermeester) has direct control over the crew and the distribution of warm meals and maintaining order during meal time.|14         |
|43,627           |1,557,723|Dirk Renvoort       |bootsman       |outward     |93,203       |8            |5                 |Amsterdam|Horstendaal      |688         |outward  |1711-05-31    |1711-10-15       |1711-11-29         |1712-02-28  |Texel          |Batavia      |19     |boatswain        |boatswain    |SEA     |non-commissioned officers|98,120|https://iisg.amsterdam/resource/hisco/code/hisco/98120|bootsman       |heeft het toezicht op de bootsgezellen; toezicht op zeil en treil van de grote mast, dat wil zeggen, alles dat behoort bij de grote mast|(dutch: bootsman)                                                                                                                   |22         |
|43,627           |1,557,723|Dirk Renvoort       |bootsman       |return      |97,196       |8            |5                 |Zeeland  |Schellenberg     |630         |return   |1714-12-21    |1715-03-06       |1715-04-05         |1715-08-06  |Ceylon         |Rammekens    |19     |boatswain        |boatswain    |SEA     |non-commissioned officers|98,120|https://iisg.amsterdam/resource/hisco/code/hisco/98120|bootsman       |heeft het toezicht op de bootsgezellen; toezicht op zeil en treil van de grote mast, dat wil zeggen, alles dat behoort bij de grote mast|(dutch: bootsman)                                                                                                                   |22         |
|43,627           |1,419,368|Dirk Renvoort       |stuurman       |outward     |93,330       |8            |6                 |Amsterdam|Geen Rust        |150         |outward  |1716-10-16    |1717-05-08       |                   |            |Texel          |             |111    |navigator        |second mate  |SEA     |officers                 |4,200 |https://iisg.amsterdam/resource/hisco/code/hisco/04200|stuurman       |verantwoordelijk voor de navigatie                                                                                                      |(dutch: stuurman)                                                                                                                   |32         |
|43,627           |1,419,368|Dirk Renvoort       |stuurman       |return      |97,313       |8            |6                 |Amsterdam|Amsterdam        |800         |return   |1719-11-21    |1720-02-20       |1720-04-19         |1720-08-06  |Ceylon         |Texel        |111    |navigator        |second mate  |SEA     |officers                 |4,200 |https://iisg.amsterdam/resource/hisco/code/hisco/04200|stuurman       |verantwoordelijk voor de navigatie                                                                                                      |(dutch: stuurman)                                                                                                                   |32         |
|43,627           |613,021  |Dirk Revoort        |schipper       |outward     |93,481       |8            |7                 |Amsterdam|Hopvogel         |600         |outward  |1720-11-21    |1721-06-09       |1721-07-11         |1721-09-08  |Texel          |Batavia      |167    |skipper or master|captain      |SEA     |officers                 |4,217 |https://iisg.amsterdam/resource/hisco/code/hisco/04217|schipper       |belangrijkste man aan boord, algehele leiding                                                                                           |most important man onboard, has entire command                                                                                      |72         |
|43,627           |613,021  |Dirk Revoort        |schipper       |return      |97,484       |8            |7                 |Hoorn    |Hopvogel         |600         |return   |1724-12-01    |1725-03-21       |1725-04-11         |1725-07-24  |Batavia        |Texel        |167    |skipper or master|captain      |SEA     |officers                 |4,217 |https://iisg.amsterdam/resource/hisco/code/hisco/04217|schipper       |belangrijkste man aan boord, algehele leiding                                                                                           |most important man onboard, has entire command                                                                                      |72         |
|43,627           |156,036  |Dirk Renvoort       |stuurman       |changed_ship|93,353       |8            |                  |Zeeland  |Vaderland Getrouw|848         |outward  |1717-05-15    |1717-10-01       |1717-11-27         |1718-03-13  |Wielingen      |Ceylon       |111    |navigator        |second mate  |SEA     |officers                 |4,200 |https://iisg.amsterdam/resource/hisco/code/hisco/04200|stuurman       |verantwoordelijk voor de navigatie                                                                                                      |(dutch: stuurman)                                                                                                                   |32         |


```sql
SELECT
	vpc.person_cluster_id AS contracts_cluster_id,
	vpc.vocop_id AS contracts_vocop_id,
	vn.full_name_normalized AS names_full_name_normalized, 
	vn.family_name_normalized AS names_family_name_normalized, 
	vn.first_name_normalized AS names_first_name_normalized,
	vp.place_id AS places_place_id,
	vps.place_standardized AS placesstd_place_standardized,
	ps.num_contracts AS persons_num_contracts,
	vpc.person_cluster_row AS contracts_cluster_row,
	vpc."rank" AS contracts_rank,
	vpc.rank_corrected AS contracts_rank_corrected,
	vpc.outward_voyage_id AS contracts_outward_voyage_id,
	vv1.ship_name AS voyages_outward_ship_name,
	vv1.direction AS voyages_outward_direction,
	vr.*,
	ps.*
FROM
	person_summary ps
LEFT JOIN voc_persons_contracts vpc 
ON ps.person_cluster_id = vpc.person_cluster_id
LEFT JOIN voc_names vn 
ON vn.vocop_id = vpc.vocop_id
LEFT JOIN voc_places vp 
ON vp.place_id = vpc.place_id 
LEFT JOIN voc_places_standardized vps 
ON vp.place_standardized_id = vps.place_standardized_id 
LEFT JOIN voc_ranks vr
ON vr.rank_id = vpc.rank_id
LEFT JOIN voc_voyages vv1
ON vv1.das_voyage_id = vpc.outward_voyage_id
WHERE
	ps.person_cluster_id = '3895'
ORDER BY vpc.person_cluster_row ASC;
```