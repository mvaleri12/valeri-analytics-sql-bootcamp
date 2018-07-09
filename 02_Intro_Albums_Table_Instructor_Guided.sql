
----------------------------------------------------------------
-- SELECT * FROM w/ LIMIT                                     --
----------------------------------------------------------------

	-- 1. SELECT ALL DATA FROM A TABLE

		--Approach 1 (Written on seperate lines)

			SELECT
			*
			FROM
			ALBUMS

		--Approach 2 (Written on same line)

			SELECT * FROM ALBUMS

		--Approach 3 (Written on seperate lines and same line)

			SELECT *
			FROM ALBUMS

		--Approach 4 (Written on seperate lines, same line, and different cases)

			seLECT * 
			fRoM Albums 

		/* 
		Key Takeaways
		1. SQL Keywords (SELECT / FROM / WHERE / GROUP BY) are case insensitive, but are often written in caps as a best practice)
		2. Table/Column names are USUALLY case insenstive, but can vary depending on the dialect of SQL you are using. Using caps is a best practice.
		3. Whitespace (spaces, indents, new lines) is a best practice between keywords, colunmns, and tables. Helps keep your code organized and readable.
		4. SELECT * is useful for exploring the fields in a table, but there is potential drawbacks...
		5. ....especially if you are working with a table that has 1 billion rows. Luckily only working with a few. 
		*/

	--2. LIMIT ROWS/RECORDS FROM TABLE

			SELECT
			*
			FROM ALBUMS
			LIMIT 3

	/* 
	Key Takeaways
	1. Helpful when you want to investigate a table, but not crash the server
	2. Can be leveraged for RANK functions (will dicuss when talking about subqueries and CTEs)
	3. Save this output in an Excel file, a workbook of data samplings from tables.
	*/

----------------------------------------------------------------
-- SELECT SPECIFIC COLUMNS AND ORDER BY                       --
----------------------------------------------------------------

	--3. SELECT FIELDS/COLUMNS FROM A TABLE

		SELECT
		 ROW -- Name of column 1
		,ARTIST -- Name of column 2
		,ALBUM -- Name of column 3

		FROM ALBUMS

	/*
	Key Takeaways
	1. You need to seperate each distinct column with a ",".
	2. You don't need a "," AFTER your final column
	3. You don't need a "," BEFORE your first column
	4. Often times, most SQL execution errors are because you have an extra "," or you are missing a ","
	*/

	--4. ORDER RESULT OUTPUT BY COLUMN FROM A-Z

		-- Approach 1 (using alias for column)

			SELECT
			ROW
			,ARTIST
			,ALBUM

			FROM ALBUMS

			ORDER BY 2 ASC -- We are ordering by the records/rows found in the 2nd column (ARTIST) from A-Z (ASC), rather than Z-A (DESC)

		-- Approach 2 (not using alias for column)

			SELECT
			ROW
			,ARTIST
			,ALBUM

			FROM ALBUMS

			ORDER BY ARTIST ASC

	/*
	Key Takeaways
	1. The number 2 in the order by statement represents the column name.
	2. ASC/DESC is easy to confuse. Cheat table
		ASC with numeric column --> 0 to 1000 (0 would be first row)
		DESC with numeric column --> 1000 to 0 (1000 would be first row)
		ASC with text column --> A to Z (A would be first row)
		DESC with text column --> Z to A (Z would be first row)
	*REMEMBER WHEN USING DESC;
						"Z" and "100" ARE THE TOP OF STAIRS, as you go down, the number or letters get's lower)		
	*/


