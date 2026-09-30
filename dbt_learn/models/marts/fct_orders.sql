with orders as (
    select * from {{ ref('stg_orders') }}
),

payments as (
    select * from {{ ref('int_order_payments') }}
)

select
    o.order_id,
    o.customer_id,
    o.order_date,
    o.order_status,
    coalesce(p.payment_count, 0)   as payment_count,
    p.total_paid_rupees,
    p.payment_methods,
    p.order_id is not null         as has_payment
from orders o
left join payments p
    on o.order_id = p.order_id