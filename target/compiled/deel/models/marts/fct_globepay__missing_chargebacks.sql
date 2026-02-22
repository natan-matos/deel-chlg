-- models/marts/fct_globepay__missing_chargebacks.sql
--
-- Transactions where chargeback data is absent.
-- Answers Q3: "Which transactions are missing chargeback data?"
--
-- NOTE: In the current dataset all transactions are present in both
-- the acceptance and chargeback reports (0 missing). This model
-- will remain empty but will surface any future gaps automatically.

select
    external_ref,
    merchant_ref,
    transaction_at,
    country,
    amount,
    amount_usd,
    state,
    is_accepted
from DEEL.analytics.fct_globepay__transactions
where is_missing_chargeback_data = true
order by transaction_at