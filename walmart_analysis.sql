------- create a database
create database wallmart
------  Use the database
use wallmart
-------- To view the table content
select * from Walmart;
--------------------------------------------------------------------------------------------------------------------------------
                                           --  DATA WRANGLING
--------------------------------------------------------------------------------------------------------------------------------

------------ create a new column named time_of_day by using time to fix morning,afternoon,evening                                           
select Time from Walmart;
select 
     Time,
	 case 
        when Time between '00:00:00' and '12:00:00' then 'morning'
        when Time between '12:01:00' and '16:00:00' then 'afternoon'
        else "evening"
     end 
      as time_of_day 
from walmart;

---------- Alter table
alter table Walmart add column time_of_day varchar(20);
---------- Update a table
update Walmart 
set time_of_day = (
 case 
        when Time between '00:00:00' and '12:00:00' then 'morning'
        when Time between '12:01:00' and '16:00:00' then 'afternoon'
        else "evening" 
        end
);
-------- error faced safe update
SET SQL_SAFE_UPDATES = 0;

UPDATE Walmart 
SET time_of_day = (
    CASE 
        WHEN Time BETWEEN '00:00:00' AND '12:00:00' THEN 'morning'
        WHEN Time BETWEEN '12:01:00' AND '16:00:00' THEN 'afternoon'
        ELSE 'evening' 
    END
);

SET SQL_SAFE_UPDATES = 1; -- optional: turn it back on

------------------------------- Day name changing day like monday to sunday weekdays according to the day specified in date field
select 
     date,dayname(Date)
     from Walmart  as day_name;
------------- Alter
alter table
    Walmart add column 
    dat_name varchar(10);
------------- Update
update Walmart 
    set dat_name = dayname(Date) ;

-------------------------------------------------------------------------------------- Month name
select 
    date,monthname(date) 
    from Walmart;

alter table
     Walmart 
     add column 
     month_name varchar(20);

update Walmart 
     set 
     month_name= monthname(date);







------------------------------ GENERIC QUESTION  ------------------------------------------------




------------------------------------------------------------------- How many unique cities
select 
     Distinct(city)
     from Walmart;


------------------------------------------------- How many unique branches in city
select 
     distinct(city),
     branch
     from Walmart;



-------------------------------  PRODUCT  --------------------------------------------------------



-------------------- How many unique product lines does the data have?-------------

SELECT 
     distinct(`Product line`)
     FROM `walmart`;

-------------------- What is the most common payment method? -------------------------------------


select 
     payment,
     count(Payment) as cnt from `Walmart` 
     group by payment 
     order by cnt 
     desc; 

--------------------- What is the most selling product line?---------------------------------------


select 
    `product line`,
    count(`Product line`) as cnt from `Walmart`
    group by `product line` 
    order by cnt 
    desc; 

--------------------- What is the total revenue by month? --------------------------------


select
     month_name,
     sum(`Total`) as total_revenue 
     from Walmart 
     group by month_name 
     order by total_revenue ;

--------------------- What month had the largest COGS? ---------------------


select
     month_name,
     sum(cogs) as cnt
     from Walmart 
     group by month_name 
     order by cnt desc;

--------------------- What product line had the largest revenue?


select
    `product line`,
    sum(Total) as total 
    from Walmart 
    group by `product line` 
    order by total 
    desc;

---------------------- What is the city with the largest revenue?

select 
    city,
    sum(total) as largest_revenue from Walmart 
    group by city
    order by largest_revenue desc;

----------------------- What product line had the largest VAT? 


select 
    `product line`,
    avg(`Tax 5%`) as largest_VAT from Walmart 
    group by `product line`
    order by largest_VAT desc;


------------------------ Which branch sold more products than average product sold? 
 
select
   `branch`,
   sum(`quantity`) as qty from Walmart 
   group by `branch` 
   having sum(`quantity`) > (select avg(`quantity`) from Walmart);
 
 ----------------------- What is the most common product line by gender?
 
 
 select
     gender,`product line`,
     count(`product line`) as cnt from Walmart
     group by gender,`product line`
     order by cnt desc ;
 ----------------------- What is the average rating of each product line?


select
    `product line`,
    round(avg(`rating`),2) as avg_rating from Walmart
    group by `product line` 
    order by avg_rating desc;





--------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                 ---- SALES ----
--------------------------------------------------------------------------------------------------------------------------------------------------------------------


--------------------------- Number of sales made in each time of the day per weekday---
select 
   time_of_day ,
   count(`time_of_day`) as sales from Walmart
   where dat_name= "monday" 
   group by(`time_of_day`);      

---------------------------  Which of the customer types brings the most revenue?

select 
   `customer type`,
   sum(Total) as total from Walmart 
   group by `customer type` 
   order by total;

---------------------------  Which city has the largest tax percent/ VAT (Value Added Tax)?


select 
   city, 
   avg(`Tax 5%`) as avg from Walmart
   group by city 
   order by avg;

---------------------------- Which customer type pays the most in VAT?
select
   `customer type`,
   avg(`tax 5%`) as max from Walmart 
   group by `customer type` 
   order by max desc;

--------------------------------------------------------------------------  END    --------------------------------------------------------------------------------
                                                        
