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

		SELECT
		*
		FROM SALES
		LIMIT 300

	-- Question 2: Fix the below code

		SELECT 
		item
		, store
		, county
		, sales,
		FROM sales
		LIMIT 100
	
	-- Question 3: Show me a list of Store_#'s, their name, and status. Order them by name from 'A-Z'. *Hint - use the STORES table*

		SELECT
		store
	   ,name
	   ,store_status
	   FROM STORES
	   ORDER BY 2 ASC

	-- Question 4: Show me the bottle price of all a vendor's items, their product category, and bottle price with a 11% tax rate added on. *Hint - use the PRODUCTS table*


		SELECT
		 item_no
		,category_name
		,bottle_price
		,(bottle_price * 1.11) as BOTTLE_PRICE_WITH_TAX
	
		FROM PRODUCTS
	

	-- Question 5: Calculate the profit realized from selling 1 individual bottle for each item. *Hint - (Shelf Price - Bottle Price) = Profit*. Use PRODUCTS table.

		SELECT
		item
		,(cast(shelf_price as money) - bottle_price) as PROFIT
		
		FROM PRODUCTS
	

-- Question 6: Determine the lowest level of granularity from the PRODUCTS table. Can you prove out using the DISTINCT function?

		SELECT DISTINCT item FROM PRODUCTS --9977
		
		SELECT DISTINCT item_description FROM PRODUCTS --7276
	
	
	
-- STRETCH QUESTIONS

		--Question 1: Calculate the profit realized from selling an entire case for each item. Sort by highest profit item. *Hint - (Shelf Price * Pack) = Shelf Price per Case. (Shelf Price per Case - Case Cost) = Profit
		
			
			SELECT
			item
			,(shelf_price * pack) - case_cost as PROFIT
			
			FROM PRODUCTS
			
			ORDER BY 2 DESC
				


----------------------------------------------------------------
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
		FROM PRODUCTS WHERE VENDOR = 305

	-- Question 2: Give me a distinct list of vendors that sell Flavored Rum.
	
		SELECT
		DISTINCT VENDOR
		FROM PRODUCTS WHERE CATEGORY_NAME = 'FLAVORED RUM'

	-- Question 3: Give me a distinct list of items and their respective list date, that were listed in Feburary 2015.
	
		SELECT
		item_no
		,list_date
		FROM PRODUCTS WHERE to_char(list_date, 'YYYY-MM') = '2015-02'
	

	-- Question 4: Give me a list of Peach Brandies that are in a 1000 ml bottle size or are over 70 proof.
	
		SELECT
		*
		FROM PRODUCTS WHERE CATEGORY_NAME = 'PEACH BRANDIES' AND (BOTTLE_SIZE = 1000 OR cast(PROOF as INT) > 70)
		
	-- Question 5: Which items are Tequilas or Scotch Whiskies that have a case cost between $100 and $120?
	
		SELECT
		*
		FROM PRODUCTS WHERE CATEGORY_NAME IN ('TEQUILA','SCOTCH WHISKIES') AND CASE_COST BETWEEN 100 and 120

	-- Question 6: Which items don't have a product category and their list date is not 2007, 2008, or 2009?
	
		SELECT
		*
		FROM PRODUCTS WHERE CATEGORY_NAME IS NULL AND TO_CHAR(LIST_DATE,'YYYY') NOT BETWEEN '2007' AND '2009'
	
	-- Question 7: Give me a list of drinks that have blue in the item description. 
	
		SELECT
		*
		FROM PRODUCTS WHERE ITEM_DESCRIPTION LIKE '%Blue%'
		
	-- Question 8: Give me a list of drinks that have the color blue in the item description.	
	
		SELECT
		*
		FROM PRODUCTS WHERE ITEM_DESCRIPTION LIKE '%Blue %'
	

-- STRETCH QUESTIONS

	-- Question 1: Give me a DISTINCT list of items that are either 100 proof Flavored Vodka in a 12 pack OR Tequila with a case cost under $150 dollars.
	
		SELECT
		*
		FROM PRODUCTS WHERE (CATEGORY_NAME = 'FLAVORED VODKA' AND PACK = 12 AND PROOF = '80') OR (CATEGORY_NAME = 'TEQUILA' AND CASE_COST < 150) ORDER BY 2
	
	-- Question 2: Iowa Frat Bro says, "Give me a list of items that are mint flavored. These drinks should be over 90 proof and have a case cost under $100, brah".
	
		SELECT
		*
		FROM PRODUCTS WHERE lower(ITEM_DESCRIPTION) LIKE '%mint%' AND cast(proof as int) > 90 AND CASE_COST < 100


