{{ config(
    materialized='table',
    cluster_by=['calendar_date']
) }}

with dates as (
    select 
        min(order_date) as start_date,
        max(order_date) as end_date
    from {{ ref('orders') }}  -- Silver orders con nombres amigables
),
calendar as (
    -- Generamos suficientes días, luego filtramos al rango real
    select
        dateadd(day, seq4(), start_date) as calendar_date
    from dates,
    table(generator(rowcount => 10000))  -- ajustar si el rango de fechas es mayor
)
select
    calendar_date,
    year(calendar_date) as year,
    month(calendar_date) as month,
    day(calendar_date) as day,
    dayofweek(calendar_date) as day_of_week,
    week(calendar_date) as week_of_year,
    quarter(calendar_date) as quarter,
    case when dayofweek(calendar_date) in (1,7) then true else false end as is_weekend
from calendar
where calendar_date <= (select end_date from dates)
order by calendar_date
