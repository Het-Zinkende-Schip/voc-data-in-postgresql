# Find coordinates of places of arrival

```sql
SELECT DISTINCT vv.arrival_place
FROM voc.voc_voyages vv
WHERE vv.arrival_place IS NOT NULL
ORDER BY vv.arrival_place ASC;
```

I looked them up in https://www.openstreetmap.org/ (manually)

I neede help from https://nl.wikipedia.org/wiki/Lijst_van_handelsposten_en_nederzettingen_van_de_VOC
and from https://www.vocsite.nl/woordenlijst/geo/

The coordinates should be good enough for the HackaLOD game.

Tegenapatnam (ook wel Kudalur; nu Cuddalore) 

Data is in: [voc_arrival_places.csv](./voc_arrival_places.csv)

`INSERT`-statement is here: [110_voc_extra_arrival_place_locations.sql](../sql-initdb/110_voc_extra_arrival_place_locations.sql)

# betekenis end-of-contracts

Er is wel iets te vinden in het glossarium van het Huygens Institute (in samenwerking met KNAW): https://resources.huygens.knaw.nl/pdf/vocglossarium/VOCGlossarium.pdf

```sql
select distinct vpc.reason_end_contract
from voc.voc_persons_contracts vpc
```

https://zenodo.org/records/10599528/files/The%20Dutch%20East%20India%20Company%E2%80%99s%20Eighteenth-Century%20Workforce.%20An%20Enriched%20Data%20Collection.pdf


| Term                      | Betekenis in VOC-personeels/-scheepsdata|
| ------------------------- | ---------------------------------------------------- |
| **Absent upon departure** | Persoon stond op de lijst maar was bij vertrek van het schip **niet aanwezig** / verscheen niet op het schip.|
| **Age**                   | Leeftijd van de persoon (vanwege ouderdom? te jong/te oud?))|
| **Amsterdam chamber**     |  |
| **Death penalty**         | De persoon kreeg een **doodstraf** (mogelijk door de VOC) en werd dus geëxecuteerd.|
| **Deceased**              | De persoon is overleden gedurende dienst of reis; overlijden is geregistreerd.|
| **Delft chamber**         |  |
| **Deserted**              | De persoon heeft zijn dienstverband verlaten zonder toestemming.|
| **Dismissal**             | De persoon is door de VOC of kapitein ontslagen of uit dienst gezet (niet vrijwillig).|
| **Enkhuizen chamber**     | |
| **Free citizen**          | vrijdom (k) · uit de dienst van de Compagnie treden en het recht krijgen zich als vrijburger te vestigen.|
| **In lening gaan**        | ??? door VOC uitgeleend aan andere partij?? |
| **Last record**           | Laatste registratie ???|
| **Missing**               | persoon is vermist geraakt?|
| **Murdered**              | De persoon is vermoord tijdens dienst of reis.|
| **Not recorded**          | Niet geregistreerd ??|
| **Otherwise**             | overige reden voor einde contract |
| **Penalised or punished** | De persoon is gestraft (niet doodstraf, die heeft andere categorie) |
| **Remains at the Cape**   | De persoon bleef achter bij de Kaap de Goede Hoop |
| **Removed**               | De persoon is verwijderd uit dienst of uit de lijst (maar waarom???) |
| **Repatriated**           | Teruggezonden naar het moederland |
| **Resignation**           | De persoon heeft zelf ontslag genomen|
| **Rotterdam chamber**     |  |
| **Shipwrecked**           | De persoon heeft schipbreuk geleden |
| **To a man of war**       | ??? Soldata geworden? |
| **To a private ship**     | Overgeplaatst naar een privé-schip |
| **Transferred**           | Overgeplaatst binnen de VOC-organisatie|
| **Unfit to work**         | Ongeschikt voor werk|
| **Unknown**               | Onbekend |
| **Woman**                 | iets met zijn vrouw aan de hand???|
| **Zeeland chamber**       |  |
| **to regiment**           | Overgegaan naar een regiment ???|

**Free citizen**

