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
    li.order_id,
    li.line_number,
    o.customer_id,
    li.part_id,
    li.supplier_id,
    li.quantity,
    li.extended_price,
    li.discount,
    li.tax,
    o.order_status,
    o.order_date,
    li.ship_date,
    li.commit_date,
    li.receipt_date,
    o.ship_priority,
    o.order_priority,
    o.clerk,
    li.return_flag,
    li.line_status,
    li.ship_instructions,
    li.ship_mode,
    o.total_price
from lineitem li
join orders o
    on li.order_id = o.order_id
