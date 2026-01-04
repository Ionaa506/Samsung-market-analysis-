         #region  with the highest revenue so far
select 
sum(revenue),region
from samsung_sales_record
group by Region;
   

               #Quaterly revenue growth Analysis 
   with Quaterly_Aggregates as (
   select 
   quarter_1, 
   region,
   year_1 *10 + replace (quarter_1,"q"," ")  as sortable_period,
   sum(revenue) as current_quarter_revenue
   from Samsung_sales_record 
   group by quarter_1,region,year_1
 
   ),
   previous_quarter_revenue as(
   select year_1,
   quarter_1,region,
    sum(revenue) as current_quarter_revenue,
    lag( sum(revenue),1,0) over (partition by region  order by year_1)as previous_quarter_revenue
    from samsung_sales_record 
    group by year_1,Quarter_1,Region
   )
    select 
    quarter_1,
    current_quarter_revenue,
    previous_quarter_revenue,
    case when
    previous_quarter_revenue=0 then "no previous data"
    else (current_quarter_revenue-previous_quarter_revenue)/(previous_quarter_revenue)*100
    end as revenue_quarter_growth_rate
    from 
    previous_quarter_revenue 
    order by quarter_1;
    
    
                                     #correlation of 5G prefrence 
   
     select
    year_1,
    market_share_rate,
	preference_for_5g_rate,
    avg(market_share_rate),avg(Preference_for_5G_rate)
     from samsung_sales_record 
     group by year_1,
    market_share_rate,
	preference_for_5g_rate
    having  market_share_rate>avg(market_share_rate)
     and  preference_for_5g_rate>avg(preference_for_5g_rate)
	order by year_1;
     
     
     
  #end for now 