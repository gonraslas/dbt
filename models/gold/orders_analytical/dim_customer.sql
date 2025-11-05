{{ config(
    materialized='table',
    cluster_by=['customer_id']
) }}

select *
from {{ ref('customer') }}
