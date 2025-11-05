{{ config(
    materialized='table',
    cluster_by=['part_id']
) }}

select *
from {{ ref('part') }}
