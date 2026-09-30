with customers as (
    select * from {{ ref('stg_customers') }}
),

customer_orders as (
    select
        customer_id,
        count(*)                                            as number_of_orders,
        min(order_date)                                     as first_order_date,
        max(order_date)                                     as most_recent_order_date,
        sum(case when order_status != 'returned'
                 then total_paid_rupees end)                as lifetime_value_rupees
    from {{ ref('fct_orders') }}
    group by customer_id
)

select
    c.customer_id,
    c.full_name,
    c.email,
    c.city,
    c.signup_date,
    coalesce(co.number_of_orders, 0) as number_of_orders,
    co.first_order_date,
    co.most_recent_order_date,
    co.lifetime_value_rupees
from customers c
left join customer_orders co
    on c.customer_id = co.customer_id
    