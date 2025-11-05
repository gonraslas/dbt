{{ config(
    materialized='table',
    cluster_by=['region_id']
) }}

select *
from {{ ref('region') }}
