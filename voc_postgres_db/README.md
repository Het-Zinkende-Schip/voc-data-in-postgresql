# PostgreSQL Database with VOC Data

Docker Compose setup to create a **PostgreSQL database** preloaded with the **VOC data** from the VOC csv's*, maybe as a start for creating the **linked data**?

Data from [dataset/csv/enriched](dataset/csv/enriched) is imported automatically via SQL scripts in the [sql-initdb](sql-initdb) directory.

***Citation**
Petram, L., Koolen, M., Wevers, M., van Koert, R., & van Lottum, J. (2024). The Dutch East India Company's Eighteenth-Century Workforce: an Enriched Data Collection (0.1.0) [Data set]. Zenodo. https://doi.org/10.5281/zenodo.10599528

# Starting the container

From the project root directory:

```bash
cd voc_postgres_db
```

Build and start the PostgreSQL container:

```bash
docker compose up -d --build
```

## Database Connection

Connect with your preferred database client using the following credentials:

| Parameter    | Value       |
| ------------ | ----------- |
| **Host**     | `localhost` |
| **Port**     | `6543`      |
| **Database** | `voc`       |
| **Username** | `postgres`  |
| **Password** | `postgres`  |
