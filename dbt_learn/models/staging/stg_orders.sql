with source as (
    select * from {{ source('shop_raw', 'raw_orders') }}
),

cleaned as (
    select
        order_id,
        customer_id,
        cast(order_date as date) as order_date,
        lower(trim(status))      as order_status
    from source
)

select * from cleaned