----------------------------------------------------------------
--            WORKSHOP:   AGGREGATES - 15 Min.                --
----------------------------------------------------------------	
				
				--SELECT
				--FROM 
				--WHERE
				--GROUP BY <-- FOCUS AREA
				--ORDER BY
				--LIMIT
				
	-- Question 1: Give me the Top 5 Selling Liter Sizes in 2014. *Hint, use the Sales table. Also, TOTAL is the sales column*
	
			
		SELECT
		liter_size
		,sum(total) as SALES
		FROM SALES

		
		WHERE
		to_char(date, 'YYYY') = '2014'
		
		GROUP BY
		liter_size
		
		ORDER BY 2 DESC
		
		LIMIT 5
		
	
	-- Question 2: Give me Total Sales for Tequila products grouped by Year 
	
		SELECT
		sum(total) as SALES
		,to_char(date, 'YYYY') as YEAR
		,category_name
		
		FROM SALES
		
		WHERE CATEGORY_NAME = 'TEQUILA'
		
		GROUP BY
		to_char(date, 'YYYY')
		,category_name
	
	
	
	-- Question 3: Give me the Total Sales for 'Jim Beam Brands' Vendor by Category Name and Month for 2015
	
		SELECT
		 sum(total) as SALES
		,to_char(date, 'MM') as MONTH
		,category_name
		
		FROM SALES
		
		WHERE vendor = 'Jim Beam Brands'
		
		AND to_char(date, 'YYYY') = '2015'
		
		GROUP BY
		 to_char(date, 'MM')
		,category_name
				
				
----------------------------------------------------------------
-- WORKSHOP:   Putting It All Together: Fix the Code - 30 min. - 
----------------------------------------------------------------

                --SELECT <-- FOCUS AREA
				--FROM <-- FOCUS AREA
				--WHERE <-- FOCUS AREA
				--GROUP BY <-- FOCUS AREA
				--ORDER BY <-- FOCUS AREA
				--LIMIT <-- FOCUS AREA



/* Hey Analyst,

	Bill is asking for a data pull to find out the TOTAL sales, cost, profit and distinct items count of Seagram's branded whiskey
	for 2014 by county. Can we exclude sales that don't have a county?

	Ideally, he'd like to understand these numbers by liter size.
	
	Could you also sort these results by county and total sales, alphabetically and highest to lowest?
	
	Larry, the last analyst, left this code that pulled something similar. I'm not sure if it still works
	but it would be a great jumping off point. Maybe you could sync up with Valeri if you can't wrap
	your head around it. */
	
	--CODE
	
	SELECT
	
	 sum(total) as TOTAL_REVENUE
	,distinct(count item) as DISTINCT_ITEM_COUNT 
	,(state_btl_cost * bottle_qty) as TOTAL_COST
	,(total - (state_btl_cost * bottle_qty))
	,sum(liter_size) as "LITER VOLUME"
	,cty as County
	
	FROM SALES
	
	WHERE 
	
	description IN (Seagrams%Whiskey)
	
	AND UPPER(county) != UPPER('NULL')
	
	date = 1/1/2014
	
	GROUP BY
	
	 sum(total) as TOTAL_REVENUE
	,(state_btl_cost * bottle_qty) as TOTAL_COST
	,(total - (state_btl_cost * bottle_qty)) as TOTAL_PROFIT
	,sum(liter_size) as "LITER VOLUME"
	,cty as County
	
	ORDER BY COUNTY, TOTAL DESC
	
	
	--ANSWER
	
	SELECT
	
	 sum(total) as TOTAL_REVENUE
	,sum(state_btl_cost * bottle_qty) as TOTAL_COST
	,sum(cast(total as money) - (state_btl_cost * bottle_qty)) as TOTAL_PROFIT
	,count(distinct item) as ITEM_COUNT
	,liter_size
	,county
	
	FROM SALES
	
	WHERE 
	
	description like 'Seagrams%Whiskey'
	
	AND COUNTY IS NOT NULL
	
	AND to_char(date,'YYYY') = '2014'
	
	GROUP BY
    liter_size
	,county
	
	ORDER BY 6, 1 DESC
	

----------------------------------------------------------------
--            WORKSHOP: Joining Tables                        --
----------------------------------------------------------------


/* Hey Red, Give me the top 10 stores in terms of sales for for 2014. I want them listed by store name. */

--0. Can we answer this question in a single table?

/* STEPS TO JOIN */

	--1. At least 2 tables, with at least 1 column/field in common

	--2. Column/field(s) tables have in common, MUST be same data type

	--3. The column/field in Table B should be unique, otherwise duplication will occur.

		-- Sample code to check for duplicate records in Table B.

			SELECT

			 STORE -- This is the column you'll be joining onto in Table B. Eg. customer_id.
			,COUNT(*) -- This counts the occurence of duplicates in column above.

			FROM STORES -- Table B goes here

			GROUP BY
			STORE  --Column you'll be joining onto in Table B.

			HAVING COUNT(*) > 1 --This returns the primary key records that only have duplicates.
									--If there is nothing in result output, then no duplicates for primary key. Clean join.
									--If there is records in result output, then duplicate values for primary key. Need to de-deup before JOINing.




--4. FINAL CODE


			SELECT

			SUM(A.TOTAL) AS TOTAL_SALES
			,B.NAME

			FROM SALES A

			LEFT JOIN STORES B ON B.STORE = A.STORE

			WHERE A.STORE IS NOT NULL
			AND TO_CHAR(date, 'YYYY') = '2014'

			GROUP BY
			B.NAME

			ORDER BY 1 DESC




