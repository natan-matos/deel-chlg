-- macros/cents_to_dollars.sql
--
-- Utility macro: convert a minor-unit (cents) amount to major-unit (dollars).
-- Globepay API docs note amounts are in minor units, but the CSV data
-- appears already in major units – use this macro if the source changes.

{% macro cents_to_dollars(column_name) %}
    ({{ column_name }}::float / 100.0)
{% endmacro %}
