----------------------------------------------------------------
--           WORKSHOP:    BASIC SQL SYNTAX - 15 Min.          --
----------------------------------------------------------------

				--SELECT <-- FOCUS AREA
				--FROM  <-- FOCUS AREA
				--WHERE
				--GROUP BY 
				--ORDER BY <-- FOCUS AREA
				--LIMIT <-- FOCUS AREA


--QUESTIONS				
				
	-- Question 1: Select 300 Rows from the SALES table

SELECT *
FROM Sales
LIMIT 300

	-- Question 2: Fix the below code

		/*SELECT 
		item
		, store
		, county
		, sales,
		FROM sales
		LIMIT 100*/
		
-- Answer Question 2: I Removed comma after sales (column)
                       
 SELECT 
		item
		, store
		, county
		, sales
		FROM sales
		LIMIT 100
/*Question 3: Show me a list of Store_#'s, their name, and status.
	Order them by name from 'A-Z'. *Hint - use the STORES table */

    SELECT 
	store
	,name
	,store_status 
	FROM Stores
	ORDER BY name ASC
	
/*Question 4: Show me the bottle price of all a vendor's items
	, the product category of those items, and bottle price with a 11% tax rate added on. 
	*Hint - use the PRODUCTS table*/
	
SELECT 
item_no
,item_description
,bottle_price
,category_name
,bottle_price * 1.11 AS Bottle_Price_W/TAX
FROM
Products 

/*Question 5: Find the highest profit item. 
	*Hint - (Shelf Price - Bottle Price) = Profit*. Use PRODUCTS table*/
SELECT 
item_description
,bottle_price
,category_name
,Shelf_Price
,(cast(Shelf_Price AS Money) - Bottle_Price)AS Profit
	 
FROM products
WHERE bottle_price IS NOT NULL AND shelf_price IS NOT NULL
Group by 
item_description
,bottle_price
,category_name
,Shelf_Price

ORDER BY (cast(Shelf_Price AS Money) - Bottle_Price) DESC

LIMIT 1


--               WORKSHOP:   FILTERS  - 30 Min.               --
----------------------------------------------------------------

				--SELECT
				--FROM 
				--WHERE <-- FOCUS AREA
				--GROUP BY 
				--ORDER BY
				--LIMIT



-- QUESTIONS

	-- Question 1: Give me a list of all products that vendor 305 has.
	
		SELECT
		*
		FROM PRODUCTS 
		WHERE vendor = 305

	-- Question 2: Give me a distinct list of vendors that sell Flavored Rum.
	
		SELECT 
		DISTINCT VENDOR
		,Vendor_name
		,category_name
		FROM PRODUCTS
		WHERE UPPER(category_name) LIKE '%FLAVORED RUM%'
		
		-- Question 3: Give me a distinct list of items and their respective list date, that were listed in Feburary 2015.
	
		SELECT
		Distinct 
		item_no
		,item_description
		,list_date
		FROM PRODUCTS 
		WHERE to_char(list_date,'MM-YYYY')= '02-2015'
	

	-- Question 4: Give me a list of Peach Brandies that are in a 1000 ml bottle size or are over 70 proof. Remember, CONTAINED OR.
	
	SELECT 
	item_no
	,category_name
	,item_description
	,bottle_size
	,proof
	
    FROM Products
	 WHERE lower(item_description) LIKE '%peach%' 
    AND (Bottle_size = 1000 OR cast(proof AS INT)>70)		
	

-- Question 5: Which items are Tequilas or Scotch Whiskies that have a case cost between $100 and $120?
	
	SELECT 
	item_no
	,category_name
	,item_description
	,case_cost
	
             FROM Products
	WHERE case_cost BETWEEN 100 AND 120 
             AND (lower(category_name) LIKE '%tequila%' OR lower(category_name) LIKE '%scotch whisk%')

	-- Question 6: Which items don't have a product category and their list date is not 2007, 2008, or 2009?
	
	SELECT
	item_no
	,category_name
	,item_description
	,to_char(list_date,'YYYY')AS LIST_YEAR
		
	FROM PRODUCTS 
	WHERE category_name IS NULL AND to_char(list_date,'YYYY') NOT IN ('2007','2008','2009')
		
	-- Question 7: Give me a list of drinks that have the color blue in the item description.	
	
	 SELECT
	 item_no
	 ,category_name
	 ,item_description
	FROM PRODUCTS
	WHERE lower(item_description) LIKE '%blue%'

	-- Question 8: Give me a DISTINCT list of items that are either 100 proof Flavored Vodka in a 12 pack OR Tequila with a case cost under $150 dollars.
	
	SELECT
	 DISTINCT item_no
	 ,category_name
	 ,item_description
	 ,pack
	 ,case_cost 
		FROM PRODUCTS 
		WHERE (lower(category_name) LIKE '%flavored vodka%' AND cast(proof AS INT) =100 AND pack =12)
			  OR (lower(category_name) LIKE '%tequila%' AND case_cost < 150)
	ORDER BY category_name
	
