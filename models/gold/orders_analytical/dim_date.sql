{{ config(
    materialized='table',
    cluster_by=['date']
) }}

select *
from {{ ref('calendar') }}