17214	"Jan van der Straten"	"Haerlem"

**Unfit to work**

2431	Hendrik Verplank

```sql
select * 
from voc.person_summary vps
left join voc.voc_persons_contracts vpc
on vpc.person_cluster_id = vps.person_cluster_id
where num_contracts > 5
and vpc.reason_end_contract = 'Unfit to work' ;
```



38570	"Nicolaas Korswijl" vanwege **Age**

|person_cluster_id|vocop_id |place_standardized|full_name_normalized|rank_nl        |num_contracts|person_cluster_row|reason_end_contract|direction|chamber  |ship_name        |ship_tonnage|voyage_type |departure_date|arrival_date_cape|departure_date_cape|arrival_date|departure_place|arrival_place|das_voyage_id|rank_id|rank                         |parent_rank  |category|subcategory              |hisco |hisco_uri                                             |rank_nl        |rank_description_nl                                                                                                                                              |rank_description_eng                                                                                                                                               |median_wage|
|-----------------|---------|------------------|--------------------|---------------|-------------|------------------|-------------------|---------|---------|-----------------|------------|------------|--------------|-----------------|-------------------|------------|---------------|-------------|-------------|-------|-----------------------------|-------------|--------|-------------------------|------|------------------------------------------------------|---------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------|
|38,570           |1,313,200|Flensburg         |Nicolaas Korswil    |bosschieter    |5            |1                 |Repatriated        |outward  |Amsterdam|'S Lands Welvaren|880         |outward     |1771-01-11    |1771-04-12       |1771-05-01         |1771-08-08  |Texel          |Bengal       |95,150       |163    |ship gunner                  |sailor       |SEA     |sailors                  |98,135|https://iisg.amsterdam/resource/hisco/code/hisco/98135|bosschieter    |ervaren matroos, ook belast met het afvuren van een kanon                                                                                                        |(dutch: busschieter) experienced seaman also responsible for firing a cannon                                                                                       |11         |
|38,570           |1,313,200|Flensburg         |Nicolaas Korswil    |bosschieter    |5            |1                 |Repatriated        |return   |Amsterdam|Lands Welvaren   |880         |return      |1771-11-21    |1772-01-28       |1772-02-20         |1772-05-30  |Bengal         |Texel        |98,701       |163    |ship gunner                  |sailor       |SEA     |sailors                  |98,135|https://iisg.amsterdam/resource/hisco/code/hisco/98135|bosschieter    |ervaren matroos, ook belast met het afvuren van een kanon                                                                                                        |(dutch: busschieter) experienced seaman also responsible for firing a cannon                                                                                       |11         |
|38,570           |1,329,771|Flensburg         |Nicolaas Korswil    |matroos        |5            |2                 |Repatriated        |outward  |Amsterdam|Aschat           |1,150       |outward     |1772-10-20    |1773-04-15       |1773-06-14         |1773-09-08  |Texel          |Batavia      |95,198       |123    |sailor                       |sailor       |SEA     |sailors                  |98,140|https://iisg.amsterdam/resource/hisco/code/hisco/98140|matroos        |waak- en roergang; laden en lossen; reinigen, teren en kalfaten van het schip; af- en aanslaan van de zeilen; helpers van de onderofficieren. Ook wel bootsgezel.|(dutch: matroos) watch and helmansman duties; loading and unloading; cleaning, taring and caulking the ship; hoisting and pulling in the sails; assisting the ncos.|11         |
|38,570           |1,329,771|Flensburg         |Nicolaas Korswil    |matroos        |5            |2                 |Repatriated        |return   |Amsterdam|Huis Ter Meijen  |1,150       |return      |1773-11-16    |1774-02-04       |1774-03-02         |1774-07-08  |Ceylon         |Texel        |98,744       |123    |sailor                       |sailor       |SEA     |sailors                  |98,140|https://iisg.amsterdam/resource/hisco/code/hisco/98140|matroos        |waak- en roergang; laden en lossen; reinigen, teren en kalfaten van het schip; af- en aanslaan van de zeilen; helpers van de onderofficieren. Ook wel bootsgezel.|(dutch: matroos) watch and helmansman duties; loading and unloading; cleaning, taring and caulking the ship; hoisting and pulling in the sails; assisting the ncos.|11         |
|38,570           |1,383,532|Flensburg         |Nicolaas Korswil    |kwartiermeester|5            |3                 |Repatriated        |outward  |Amsterdam|Jonge Lieve      |1,150       |outward     |1774-09-15    |1775-02-17       |1775-03-28         |1775-07-08  |Texel          |Batavia      |95,262       |118    |quartermaster                |quartermaster|SEA     |non-commissioned officers|98,130|https://iisg.amsterdam/resource/hisco/code/hisco/98130|kwartiermeester|directe contole op groepen manschappen, ronddeling warm eten en ordehandhaving tijdens het schaften                                                              |(dutch: kwartiermeester) has direct control over the crew and the distribution of warm meals and maintaining order during meal time.                               |14         |
|38,570           |1,383,532|Flensburg         |Nicolaas Korswil    |kwartiermeester|5            |3                 |Repatriated        |return   |Amsterdam|Patriot          |1,150       |return      |1775-10-20    |1776-01-08       |1776-04-06         |1776-07-03  |Batavia        |Texel        |97,925       |118    |quartermaster                |quartermaster|SEA     |non-commissioned officers|98,130|https://iisg.amsterdam/resource/hisco/code/hisco/98130|kwartiermeester|directe contole op groepen manschappen, ronddeling warm eten en ordehandhaving tijdens het schaften                                                              |(dutch: kwartiermeester) has direct control over the crew and the distribution of warm meals and maintaining order during meal time.                               |14         |
|38,570           |1,338,091|Flensburg         |Nicolaas Korswil    |derdewaak      |5            |4                 |Age                |outward  |Amsterdam|Patriot          |1,150       |outward     |1776-12-28    |1777-04-15       |1777-05-04         |1777-08-14  |Texel          |Batavia      |95,337       |183    |third mate (orig.: derdewaak)|third mate   |SEA     |officers                 |4,200 |https://iisg.amsterdam/resource/hisco/code/hisco/04200|derdewaak      |derde stuurman                                                                                                                                                   |(dutch: derdewaak)                                                                                                                                                 |26         |
|38,570           |1,361,216|Flensburg         |Nicolaas Korswil    |matroos        |5            |                  |Amsterdam chamber  |outward  |Amsterdam|Aschat           |1,150       |outward     |1772-10-20    |1773-04-15       |1773-06-14         |1773-09-08  |Texel          |Batavia      |95,198       |123    |sailor                       |sailor       |SEA     |sailors                  |98,140|https://iisg.amsterdam/resource/hisco/code/hisco/98140|matroos        |waak- en roergang; laden en lossen; reinigen, teren en kalfaten van het schip; af- en aanslaan van de zeilen; helpers van de onderofficieren. Ook wel bootsgezel.|(dutch: matroos) watch and helmansman duties; loading and unloading; cleaning, taring and caulking the ship; hoisting and pulling in the sails; assisting the ncos.|11         |
|38,570           |1,361,216|Flensburg         |Nicolaas Korswil    |matroos        |5            |                  |Amsterdam chamber  |outward  |Amsterdam|Huis Te Bijweg   |1,100       |changed_ship|1772-12-25    |1773-04-15       |1773-05-05         |1773-07-07  |Texel          |Batavia      |95,210       |123    |sailor                       |sailor       |SEA     |sailors                  |98,140|https://iisg.amsterdam/resource/hisco/code/hisco/98140|matroos        |waak- en roergang; laden en lossen; reinigen, teren en kalfaten van het schip; af- en aanslaan van de zeilen; helpers van de onderofficieren. Ook wel bootsgezel.|(dutch: matroos) watch and helmansman duties; loading and unloading; cleaning, taring and caulking the ship; hoisting and pulling in the sails; assisting the ncos.|11         |
