/*
*********************************************************************
http://www.mysqltutorial.org
*********************************************************************
Name: E-Commerce Database

*/


/* 1.Create new schema as ecommerce */

create database ecommerce;    -- create the database
use ecommerce;


/* 2.Import .csv file users_data into MySQL
(right click on ecommerce schema -> Table Data import Wizard -> Give path of the file -> Next -> choose options : 
Create a new table , select delete if exist -> next -> next)*/

select count(*) from users_data;  -- count the no. of data imported


/* 3.Run SQL command to see the structure of table*/

select * from users_data;
desc users_data;               -- Structure of table


/* 4.Run SQL command to select first 100 rows of the database*/

select * from users_data limit 0,100;           


/* 5.How many distinct values exist in table for field country and language*/

select count(distinct country) country , count(distinct language) language from users_data;


/* 6.Check whether male users are having maximum followers or female users.*/

select gender from users_data group by gender;
select gender,sum(socialNbFollowers) from users_data group by gender;


/* 7.Calculate the total users those
 a.Uses Profile Picture in their Profile */
 
 select * from users_data;
 select count(hasprofilepicture) as Uses_Profile_picture from users_data where hasprofilepicture="True";
 
 /* b.Uses Application for Ecommerce platform*/
 
 select count(hasAnyApp) as Ecommerce_Platform from users_data where hasAnyApp="True";
 
 /* c.Uses Android app*/
 
 select count(hasAndroidApp) as Android_app from users_data where hasAndroidApp="True";
 
 /* d.Uses ios app*/
 
 select count(hasIosApp) as Ios_app from users_data where hasIosApp="True";
 
 
 /* 8.Calculate the total number of buyers for each country and sort the result in descending order of total number of buyers. 
 (Hint: consider only those users having at least 1 product bought.)*/
 
  select * from users_data;
  select country,count(productsBought) as Total_No_buyers from users_data where productsBought > 0 group by country order by Total_No_buyers  desc;
  
 
 /* 9.Calculate the total number of sellers for each country and sort the result in ascending order of total number of sellers
 (Hint: consider only those users having at least 1 product sold.)*/
 
 select country,count(productssold) sellers from users_data where productssold > 0 group by country order by sellers asc;
 
 
 /* 10.Display name of top 10 countries having maximum products pass rate.*/
 
 
 select * from users_data;
 select country,max(productspassrate) as Product from users_data where productspassrate > 0
 group by country order by product desc limit 10;

 
 /* 11.Calculate the number of users on an ecommerce platform for different language choices.*/
 
 select language,count(language) Diff_Language_choices from users_data group by language; 
 
 
 
 /* 12.Check the choice of female users about putting the product in a wishlist or to like socially 
 on an ecommerce platform. (Hint: use UNION to answer this question.)*/
 
  select * from users_data;
  select 'Products' ,'Total' 
  union select 'Products Social Liked', sum(socialProductsLiked) from users_data where gender = 'F'
  union select 'Products wishlisted', count(productsWished) wishlisted from users_data where gender = 'F';
  
  
  /* 13.Check the choice of male users about being seller or buyer. (Hint: use UNION to solve this question.)*/
  
  select 'Products', 'Total' 
  union select 'Seller', count(productssold) from users_data where gender = 'M' and productssold > 0 union
  select 'Byers' ,count(productsBought)  from users_data where gender = 'M' and productsBought > 0;
  
  /* 14.Which country is having maximum number of buyers?*/


select * from users_data;
select country, count(productsBought) Buyers from users_data where productsBought > 0 
group by country order by Buyers desc limit 1;

/* 15.List the name of 10 countries having zero number of sellers.*/

select country ,min(productssold) sellers from users_data 
group by country order by sellers desc limit 10;

 
 /* 16.Display record of top 110 users who have used ecommerce platform recently.*/
 
 select * from users_data;
 select identifierHash,dayssincelastlogin from users_data order by dayssincelastlogin limit 0,110;
 
 
 /*17.Calculate the number of female users those who have not logged in since last 100 days.*/
 
 select  count(identifierHash) as female_users from users_data where gender="F" and dayssincelastlogin >=100;


/* 18.Display the number of female users of each country at ecommerce platform.*/

select * from users_data;
select country,count(identifierHash) as female_users from users_data where gender="F" group by country;


/* 19.Display the number of male users of each country at ecommerce platform.*/

select country,gender,count(identifierHash) as male_users from users_data where gender="M" group by country;

/* 20.Calculate the average number of products sold and bought on ecommerce platform by male users for each country.*/

select * from users_data;
select country,avg(productssold) as productssold, avg(productsBought) as productsBought
from users_data where gender = "M" group by country;


 /*
*********************************************************************
http://www.mysqltutorial.org
*********************************************************************
Completed
*/
 
 
 