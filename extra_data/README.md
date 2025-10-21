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

Data is in: [voc_arrival_places.csv](./voc_arrival_places.csv)

`INSERT`-statement is here: [110_voc_extra_arrival_place_locations.sql](../sql-initdb/110_voc_extra_arrival_place_locations.sql)