-- Question 9: Iowa Frat Bro says, "Give me a list of items that are mint flavored. These drinks should be over 90 proof and have a case cost under $100, brah".
	
	SELECT
	 DISTINCT item_no
	 ,category_name
	 ,item_description
	 ,case_cost 
		FROM PRODUCTS 
		WHERE lower(item_description) LIKE '%mint%' AND cast(proof AS INT) >90 AND case_cost < 100
	ORDER BY category_name

----------------------------------------------------------------
--            WORKSHOP:   AGGREGATES - 15 Min.                --
----------------------------------------------------------------	
				
				--SELECT
				--FROM 
				--WHERE
				--GROUP BY <-- FOCUS AREA
				--ORDER BY
				--LIMIT
	
-- Question 1: Give me Total Sales for Tequila products grouped by Year *Hint, use the Sales table. Also, TOTAL is the sales column*
	
	SELECT 
	SUM (total) AS Total_Sales
	,Category_name
	,to_char(date,'YYYY') AS Sales_Year
	
	FROM SALES
	
	WHERE category_name IN ('TEQUILA')
	
	GROUP BY Category_name
	,to_char(date,'YYYY') 
	
-- Question 2: Give me the Total Sales for 'Jim Beam Brands' Vendor by Category Name and Month for 2015 *HINT, use TO_CHAR() for Month grouping*

SELECT 
	SUM (total) AS Total_Sales
	,Category_name
	,to_char(date,'Mon-YYYY') AS Sales_MONTH
	,vendor
	
	FROM SALES
	
	WHERE Vendor IN ('Jim Beam Brands') AND to_char(date,'Mon-YYYY') LIKE '%-2015'
	
	GROUP BY Category_name
	,to_char(date,'Mon-YYYY') 
	,Vendor
	ORDER BY Sales_MONTH DESC



-- WORKSHOP:   Putting It All Together: Fix the Code - 30 min. - 
----------------------------------------------------------------

                --SELECT <-- FOCUS AREA
				--FROM <-- FOCUS AREA
				--WHERE <-- FOCUS AREA
				--GROUP BY <-- FOCUS AREA
				--ORDER BY <-- FOCUS AREA
				--LIMIT <-- FOCUS AREA



/* Hey Analyst,

	Bill is asking for a data pull to understand the following KPIs for Seagram's Branded Whiskey in 2014: 
	
	* Total Revenue
	* Total Profit
	* Total Profit Margin
	* Total Volume in Lieters sold
	
	He'd also like the above data grouped by county, sorted from highest revenue to lowest revenue county.
	
	Larry, the last analyst, left this code that pulled something similar. I'm not sure if it still works
	but it would be a great jumping off point. FYI, I'll be in Suncadia with my family so if you are lost
	maybe you could sync up with Valeri if you can't wrap your head around it. That'd be great. Thanks. */
	
	--CODE
	
	SELECT
	County
	,sum(cast(total AS MONEY)) as TOTAL_REVENUE
	,(state_btl_cost * bottle_qty) as TOTAL_COST
	,sum(cast(total AS MONEY)) - (state_btl_cost * bottle_qty) AS TOTAL_PROFIT
	,sum(liter_size) as LITER_VOLUME
	,to_char(date,'YYYY')AS SALES_YEAR
	,category_name
	,description
	
	FROM SALES
	
	WHERE lower(description) LIKE ('%seagrams%') AND to_char(date,'YYYY') = '2014'AND UPPER(category_name) LIKE ('%WHISKIES%')
	
	GROUP BY
	County,to_char(date,'YYYY'),(state_btl_cost * bottle_qty) ,category_name,description
	
	ORDER BY TOTAL_REVENUE DESC
	






----------------------------------------------------------------
--            WORKSHOP: Joining Tables                        --
----------------------------------------------------------------


/* Question 1: Give me the total sales (use total column in sales table) for the top 10 selling stores by name*/
SELECT 
St.name	AS STORE_NAME		  
,Sum(S.total)AS TOTAL_SALES
,S.store AS STORE_NUMBER_SALES
,St.store AS STORE_NUMBER_STORES

FROM SALES AS S LEFT JOIN STORES AS St ON S.store=St.store
GROUP BY S.store,
St.store,St.name
ORDER BY TOTAL_SALES DESC	
LIMIT 10
			  
			  
/* Question 2: Give me total sales for Tequila Products grouped by proof amount. */
SELECT 
P.proof			  
,SUM(cast(S.total AS MONEY)) AS TOTAL_SALES
,P.category_name 
FROM Sales AS S LEFT JOIN Products AS P ON S.item = P.item_no
WHERE lower(P.category_name) LIKE '%tequila%'
GROUP BY 
P.proof
,P.category_name	