-----------------------------------------------------
--    SELECT w/ MATH, AS AND CAST                  --
-----------------------------------------------------


	--5. PERFORMING ('+', '/', '-', '*') ON A COLUMN

		SELECT
		 ALBUM
		,ORG_PRICE
		,(ORG_PRICE * 0.2) -- Total Tax Amount
		,(ORG_PRICE * 1.2)  -- Approach 1: Total Price w/ Tax Amount
		,(ORG_PRICE * 0.2) + ORG_PRICE -- Approach 2: Total Price w/ Tax Amount

		FROM ALBUMS

	/*
	Key Takeaways
	1. When you add a column calculation, think of it as augmenting your table with a new column.
	2. You can use ( + , - , / , * ) All math operations can be found here: https://www.postgresql.org/docs/9.5/static/functions-math.html
	3. Wrap your calculations in a " ( ) ". Order of operations hold's true in SQL.
	4. The column labels for calculations are not helpful....how do we change? 
	*/

	--6. RENAMING A COLUMN/TABLE WITH 'AS'

		--Renaming Columns

			SELECT
			 ALBUM
			,ORG_PRICE
			,(ORG_PRICE * 0.2) AS TOTAL_TAX_AMT -- Total Tax Amount w/ AS
			,(ORG_PRICE * 1.2) as ORG_PRICE_WITH_TAX -- Approach 1: Total Price w/ Tax Amount
			,(ORG_PRICE * 0.2) + ORG_PRICE As "ORG PRICE WITH TAX" -- Approach 2: Total Price w/ Tax Amount

			FROM ALBUMS


		--Renaming Tables

			SELECT
			 A.ALBUM -- Notice we append "ALIAS." to the column when renaming the table
			,A.ORG_PRICE

			FROM ALBUMS AS A -- "A" is the alias of this table now


		/*
		Key Takeaways
		1. Aliases (AS) allow us to rename columns/tables
		2. If you'd like there to be a space in our column alias, you can use [ ] around the alias name
		3. Aliases are Useful When
				There are more than one table involved in a query
				Functions are used in the query
				Column names are big or not very readable
				Two or more columns are combined together
		4. We cannot use AS in our GROUP BY Statement (more on this later)
		*/

	--7. ADDING COLUMNS W/ MORE THAN 1 DATA TYPE

		--Approach 1 (before cast function)

			SELECT
			 ALBUM
			,ORG_PRICE -- Money data type
			,MARKET_VALUE -- Numeric data type
			,(MARKET_VALUE - ORG_PRICE) AS TOTAL_PROFIT --Mixing Numeric with Money data type will not work

			FROM ALBUMS

		--Approach 2 (with cast function)

			SELECT
			 ALBUM
			,ORG_PRICE
			,MARKET_VALUE
			,(CAST(MARKET_VALUE AS MONEY) - ORG_PRICE) AS TOTAL_PROFIT --The cast() function syntax is cast(column as data_type). Casted Market_Value as MONEY
			,(MARKET_VALUE - CAST(ORG_PRICE AS NUMERIC(10,2))) AS TOTAL_PROFIT_2 --Casted ORG_PRICE as NUMERIC(10,2) instead. 

			FROM ALBUMS

	/*
	Key Takeaways
	1. You cannot (+, -, /, *) columns that are in different data types
	2. You need to convert all columns to the same common denominator/data type. It's like adding fractions or units.
	3. Here is more detail you need it for the cast function (http://www.postgresqltutorial.com/postgresql-cast/)
	*/


-----------------------------------------------------
--    SELECT w/ DISTINCT function                  --
-----------------------------------------------------

--8. USING THE DISTINCT FUNCTION

	--Approach 1 (w/o distinct)

		SELECT
		ARTIST

		FROM ALBUMS -- You get 10 rows in your result set, with duplicate values

	--Approach 2 (w/ distinct)

		SELECT
		DISTINCT ARTIST

		FROM ALBUMS -- You get 6 rows in your result set, with no duplicate values. Only 1 Kanye West instead of three...thankfully.


--9. USING DISTINCT TO DETERMINE GRANULARITY

		SELECT
		DISTINCT ALBUM

		FROM ALBUMS -- You get 10 rows in your result set, with no dups.

	/*
	Key Takeaways
	1. Artists have more than 1 album
	2. Album is the most granular column in the dataset, more on this later.
	3. Count function with DISTINCT is useful for determining granularity. More on this later.
	*/

