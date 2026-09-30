with source as (
    select * from {{ source('shop_raw', 'raw_customers') }}
),

cleaned as (
    select
        customer_id,
        first_name,
        last_name,
        concat(first_name, ' ', last_name) as full_name,
        lower(email)                       as email,
        initcap(city)                      as city,
        cast(signup_date as date)          as signup_date
    from source
)

select * from cleaned