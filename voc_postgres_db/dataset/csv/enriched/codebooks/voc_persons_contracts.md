| Column name | Description |
| --- | --- |
| vocop_id | record id; each record describes a muster record of a VOC employee that was recorded in the pay ledger of a particular voyage of a VOC ship  |
| full_name | full name of employee  |
| place_of_origin | place of origin of employee  |
| place_id | id of place of origin, refers to file VOC_places.csv  |
| disambiguated_person | 1 if record belongs to a disambiguated person, else 0  |
| person_cluster_id | id for cluster of records belonging to a disambiguated person  |
| person_cluster_row | ordinal rank of the voyage in a disambiguated person's career (`3' would e.g. indicate the third contract within a cluster)  |
| rank | rank designation in original data set, with some alterations by Huygens (correction of wrong transcription; distinction ranks that changed after 1783)  |
| rank_corrected | 1 if the rank stated in the original data set has been altered (correction of wrong transcription; distinction ranks that changed after 1783), else 0  |
| rank_id | unique id of rank, refers to file voc_ranks.csv  |
| debt_letter | 1 if employee signed a debt letter, else 0  |
| month_letter | 1 if employee signed a month letter, else 0  |
| date_begin_contract | start date of employment contract  |
| date_end_contract | end date of contract; incomplete dates in original data set were supplemented with arrival dates of return ships from DAS and/or completed with `-01' or `-01-01' to facilitate calculations with the dates  |
| contract_length | length of contract (in days)  |
| reason_end_contract | reason why the employment contract ended  |
| could_muster_again | 1 if employee could muster again on a subsequent voyage, given the reason why the current employment contract ended, else 0  |
| location_end_contract | location where the employment contract ended; when an employee returned to the Netherlands and signed off, the name of the return ship is given  |
| outward_voyage_id | DAS voyage id of outward voyage, refers to file voc_voyages.csv  |
| changed_ship_at_cape | 1 if employee changed ship at the Cape of Good Hope, else 0  |
| changed_ship_at_cape_voyage_id | DAS voyage id of outward voyage that employee joined from the Cape of Good Hope, refers to file voc_voyages.csv  |
| return_voyage_id | DAS voyage id of return voyage, refers to file voc_voyages.csv  |
| remark | general remark on record (in Dutch)  |
| source_id | id of source record from which muster record originates, refers to file voc_sources.csv  |
| source_reference | reference to finding place of record in the paper VOC archives (inventory number and page number)  |
| uid | unique record id in database of Dutch National Archives  |
| scan_permalink | permalink to scan of physical muster record  |