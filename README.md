# PostgreSQL Database with VOC Data

Docker Compose setup to create a **PostgreSQL database** with **VOC data**

## Attribution

This project makes use of data from:

Petram, L., Koolen, M., Wevers, M., van Koert, R., & van Lottum, J. (2024).
*The Dutch East India Company's Eighteenth-Century Workforce: an Enriched Data Collection (0.1.0)* [Data set].
Zenodo. https://doi.org/10.5281/zenodo.10599528

Licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).

## The data

I copied the enriched csv files from https://doi.org/10.5281/zenodo.10599528. 

Data from [dataset/csv/enriched](dataset/csv/enriched) is imported automatically via SQL scripts in the [sql-initdb](sql-initdb) directory.

Some adjustememts have been made to the data: [script in sql-initdb](./sql-initdb/)

Example queries can be found here: [queries](./queries/)

## Starting the container

From the project root directory, you can build and start the PostgreSQL container:

```bash
docker compose up -d --build
```

## Database Connection

Now you can connect tot the database with your preferred database client using the following credentials:

| Parameter    | Value       |
| ------------ | ----------- |
| **Host**     | `localhost` |
| **Port**     | `6543`      |
| **Database** | `voc`       |
| **Username** | `postgres`  |
| **Password** | `postgres`  |
