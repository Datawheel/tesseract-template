# How to setup new Tesseract service on Google Cloud Run

1. Create new GCP project
2. Create Clickhouse database(s)
   1. Ingest data
   2. Create read-only user for Tesseract
3. Setup GCP
   1. Enable Necessary APIs/Service
   2. Create service account for CI/CD
   3. Create artifact registry repo
4. Setup repo secrets and environments
   1. Download service account key (for Github Acitons) and store as (base64-encoded string) secret in repo
   2. Create dev and prod environments
   3. Store DB access URL(s) as environment secret(s)
   4. Store GCP project ID as repo secret
   5. Configure pipeline workflow env vars (like service name, image name etc)
5. Write Tesseract Schema
   1. Write schema file
   2. Build Tesseract Image locally and run with Clickhouse DB url to test schema
   3. Deploy using pipelines
6. Setup Tesseract UI (optional)
   1. Manually trigger Tesseract UI Deploy pipeline with Tesseract URL