select 
  * 
from 
  pizza_sales 
  /**** total revenues*****/
select 
  SUM(total_price) as TotalRevenue 
from 
  pizza_sales 
  /**** Average revenues*****/
select 
  sum(total_price)/ count(
    distinct(order_id)
  ) as AverageRevenue 
from 
  pizza_sales 
  /**** total pizza sold *****/
select 
  sum(quantity) as TotalPizzaSold 
from 
  pizza_sales 
  /**** total Orders placed *****/
select 
  count(
    distinct(order_id)
  ) as TotalOrders 
from 
  pizza_sales 
  /**** total pizza sold by category *****/
select 
  pizza_category, 
  sum(quantity) as TotalPizzaSold 
from 
  pizza_sales 
group by 
  pizza_category 
order by 
  sum(quantity) desc 
  /**** total pizza sold by Pizza Size *****/
select 
  pizza_size, 
  sum(quantity) as TotalPizzaSold 
from 
  pizza_sales 
group by 
  pizza_size 
order by 
  sum(quantity) desc 
  /**** Average pizza sold per order *****/
select 
  CAST(
    sum(quantity) / count(
      distinct(order_id)
    ) as decimal(10, 2)
  ) as AveragePizzaSoldPerOrder 
from 
  pizza_sales 
  /**** daily trend for orders  *****/
select 
  DateName(DW, order_date) as Order_Date, 
  count(
    distinct(order_id)
  ) as CountOrdersPerDay 
from 
  pizza_sales 
group by 
  DateName(DW, order_date) 
order by 
  count(
    distinct(order_id)
  ) desc 
  /**** Monthly trend for orders  *****/
select 
  DateName(Month, order_date) as MonthNo, 
  count(
    distinct(order_id)
  ) as CountOrdersPerMonth 
from 
  pizza_sales 
group by 
  DateName(Month, order_date) 
order by 
  CountOrdersPerMonth desc 
  /**** percentage total revenue pizza sold by category *****/
select 
  pizza_category, 
  sum(total_price) as totalPriceperCategory, 
  cast(
    sum(total_price)* 100 /(
      select 
        sum(total_price) 
      from 
        pizza_sales 
      where 
        MONTH(order_date)= 1
    ) as decimal(10, 2)
  ) as PercentageRevenuePerCategory 
from 
  pizza_sales 
where 
  MONTH(order_date)= 1 
group by 
  pizza_category --order by PercentageRevenuePerCategory desc
  
  /**** percentage total revenue pizza sold by Pizza size and quarter *****/
select 
  pizza_size, 
  cast(
    sum(total_price) as decimal(10, 2)
  ) totalPriceperPSize, 
  cast(
    sum(total_price)* 100 /(
      select 
        sum(total_price) 
      from 
        pizza_sales 
      where 
        DATENAME(quarter, order_date)= 1
    ) as decimal(10, 2)
  ) as PsRevPerPsize 
from 
  pizza_sales 
where 
  DATENAME(quarter, order_date)= 1 
group by 
  pizza_size 
  /**** top 5 pizzas by total revenue   *****/
select 
  top 5 pizza_name, 
  SUM(total_price) as total_revenue 
from 
  pizza_sales 
group by 
  pizza_name 
order by 
  total_revenue desc;
/**** top 5 pizzas by  total quantity and total orders  *****/
select 
  top 5 pizza_name, 
  SUM(quantity) as total_quantity 
from 
  pizza_sales 
group by 
  pizza_name 
order by 
  total_quantity desc;
/**** top 5 pizzas by  total orders  *****/
select 
  top 5 pizza_name, 
  count(
    distinct(order_id)
  ) as Total_ordersNo 
from 
  pizza_sales 
group by 
  pizza_name 
order by 
  Total_ordersNo desc;
/**** bottom 5 pizzas by total revenue   *****/
select 
  top 5 pizza_name, 
  SUM(total_price) as total_revenue 
from 
  pizza_sales 
group by 
  pizza_name 
order by 
  total_revenue asc;
/**** bottom 5 pizzas by  total quantity and total orders  *****/
select 
  top 5 pizza_name, 
  SUM(quantity) as total_quantity 
from 
  pizza_sales 
group by 
  pizza_name 
order by 
  total_quantity asc;
/**** bottom 5 pizzas by  total orders  *****/
select 
  top 5 pizza_name, 
  count(
    distinct(order_id)
  ) as Total_ordersNo 
from 
  pizza_sales 
group by 
  pizza_name 
order by 
  Total_ordersNo asc;
