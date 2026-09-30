select
    order_id,
    count(*)                                       as payment_count,
    sum(amount_rupees)                             as total_paid_rupees,
    string_agg(distinct payment_method, ', ')      as payment_methods
from {{ ref('stg_payments') }}
group by order_id