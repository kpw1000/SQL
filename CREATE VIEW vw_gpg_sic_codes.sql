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
			--* In the Office for National Statistics, all SIC codes are five digits
			, RIGHT( '00000' || REPLACE( x.siccode_array[1], ',', '' ), 5 ) AS "siccode"
			, ARRAY_LENGTH( x.siccode_array, 1 ) AS "siccode_count"
		FROM (
				SELECT
					gpgkey
					, employerid
					, siccodes
					, STRING_TO_ARRAY( siccodes, CHR(10) ) AS "siccode_array"
				FROM gender_pay_gap

				--* ****************************************************
				--* Filter for certain keys during testing. These keys
				--* were chosen as they have 0, 1, 2, or 4 SIC Codes.
				--* ****************************************************
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
			z.counter + 1 AS "counter"
			, y.gpgkey
			, y.employerid
			--* In the Office for National Statistics, all SIC codes are five digits
			, RIGHT( '00000' || REPLACE( y.siccode_array[z.counter + 1], ',', '' ), 5 ) AS "siccode"
			, ARRAY_LENGTH( y.siccode_array, 1 ) AS "siccode_count"
		FROM (
				SELECT
					gpgkey
					, employerid
					, siccodes
					, STRING_TO_ARRAY( siccodes, CHR(10) ) AS "siccode_array"
				FROM gender_pay_gap
			) AS y
			INNER JOIN gpg_siccode_recurs z ON y.gpgkey = z.gpgkey

		WHERE 
			ARRAY_LENGTH( y.siccode_array, 1 ) >= z.counter + 1

			--* SIC Codes of '0' and '1' are not legitimate SIC Codes.
			AND REPLACE( y.siccode_array[z.counter + 1], ',', '' ) NOT IN ( '0', '1' )
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
