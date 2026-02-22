# Deel Data Engineering Challenge
> dbt + Snowflake · Globepay Acceptance and Chargeback Reports

---

## Overview

This project transforms raw Globepay payment data into a clean, analytics-ready layer using **dbt** with **Snowflake as the data warehouse**. It answers three business questions:

1. **What is the acceptance rate over time?**
2. **Which countries had declined transaction volumes exceeding $25M?**
3. **Which transactions are missing chargeback data?**

---

## Tech Stack

- **Transformation:** dbt
- **Data Warehouse:** Snowflake
- **Raw data:** Snowflake `RAW` schema (`GLOBEPAY_ACCEPTANCE`, `GLOBEPAY_CHARGEBACK`)
- **Serving layer:** Snowflake `STAGING` and `MARTS` schemas

---

## Project Structure


deel/
├── models/
│   ├── staging/          # Typed, renamed views on top of raw sources
│   │   ├── sources.yml
│   │   ├── stg_globepay__acceptance.sql
│   │   └── stg_globepay__chargeback.sql
│   └── marts/            # Business-logic models for analytics consumption
│       ├── fct_globepay__transactions.sql
│       ├── fct_globepay__missing_chargebacks.sql
│       ├── agg_globepay__acceptance_by_month.sql
│       └── agg_globepay__declined_by_country.sql
├── macros/
│   └── generate_schema_name.sql
└── dbt_project.yml


The project follows a **staging -> marts** two-layer architecture. Staging models live in the `STAGING` schema as views; mart models are materialized as tables in `MARTS`.

---

## Data Modeling Decisions

### Staging layer - keep it thin

Staging models are 1-to-1 with source tables. Their only job is to type-cast, rename columns to a consistent convention, and derive simple boolean flags (`is_accepted`, `has_chargeback`). No business logic lives here, which makes them easy to trust and easy to reuse.

Currency normalisation is also handled at this layer: exchange rates arrive as a JSON string, so Snowflake's `TRY_PARSE_JSON()` is used to extract rates and convert all amounts to USD inline. This keeps the mart models clean and free of raw JSON handling.

### Fact table as the single source of truth

`fct_globepay__transactions` is the grain-level fact table, one row per transaction, joining acceptance and chargeback data on `external_ref` via a **left join**. The left join is intentional: it preserves all transactions regardless of chargeback coverage, and a derived `is_missing_chargeback_data` flag cleanly surfaces gaps without filtering records out.

All downstream models build on top of the fact table rather than re-joining staging models directly. This avoids duplicating join logic and ensures consistency across the mart layer.

### Aggregates for specific business questions

`agg_*` models are pre-aggregated summaries scoped to specific analytical questions. Keeping them separate from the fact table makes the intent of each model explicit, and keeps BI queries simple. Consumers can query a pre-rolled table rather than writing their own aggregations over millions of rows.

### Schema naming

A custom `generate_schema_name` macro overrides dbt's default behaviour of prefixing schemas with the target schema name (e.g. `PUBLIC_staging`). Models land directly in `STAGING` and `MARTS`, which is cleaner for a multi-schema Snowflake setup.

---

## Models Reference

| Model | Type | Description |
|---|---|---|
| `stg_globepay__acceptance` | View | Cleaned acceptance report, one row per transaction attempt |
| `stg_globepay__chargeback` | View | Cleaned chargeback report with `has_chargeback` boolean |
| `fct_globepay__transactions` | Table | Grain-level fact table joining acceptance + chargeback |
| `fct_globepay__missing_chargebacks` | Table | Transactions with no matching chargeback record |
| `agg_globepay__acceptance_by_month` | Table | Monthly acceptance rate and volume summary |
| `agg_globepay__declined_by_country` | Table | Declined volumes by country, flagged if > $25M |

---

## Tests

The project includes two singular tests in the `tests/` folder:

**`assert_no_missing_chargeback.sql`** - Asserts that every transaction in the acceptance report has a corresponding row in the chargeback report. Queries `fct_globepay__transactions` and passes when `is_missing_chargeback_data` returns 0 rows. In the current dataset all transactions have chargeback coverage, but this test will automatically catch future gaps.

**`assert_acceptance_rate_in_range.sql`** - Data quality guard that fires if any month has an acceptance rate below 50% or above 100%, which would indicate a possible data load issue rather than a real business trend.

---

## Tests

Two singular tests guard data quality:

| Test | Model | Description |
|---|---|---|
| `assert_no_missing_chargeback` | `fct_globepay__transactions` | Fails if any transaction has no matching chargeback record (`is_missing_chargeback_data = true`) |
| `assert_acceptance_rate_in_range` | `agg_globepay__acceptance_by_month` | Fails if any month has an acceptance rate outside the 50-100% range, which would indicate a data load issue |

Both tests follow dbt's singular test convention: they pass when the query returns 0 rows.

---

## How to Run

cd deel
dbt debug       # verify connection
dbt run         # build all models
dbt test        # run data quality tests
