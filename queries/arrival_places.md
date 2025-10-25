

```sql
SELECT DISTINCT vv.arrival_place  FROM voc.voc_voyages vv ;
```

Zie [verder](../extra_data/README.md)

```
PREFIX hzs: <http://data.hetzinkendeschip.nl#>

SELECT DISTINCT ?place
WHERE {
  {
    ?voyage hzs:departurePlace ?place .
  }
  UNION
  {
    ?voyage hzs:arrivalPlace ?place .
  }
}
ORDER BY ?place
```