--10. USING DISTINCT ON MUTLITPLE COLUMNS

	--Approach 1 (w/o distinct)

		SELECT
		GENRE, RATING

		FROM ALBUMS

		ORDER BY 1 -- 10 rows in your result set, with duplicates combinations.

	--Approach 2 (w/ distinct)

		SELECT
		DISTINCT GENRE, RATING

		FROM ALBUMS

		ORDER BY 1 --7 rows in you result set.

	/*
	Key Takeaways
	1. When more than 1 column is provided in DISTINCT clause, the query will retrieve unique combinations for the columns listed
	*/


----------------------------------------------------------------
--      NEXT: WORKSHOP 1: BASIC SQL SYNTAX - 15 Min.          --
----------------------------------------------------------------	
	
----------------------------------------------------------------------------------------------------------------------------------	
	
	
----------------------------------------------------------------
--          FILTERS - WHERE =, !=, AND, NOT, IN, IS           --
----------------------------------------------------------------

/*Records/rows you want to INCLUDE/EXCLUDE in YOUR RESULT-SET*/

	-- 1. DATA TYPES AND CASE SENSITIVITY WHEN FILTERING


		-- A. "=" with CHARACTER data type - All Albums with Genre = 'Rap'
		
			SELECT
			*
			FROM ALBUMS
			WHERE GENRE = 'Rap' -- We put single quote mark's around TEXT, VARCHAR. Notice this is case sensitive.


		--B. ">" with NUMERIC data type - All Albums with Rating > 4

		SELECT
		*
		FROM ALBUMS
		WHERE RATING > 4

		-- C. "=" with BOOLEAN data type - All Albums that are not playable

			-- Approach 1 - Treating column as a boolean

				SELECT
				*
				FROM ALBUMS
				WHERE PLAYABLE = FALSE

			--Approach 2 - Treating column as a character

				SELECT
				*
				FROM ALBUMS
				WHERE PLAYABLE = '0'

		-- D. "=" with DATE data type - All Albums released on '2004-02-10'

			SELECT
			*
			FROM ALBUMS
			WHERE RELEASE_DATE = '2004-02-10' --We put in the date in the 'YYYY-MM-DD' format

		-- E. "=" with DATE TO_CHAR date conversion -- All Albums released in '2004'

			--Year TO_CHAR(column,'YYYY')

				SELECT
				*
				FROM ALBUMS
				WHERE TO_CHAR(RELEASE_DATE, 'YYYY') = '2004'


			--Month-Year TO_CHAR(column,'YYYY-MM')
	
				SELECT
				*
				FROM ALBUMS
				WHERE TO_CHAR(RELEASE_DATE, 'YYYY-MM') = '2004-02'	

	-- 2. FILTERING ON MUTIPLE CONDITIONS

		-- A. IN THE SAME COLUMN/FIELD

			--With 'IN' (character data type)

				SELECT
				*
				FROM ALBUMS 
				WHERE GENRE IN ('Electronic','Rap')

			--With 'NOT IN' (character data type)
	
				SELECT
				*
				FROM ALBUMS 
				WHERE GENRE NOT IN ('Electronic','Rap')	

			-- 'BETWEEN' (numeric data type with 'AND')
	
				SELECT
				*
				FROM ALBUMS
				WHERE MARKET_VALUE BETWEEN 5 AND 10	


			-- >= and <= (Same as above)
			
				SELECT
				*
				FROM ALBUMS
				WHERE MARKET_VALUE >= 5 AND MARKET_VALUE <= 10


		-- B. IN DIFFERENT COLUMN/FIELDS ('AND')

			SELECT
			*
			FROM ALBUMS
			WHERE GENRE = 'Rap' AND RATING > 4

		-- C. IN DIFFERENT COLUMN/FIELDS ('OR')

		
				-- OR (UNCONTAINED)
	
					SELECT
					*
					FROM ALBUMS
					WHERE GENRE = 'Rap' AND RATING > 4 OR BURNED = TRUE --When you look at OR, pretend everything you wrote before OR is OVERWRITTEN, DOESN'T COUNT

				-- OR (CONTAINED w/ '()')

					SELECT
					*
					FROM ALBUMS
					WHERE GENRE = 'Rap' AND (RATING > 4 OR BURNED = TRUE)

	-- 3. DEALING WITH NULL VALUES (Can't use comparison operators)

		-- A. Filtering on NULL values with 'IS'

			SELECT
			*
			FROM ALBUMS
			WHERE ARTIST IS NULL

		-- B. Filtering out NULL values with 'IS NOT'

			SELECT
			*
			FROM ALBUMS
			WHERE ARTIST IS NOT NULL

	/*
	Key Takeaways
	1. The syntax for filtering depends on the field/column you are working with
	2. Case matters when filtering on text fields/columns
	3. BE CAREFUL WHEN USING OR
	4. Use To_CHAR() function when converting individual dates to years, months, etc. Here is an exhaustive list: https://www.postgresql.org/docs/9.1/static/functions-formatting.html
	5. There is more operators than (< , > , = , != ) Check out an exhaustive list here: https://www.postgresql.org/docs/9.1/static/functions-comparison.html
	*/ 


----------------------------------------------------------------
--          FILTERS - WHERE - LIKE AND PATTERN MATCHING       --
----------------------------------------------------------------

	-- 1. USING LIKE WITH '%', also known as the wild-card. Like '*' in Excel. Looks for value 'similar' or 'like'

		-- Example 1
	
			SELECT
			*
			FROM ALBUMS
			WHERE ARTIST LIKE 'R%' -- Interpretation? Artist must start with a 'R'. ANY VALUE can follow after 'R'.
			
		-- Example 2	

			SELECT
			*
			FROM ALBUMS
			WHERE ARTIST LIKE '%r%' -- Interpretation? Artist must contain an 'r'. ANY VALUE can proceed or follow 'r'. Notice 'Ratatat' is now missing.

	-- 2. USING UPPER AND LOWER FUNCTIONS WITH LIKE and '%'

		--LOWER() function

			SELECT
			 ARTIST
			,LOWER(ARTIST) AS ARTIST_LOWER
			,ALBUM
			FROM ALBUMS
			WHERE LOWER(ARTIST) LIKE '%r%' --Interpretation? ARTIST column in lower case format, must contain an 'r'. ANY VALUE can proceed or follow 'r'. Notice 'Ratatat' is present.

		--UPPER() function

			SELECT
			 ARTIST
			,UPPER(ARTIST) AS ARTIST_UPPER 
			,ALBUM
			FROM ALBUMS
			WHERE UPPER(ARTIST) LIKE '%R%' --Interpretation? ARTIST column in upper case format, must contain an 'R'. ANY VALUE can proceed or follow 'r'. Notice 'Ratatat' is present.

	/*
	Key Takeaways
	1. Use '%' in conjunction with the LIKE function.
	2. Remember, you might need to use UPPER or LOWER to convert/normalize the case of your column.
	3. Just because you function on a column in the WHERE clause, doesn't mean it will apply itself to your RESULT output.
	*/ 

----------------------------------------------------------------
--             NEXT WORKSHOP 2: FILTERS  - 30 Min.            --
----------------------------------------------------------------
	
----------------------------------------------------------------
--     AGGREGATE FUNCTIONS - COUNT / SUM / MIN / MAX / AVG    --
----------------------------------------------------------------

	-- 1. COUNT
	
		SELECT 
		COUNT(ARTIST) as ARTIST_COUNT
		FROM ALBUMS -- 13 records. Not counting (nulls) and double counting same artists
		
	-- 2. COUNT w/ DISTINCT

		
		-- CORRECT APPROACH
		
			SELECT
			COUNT(DISTINCT ARTIST) AS ARTIST_COUNT
			FROM ALBUMS -- 9 records. Not counting (nulls).
		
		-- INCORRECT APPROACH
			
			SELECT
			DISTINCT (COUNT ARTIST) AS ARTIST_COUNT
			FROM ALBUMS -- 13 records. We are taking a distinct of a count
			
			
	-- 3. SUM / AVG / MIN / MAX
		
		-- SUM / AVG / MIN / MAX
		
			SELECT
			SUM(PLAYS) AS TOTAL_PLAYS --9495 plays
			,AVG(RATING) AS AVG_RATING -- 4.233 rating
			,MIN(MARKET_VALUE) AS LOWEST_MKT_VALUE -- 0 
			,MAX(ARTIST) AS HIGHEST_ALPHABETIC -- T.I.
			
			FROM ALBUMS
			
			
	-- 4. AGGREGATE FUNCTIONS W/ FIELDS/COLUMNS

			SELECT
			SUM(PLAYS) AS TOTAL_PLAYS
			,GENRE
			
			FROM ALBUMS -- DOESN'T WORK? WHY?
			
			
			
	/*
	Key Takeaways
	1. COUNT doesn't include NULL values.
	2. You cannot mix aggregate functions with additional columns...unless you use a GROUP BY
	*/ 
	
	
----------------------------------------------------------------
--     AGGREGATE FUNCTIONS - GROUP BY AND HAVING CLAUSE       --
----------------------------------------------------------------
 		
		
	-- 1. AGGREGATE FUNCTIONS w/ Column/Field
	
		SELECT 
		 SUM(PLAYS) as TOTAL_PLAYS
		,ARTIST AS ARTIST_NAME
		
		FROM ALBUMS

		GROUP BY
		
		ARTIST -- 
		
		
	-- 2. MULTIPLE AGGREGATE FUNCTIONS w/ Column/Field


		SELECT
		 SUM(PLAYS) AS TOTAL_PLAYS --9495 plays
	    ,AVG(RATING) AS AVG_RATING -- 4.233 rating
		,MIN(MARKET_VALUE) AS LOWEST_MKT_VALUE -- 0 
		,MAX(ARTIST) AS HIGHEST_ALPHABETIC -- T.I.
		,ARTIST
		
		FROM ALBUMS
		
		GROUP BY
		ARTIST
		
		
	-- 3. AGGREGATE FUNCTIONS w/ LIMIT AND ORDER BY (TOP 5 ARTISTS)
	
	     SELECT
		 SUM(PLAYS) AS TOTAL_PLAYS --9495 plays
	    ,AVG(RATING) AS AVG_RATING -- 4.233 rating
		,MIN(MARKET_VALUE) AS LOWEST_MKT_VALUE -- 0 
		,MAX(ARTIST) AS HIGHEST_ALPHABETIC -- T.I.
		,ARTIST
		
		FROM ALBUMS
		
		GROUP BY
		ARTIST
		
		ORDER BY 1 DESC	
		
		LIMIT 5
		
	-- 4. FILTERING ON AN AGGREGATE FUNCTION

		-- INCORRECT APPROACH (FILTERING IN THE WHERE CLAUSE)
	
			SELECT
			 SUM(PLAYS) AS TOTAL_PLAYS
			,AVG(RATING) AS AVG_RATING
			,MIN(MARKET_VALUE) AS LOWEST_MKT_VALUE
			,MAX(ARTIST) AS HIGHEST_ALPHABETIC
			,ARTIST
			
			FROM ALBUMS
			
			WHERE SUM(PLAYS) >= 500
			
			GROUP BY
			ARTIST
		
		-- CORRECT APPROACH (FILTERING IN HAVING CLAUSE)
		
			SELECT
			 SUM(PLAYS) AS TOTAL_PLAYS --9495 plays
			,AVG(RATING) AS AVG_RATING -- 4.233 rating
			,MIN(MARKET_VALUE) AS LOWEST_MKT_VALUE -- 0 
			,MAX(ARTIST) AS HIGHEST_ALPHABETIC -- T.I.
			,ARTIST
			
			FROM ALBUMS
			
			GROUP BY
			ARTIST
			
			HAVING
			SUM(PLAYS) >= 500
		
	/*
	Key Takeaways
	1. AGGREGATE FUNCTIONS DO NOT GO IN THE GROUP BY STATEMENT
	2. ALIASES DO NOT GO IN THE GROUP BY STATEMENT (Eg. AS)
	3. YOU CANNOT FILTER ON AN AGGREGATE FUNCTION IN THE WHERE CLAUSE
	4. YOU CAN ONLY FILTER ON AGGREGATE FUNCTIONS IN HAVING
	5. COMBINE ORDER BY AND LIMIT TO CREATE RANKED LISTS
	*/ 








 

