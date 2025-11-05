with dates as (
    select 
        min(order_date) as start_date,
        max(order_date) as end_date
    from {{ ref('stg_orders') }}
),
calendar as (
    select
        dateadd(day, seq4(), start_date) as calendar_date
    from dates,
    table(generator(rowcount => datediff(day, start_date, end_date) + 1))
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
order by calendar_date