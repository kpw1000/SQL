--* ************************************************************************************************
--* Create a view based on a recursive CTE to return individual SIC Codes from the gender_pay_gap
--* table.
--* ************************************************************************************************
CREATE VIEW vw_gpg_sic_codes AS
	WITH RECURSIVE "gpg_siccode_recurs" AS
		(
		SELECT 
			1 AS "counter"
			, x.gpgkey
			, x.employerid

			--* The recursive query will extract SIC codes from this field.
			, x.siccode_array

			--* The siccodes field is delimited by a command and a line-feed. The inner query
			--* below creates an array using the line-feed. Here we remove the comma and pad 
			--* each sic code to five characters. In the Office for National Statistics, all 
			--* SIC codes are five digits.
			, RIGHT( '00000' || REPLACE( x.siccode_array[1], ',', '' ), 5 ) AS "siccode"

			--* In the recursion query, we will limit recursion to the number of elements
			--* in the array. So we need a count of array elements.
			, ARRAY_LENGTH( x.siccode_array, 1 ) AS "siccode_count"

		FROM (
				SELECT
					gpgkey
					, employerid
					, STRING_TO_ARRAY( siccodes, CHR(10) ) AS "siccode_array"
				FROM gender_pay_gap

				--* ****************************************************
				--* Filter for certain keys during testing. These keys
				--* were chosen as they have 0, 1, 2, or 4 SIC Codes.
				--* ****************************************************
				-- WHERE
				--	g.employerid IN ( 
				--		'18159', '19070', '16958', '771', '773', 
				--		'687', '14495', '19421', '18232', '77', 
				--		'771', '650', '19795', '840', '880',
				--		'904', '19574', '20576', '20579', '496'
				--	)

				-- WHERE gpgkey IN ( 13, 14, 26, 27, 35, 40, 76, 84, 101, 171 )
				--* ****************************************************
				--* 
				--* ****************************************************

			) AS x

		WHERE 
			ARRAY_LENGTH( x.siccode_array, 1 ) >= 1

			--* SIC Codes of '0' and '1' are not legitimate SIC Codes.
			AND REPLACE( x.siccode_array[1], ',', '' ) NOT IN ( '0', '1' )

		UNION ALL SELECT
			y.counter + 1 AS "counter"
			, y.gpgkey
			, y.employerid
			, y.siccode_array
			, RIGHT( '00000' || REPLACE( y.siccode_array[y.counter + 1], ',', '' ), 5 ) AS "siccode"
			, y.siccode_count

		FROM gpg_siccode_recurs y

		WHERE 
			ARRAY_LENGTH( y.siccode_array, 1 ) >= y.counter + 1

			--* SIC Codes of '0' and '1' are not legitimate SIC Codes.
			AND REPLACE( y.siccode_array[y.counter + 1], ',', '' ) NOT IN ( '0', '1' )
		)

	SELECT 
		gpgkey
		, counter
		, employerid
		, siccode
		, LEFT( siccode, 2 ) AS sicdivision
		, LEFT( siccode, 3 ) AS sicgroup
		, LEFT( siccode, 4 ) AS sicclass
		, siccode_count
	FROM gpg_siccode_recurs

;
