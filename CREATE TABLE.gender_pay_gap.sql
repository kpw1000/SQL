--* ************************************************************************************************
--* Create the gender_pay_gap table (see https://gender-pay-gap.service.gov.uk/viewing/download)
--* and beneficial indices.
--* ************************************************************************************************

--* Required for the primary key.
CREATE SEQUENCE public._pk_gender_pay_gap_gpg_seq
	INCREMENT 1
	START 1
	MINVALUE 1
	MAXVALUE 2147483647
	CACHE 1
;

--* ************************************************************************************************
CREATE TABLE gender_pay_gap(

	--* This is not part of the original datasets. However, without it, we have no unique key for
	--* the table spanning multiple years.
	GPGKey integer NOT NULL 
		DEFAULT nextval('_pk_gender_pay_gap_gpg_seq'::regclass)

	,EmployerName varchar( 256 ) 
	,EmployerId varchar( 32 )
	,Address varchar( 256 ) 
	,PostCode varchar( 128 ) 
	,CompanyNumber varchar( 32 ) 
	,SicCodes varchar( 256 )

	--* Keep the next set of fields as varchar for the import; change empty values to NULLs
	--* via UPDATE after import; ALTER TABLE changing to numeric.
	,DiffMeanHourlyPercent varchar
	,DiffMedianHourlyPercent varchar
	,DiffMeanBonusPercent varchar
	,DiffMedianBonusPercent varchar
	,MaleBonusPercent varchar
	,FemaleBonusPercent varchar
	,MaleLowerQuartile varchar
	,FemaleLowerQuartile varchar
	,MaleLowerMiddleQuartile varchar
	,FemaleLowerMiddleQuartile varchar
	,MaleUpperMiddleQuartile varchar
	,FemaleUpperMiddleQuartile varchar
	,MaleTopQuartile varchar
	,FemaleTopQuartile varchar

	--* This is a URL
	,CompanyLinkToGPGInfo varchar( 512 ) 
	,ResponsiblePerson varchar( 256 ) 
	,EmployerSize varchar( 64 ) 
	,CurrentName varchar( 256 ) 
	,SubmittedAfterTheDeadline bool 

	--* While all of the UK is within one timezone, I'm unsure
	--* whether or not the submitting organizations are.
	,DueDate timestamp 
	,DateSubmitted timestamp
	,CONSTRAINT _pk_gender_pay_gap PRIMARY KEY ( gpgkey )  
	)

TABLESPACE pg_default ;

--* ************************************************************************************************
CREATE INDEX IF NOT EXISTS idx_EmployerID
	ON public.gender_pay_gap USING btree
	( EmployerID ASC NULLS LAST )
	TABLESPACE pg_default
;

--* ************************************************************************************************
CREATE INDEX IF NOT EXISTS idx_EmployerName
	ON public.gender_pay_gap USING btree
	( EmployerName ASC NULLS LAST )
	TABLESPACE pg_default
;

--* ************************************************************************************************
CREATE INDEX IF NOT EXISTS idx_CompanyNumber
	ON public.gender_pay_gap USING btree
	( CompanyNumber ASC NULLS LAST )
	TABLESPACE pg_default
;