/* Question 3: Give me a list of the top 10 vendors with the highest number of UNSOLD coffee products. (Use item_description to find coffee products) */
SELECT 
p.vendor			  
,COUNT (DISTINCT p.item_no) AS VOLUME_ITEMS_UNSOLD
,P.item_description
,S.item	AS Item_SOLD	  
FROM Sales AS S RIGHT JOIN Products AS P ON S.item = P.item_no
WHERE lower(P.item_description) LIKE '%coffee%' AND S.item IS NULL
GROUP BY 
P.vendor,P.item_description,S.item
ORDER BY COUNT(DISTINCT P.item_no)	DESC  
LIMIT 10 
----------------------------------------------------------------
--            WORKSHOP: CASE STATEMENTS                       --
----------------------------------------------------------------


/* Question 1: What is the trend of sales by month and bottle_price_band in 2015. Use the below criteria to define bottle_price_band with a CASE statement:

	BTL_PRICE < 10.00 - CHEAP
	BTL_PRICE 10 and 29 - MODERATE
	BTL_PRICE 30 and 59 - HIGH
	BTL_PRICE OVER 60 -  EXPENSIVE*/
	
SELECT
	to_char(date,'MM-YYYY')AS Month_Year
	,SUM(Cast(total AS money))AS Total_sales
	,CASE    
			 WHEN Cast(btl_price AS Decimal)<10 THEN 'CHEAP'
		     WHEN Cast(btl_price AS Decimal) BETWEEN 10 AND 29.99 THEN 'MODERATE'
		     WHEN Cast(btl_price AS Decimal) BETWEEN 30 AND 59.99 THEN 'HIGH'
		     WHEN Cast(btl_price AS Decimal) > 60 THEN 'EXPENSIVE'
		     ELSE 'OTHER' END AS Bottle_Price_Band

FROM SALES 
WHERE to_char(date,'YYYY') = '2015' AND btl_price IS NOT NULL
GROUP BY  to_char(date,'MM-YYYY'),
				 CASE 
			     WHEN cast (btl_price AS Decimal)<10 THEN 'CHEAP'
		     	 WHEN Cast(btl_price AS Decimal) BETWEEN 10 AND 29.99 THEN 'MODERATE'
		    	 WHEN Cast(btl_price AS Decimal) BETWEEN 30 AND 59.99 THEN 'HIGH'
		     	 WHEN Cast(btl_price AS Decimal) > 60 THEN 'EXPENSIVE'
		   		 ELSE 'OTHER' END

ORDER BY 	to_char(date,'MM-YYYY') , SUM(Cast(total AS money))

											   



/* Question 2: Same as above, except use SUM(CASE WHEN ....) to create 4 seperate columns to calculate sales for each bottle_price_band.
*/
	SELECT
	to_char(date,'MM-YYYY')AS Month_Year
	,SUM(CASE WHEN Cast(btl_price AS Decimal)<10 THEN TOTAL ELSE 0 END) AS CHEAP
	,SUM(CASE WHEN Cast(btl_price AS Decimal) BETWEEN 10 AND 29.99 THEN TOTAL ELSE 0 END) AS MODERATE
	,SUM(CASE WHEN Cast(btl_price AS Decimal) BETWEEN 30 AND 59.99 THEN TOTAL ELSE 0 END) AS HIGH
	,SUM(CASE WHEN Cast(btl_price AS Decimal) > 60 THEN TOTAL ELSE 0 END) AS EXPENSIVE	     
,SUM(TOTAL) AS Total_sales
FROM SALES 
WHERE to_char(date,'YYYY') = '2015' AND btl_price IS NOT NULL
GROUP BY  to_char(date,'MM-YYYY')
ORDER BY to_char(date,'MM-YYYY') , SUM(Cast(total AS money))

	
----------------------------------------------------------------
--            WORKSHOP: TEMPORARY TABLES                      --
----------------------------------------------------------------

/* Question 1: Write an indepedent query for each of the below

	a. A list of counties and their population
	
	b. Total Sales and Total Store Count by County in 2015
	
	c. #1 Selling Product in Each County in 2015 *Hint, use the RANK function*
	
	AFTER WRITING EACH QUERY, JOIN THEM ALL TOGETHER (ABC) USING the WITH keyword...HINT, you will be joining on COUNTY.
*/
--a--
SELECT *
FROM counties
--b--											
SELECT
County											
,SUM(TOTAL)	AS TOTAL_SALES_2015
,COUNT(DISTINCT Store)AS TOTAL_STORES_2015
FROM SALES
WHERE to_char(date,'YYYY') ='2015'			
GROUP BY County										




