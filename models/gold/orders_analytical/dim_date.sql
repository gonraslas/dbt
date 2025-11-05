{{ config(
    materialized='table',
    cluster_by=['calendar_date']
) }}

select *
from {{ ref('calendar') }}
