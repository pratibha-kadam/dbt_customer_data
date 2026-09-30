-- A completed order must have a payment amount.
-- Any row returned here is a failure.
select
    order_id,
    order_status,
    total_paid_rupees
from {{ ref('fct_orders') }}
where order_status = 'completed'
  and total_paid_rupees is null