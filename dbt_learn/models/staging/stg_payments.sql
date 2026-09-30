with source as (
    select * from {{ source('shop_raw', 'raw_payments') }}
),

cleaned as (
    select
        payment_id,
        order_id,
        payment_method,
        amount_paise,
        round(cast(amount_paise as numeric) / 100, 2) as amount_rupees,
        cast(created_at as timestamp)                 as created_at
    from source
)

select * from cleaned