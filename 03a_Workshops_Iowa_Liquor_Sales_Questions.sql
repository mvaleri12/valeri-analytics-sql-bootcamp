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


	-- Question 2: Fix the below code

		SELECT 
		item
		, store
		, county
		, sales,
		FROM sales
		LIMIT 100
	
	/*Question 3: Show me a list of Store_#'s, their name, and status.
	Order them by name from 'A-Z'. *Hint - use the STORES table */


	/*Question 4: Show me the bottle price of all a vendor's items
	, their product category, and bottle price with a 11% tax rate added on. 
	*Hint - use the PRODUCTS table*
	

	/*Question 5: Find the highest profit item. 
	*Hint - (Shelf Price - Bottle Price) = Profit*. Use PRODUCTS table*/

	
-- STRETCH QUESTIONS

	/*Question 1: Calculate the profit realized from selling an entire case for each item. 
	Sort by highest profit item. 
	*Hint - (Shelf Price * Pack) = Shelf Price per Case. 
	(Shelf Price per Case - Case Cost) = Profit*/


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
		FROM PRODUCTS 

	-- Question 2: Give me a distinct list of vendors that sell Flavored Rum.
	
		SELECT
		DISTINCT VENDOR
		FROM PRODUCTS
		WHERE

	-- Question 3: Give me a distinct list of items and their respective list date, that were listed in Feburary 2015.
	
		SELECT
		item_no
		,list_date
		FROM PRODUCTS 
		WHERE 
	

	-- Question 4: Give me a list of Peach Brandies that are in a 1000 ml bottle size or are over 70 proof.
	
		SELECT
		*
		FROM PRODUCTS 
		WHERE 
		
	-- Question 5: Which items are Tequilas or Scotch Whiskies that have a case cost between $100 and $120?
	
		SELECT
		*
		FROM PRODUCTS 
		WHERE 

	-- Question 6: Which items don't have a product category and their list date is not 2007, 2008, or 2009?
	
		SELECT
		*
		FROM PRODUCTS 
		WHERE 
	
	-- Question 7: Give me a list of drinks that have blue in the item description. 
	
		SELECT
		*
		FROM PRODUCTS 
		WHERE
		
	-- Question 8: Give me a list of drinks that have the color blue in the item description.	
	
		SELECT
		*
		FROM PRODUCTS
		WHERE 
	

-- STRETCH QUESTIONS

	-- Question 1: Give me a DISTINCT list of items that are either 100 proof Flavored Vodka in a 12 pack OR Tequila with a case cost under $150 dollars.
	
		SELECT
		*
		FROM PRODUCTS 
		WHERE 
	
	-- Question 2: Iowa Frat Bro says, "Give me a list of items that are mint flavored. These drinks should be over 90 proof and have a case cost under $100, brah".
	
		SELECT
		*
		FROM PRODUCTS 
		WHERE


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
	
	
	-- Question 2: Give me Total Sales for Tequila products grouped by Year 
	
	
	-- Question 3: Give me the Total Sales for 'Jim Beam Brands' Vendor by Category Name and Month for 2015
				
				
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
	
	 sum(total) as TOTAL_REVENUE
	,(state_btl_cost * bottle_qty) as TOTAL_COST
	,sum(liter_size) as "LITER VOLUME"
	,cty as County
	
	FROM SALES
	
	WHERE 
	
	description IN (Seagrams%Whiskey)
	
	date = 1/1/2014
	
	GROUP BY
	
	 sum(total) as TOTAL_REVENUE
	,(state_btl_cost * bottle_qty) as TOTAL_COST
	,sum(liter_size) as "LITER VOLUME"
	,cty as County
	
	ORDER BY COUNTY, TOTAL DESC
	

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