---------OR (CLASS EXAMPLE FOR 1 YEAR)
SELECT 
 County
, SUM(CASE WHEN TO_CHAR(Date, 'YYYY') = '2015' THEN TOTAL ELSE 0 END) AS TOTAL_SALES_2015
,Count (Distinct CASE WHEN TO_CHAR(Date, 'YYYY') = '2015' THEN Store ELSE NULL END)AS TOTAL_STORES_2015
FROM SALES
WHERE TO_CHAR(Date, 'YYYY')IN ('2015')
GROUP BY County
											
--c--											
SELECT 	
TOTAL_SALES
,ITEM_RANK									
,item	
,County
,SALES_YEAR											
FROM(
SELECT 
SUM(TOTAL)AS TOTAL_SALES
,to_char(date,'YYYY') AS SALES_YEAR
,RANK () OVER(Partition BY County ORDER BY SUM (TOTAL)) AS ITEM_RANK									
,item	
,County											
FROM SALES	
GROUP BY 										
item	
,County,to_char(date,'YYYY')	)	AS NUMBER1_SOLD_ITEM_TBL											
WHERE SALES_YEAR ='2015'	AND  ITEM_RANK = 1
GROUP BY 										
TOTAL_SALES
,ITEM_RANK									
,item	
,County
,SALES_YEAR	  

--ALL TOGETHER-- 
WITH 
 County_POP AS(Select * FROM COUNTIES)
,COUNTY_TOTAL_STORES AS (SELECT
County											
,SUM(TOTAL)	AS TOTAL_SALES_2015
,COUNT(DISTINCT Store)AS TOTAL_STORES_2015
FROM SALES
WHERE to_char(date,'YYYY') ='2015'			
GROUP BY County	)	
,COUNTY_TOP_SELLERS AS
(SELECT 	
TOTAL_SALES
,ITEM_RANK									
,item	
,County
,SALES_YEAR											
FROM(
SELECT 
SUM(TOTAL)AS TOTAL_SALES
,to_char(date,'YYYY') AS SALES_YEAR
,RANK () OVER(Partition BY County ORDER BY SUM (TOTAL)) AS ITEM_RANK									
,item	
,County											
FROM SALES	
GROUP BY 										
item	
,County,to_char(date,'YYYY')	)	AS NUMBER1_SOLD_ITEM_TBL											
WHERE SALES_YEAR ='2015'	AND  ITEM_RANK = 1
GROUP BY 										
TOTAL_SALES
,ITEM_RANK									
,item	
,County
,SALES_YEAR	 )	

	SELECT *
	FROM
	County_POP AS A LEFT JOIN COUNTY_TOTAL_STORES AS B ON A.county =b.county 
	LEFT JOIN COUNTY_TOP_SELLERS AS C ON A.county = C.County
	
---------------------CLASS 2 YEARs EXAMPLE--------	
	WITH County_POP AS
(Select County, population FROM COUNTIES),
COUNTY_TOTAL_STORES AS (SELECT 
 County
, SUM(CASE WHEN TO_CHAR(Date, 'YYYY') = '2015' THEN TOTAL ELSE 0 END) AS TOTAL_SALES_2015
, SUM(CASE WHEN TO_CHAR(Date, 'YYYY') = '2014' THEN TOTAL ELSE 0 END) AS TOTAL_SALES_2014
,Count (Distinct CASE WHEN TO_CHAR(Date, 'YYYY') = '2015' THEN Store ELSE NULL END)AS TOTAL_STORES_2015
,Count (Distinct CASE WHEN TO_CHAR(Date, 'YYYY') = '2014' THEN Store ELSE NULL END) AS TOTAL_STORES_2014
FROM SALES
WHERE TO_CHAR(Date, 'YYYY')IN ('2014','2015')
GROUP BY County),
COUNTY_TOP_SELLERS AS (SELECT
 County
,Item
,Description
,TOTAL_SALES
,ITEM_RANK
FROM
(SELECT
SUM(TOTAL) AS TOTAL_SALES
,County
, Item
,Description
,RANK () OVER(Partition BY County ORDER BY SUM (TOTAL)) AS ITEM_RANK
FROM Sales
WHERE TO_CHAR(Date, 'YYYY')IN ('2015')
GROUP BY county, Item,Description) AS Number_1_Product
WHERE 
ITEM_RANK =1	)		  

SELECT * 
FROM
COUNTY_POP AS A
LEFT JOIN COUNTY_TOP_SELLERS AS B ON A.County = B.County
LEFT JOIN COUNTY_TOTAL_STORES AS C ON A.County = C.County

