{{ config(
    materialized='table',
    cluster_by=['order_date', 'customer_id']
) }}

with orders as (
    select *
    from {{ ref('orders') }}
),

lineitem as (
    select *
    from {{ ref('lineitem') }}
)
select
    o.order_id,
    o.customer_id,
    o.order_status,
    o.total_price,
    o.order_date,
    o.order_priority,
    o.clerk_name,
    o.ship_priority,
    o.comment as order_commment,
    li.part_id,
    li.supplier_id,
    li.line_number,
    li.quantity,
    li.extended_price,
    li.discount,
    li.tax,
    li.return_flag,
    li.line_status,
    li.ship_date,
    li.commit_date,
    li.receipt_date,
    li.ship_instructions,
    li.ship_mode,
    li.comment as lin_comment
from lineitem li
join orders o
    on li.order_id = o.order_id
