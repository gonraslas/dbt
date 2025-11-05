{{ config(
    materialized='table',
    cluster_by=['nation_id']
) }}

select *
from {{ ref('nation') }}
