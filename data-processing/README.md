# Klein Data Pipeline

## A Note on Scalability

This pipeline, while effective for its initial purpose, is showing signs of obsolescence as our fitness app’s user base grows. Running locally on a PC, it now takes 86 seconds to process—a duration that increases with each new user. This experience taught me a critical lesson: designing scalable databases from day one is essential for a growing company. We’re currently planning a data science rebirth, transitioning to a scalable database solution to meet future demands.

## Overview

This project showcases an end-to-end data pipeline I built to transform raw Firebase data into structured CSVs, ready for loading into a MySQL database for analysis. Designed for a fitness app, the pipeline extracts user authentication and profile data from Firebase, cleans and processes it, and outputs relational CSVs, enabling efficient querying and insights. It highlights my expertise in Python, data engineering, and database preparation.

## Skills Demonstrated

- **Data Engineering**: Created an ETL pipeline to extract data from Firebase, transform it, and prepare it for MySQL.
- **Python Programming**: Developed modular scripts using `pandas` for data processing and `firebase-admin` for API integration.
- **Data Cleaning**: Filtered test accounts, flagged emails, and handled missing or invalid data with detailed auditing.
- **Automation**: Built `run_pipeline.py` to orchestrate the entire process with a single command.
- **Error Handling**: Implemented robust debugging and logging to ensure reliability.
- **Database Design**: Structured data into a relational model keyed on `user_id`, optimized for MySQL.

## Project Structure

The pipeline operates in three main stages:

1. **Fetch Data**:
   - [`fetch_auth_data.py`](https://github.com/HunterKleinschmidt/analytics-portfolio/blob/main/data-processing/scripts/fetch_auth_data.py): Retrieves user authentication data (e.g., IDs, emails, timestamps) from Firebase Auth, saved as `data/raw/auth/YYYY-MM-DD.csv`.
   - [`fetch_firebase_data.py`](https://github.com/HunterKleinschmidt/analytics-portfolio/blob/main/data-processing/scripts/fetch_firebase_data.py): Pulls user profiles and transactions from Firebase Realtime Database, saved as `data/raw/json/YYYY-MM-DD.json`.

2. **Process Data**:
   - [`process_raw_to_csv.py`](https://github.com/HunterKleinschmidt/analytics-portfolio/blob/main/data-processing/scripts/process_raw_to_csv.py): Cleans and transforms raw data into four CSVs:
     - `auth_data.csv`: Authentication details.
     - `subscriptions.csv`: Transaction history.
     - `user_profiles.csv`: User profile data.
     - `my_gym.csv`: Translated gym preferences.
   - Includes filtering (e.g., test accounts, flagged emails like "uat"), timestamp conversion, and error handling.
   - Generates `data_cleaning_audit.csv` to log cleaning decisions and data quality checks.

3. **Load Data**:
   - Currently manual: CSVs are uploaded to MySQL with predefined schemas.
   - Future plan: Automate with `mysql-connector-python`.

## Key Features

- **Modularity**: Scripts are separated for maintainability.
- **Automation**: [`run_pipeline.py`](https://github.com/HunterKleinschmidt/analytics-portfolio/blob/main/data-processing/run_pipeline.py) executes the full pipeline seamlessly.
- **Data Integrity**: Robust filtering and an audit log ensure clean, reliable outputs.
- **Scalability**: Handles large JSON files and API limits with batching (though local execution limits long-term growth).

## Technologies Used

- **Python**: Core scripting language.
- **Libraries**:
  - `pandas`: Data manipulation and CSV creation.
  - `firebase-admin`: Firebase API integration.
- **Firebase**: Source of raw data (Auth and Realtime Database).
- **MySQL**: Target relational database (manual upload for now).
- **Git/GitHub**: Version control and hosting.

## How to View the Code

Scripts are hosted in the [`data-processing`](https://github.com/HunterKleinschmidt/analytics-portfolio/tree/main/data-processing) directory:
- [`fetch_auth_data.py`](https://github.com/HunterKleinschmidt/analytics-portfolio/blob/main/data-processing/scripts/fetch_auth_data.py): Fetches authentication data.
- [`fetch_firebase_data.py`](https://github.com/HunterKleinschmidt/analytics-portfolio/blob/main/data-processing/scripts/fetch_firebase_data.py): Fetches profile and transaction data.
- [`process_raw_to_csv.py`](https://github.com/HunterKleinschmidt/analytics-portfolio/blob/main/data-processing/scripts/process_raw_to_csv.py): Cleans and transforms data, generates audit log.
- [`run_pipeline.py`](https://github.com/HunterKleinschmidt/analytics-portfolio/blob/main/data-processing/run_pipeline.py): Automates the pipeline.

## How It Works

1. **Data Extraction**: Authentication and profile/transaction data are fetched from Firebase and saved as raw files.
2. **Data Transformation**: Raw data is cleaned, normalized, and split into relational CSVs, with an audit log tracking all actions.
3. **Data Loading**: CSVs are manually uploaded to MySQL for relational querying.

## Challenges and Solutions

- **Large JSON Files**: Managed with `pandas` and debug logging for efficient processing.
- **Data Quality**: Built `is_flagged` function and audit log to filter invalid data and document cleaning steps.

## Future Improvements

- Automate MySQL uploads with `mysql-connector-python`.
- Add pre-upload data validation (e.g., schema checks).
- Transition to a scalable, cloud-based database solution.

## Contact

Reach out via my [website](https://hunterkleinschmidt.github.io/) or email at [hunter@kleinstrength.com](mailto:hunter@kleinstrength.com) to discuss this project further.
