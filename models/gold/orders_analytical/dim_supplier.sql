{{ config(
    materialized='table',
    cluster_by=['supplier_id']
) }}

select *
from {{ ref('supplier') }}
