--* ************************************************************************************************
--* Create a lookup table of employersizes so that we can sort by the employersize field of the
--* gender_pay_gap table.
--* ************************************************************************************************

CREATE TABLE IF NOT EXISTS public.employersizes
(
    employersize character varying COLLATE pg_catalog."default" NOT NULL,
    employersizesequence integer,
    CONSTRAINT employersizes_pkey PRIMARY KEY (employersize)
)
TABLESPACE pg_default;

INSERT INTO employersizes( employersize, employersizesequence ) VALUES ( '5000 to 19,999', 5 ) ;
INSERT INTO employersizes( employersize, employersizesequence ) VALUES ( '500 to 999', 3 ) ;
INSERT INTO employersizes( employersize, employersizesequence ) VALUES ( '20,000 or more', 6 ) ;
INSERT INTO employersizes( employersize, employersizesequence ) VALUES ( 'Not Provided', 7 ) ;
INSERT INTO employersizes( employersize, employersizesequence ) VALUES ( '1000 to 4999', 4 ) ;
INSERT INTO employersizes( employersize, employersizesequence ) VALUES ( 'Less than 250', 1 ) ;
INSERT INTO employersizes( employersize, employersizesequence ) VALUES ( '250 to 499', 2 ) ;
