--* ************************************************************************************************
--* Create the set of SIC code tables needed for the gender_pay_gap dataset
--* (see https://gender-pay-gap.service.gov.uk/viewing/download)
--* ************************************************************************************************


--* ************************************************************************************************
--* SICCodes
--* ************************************************************************************************
CREATE TABLE public.SICCodes
(
	SICCode varchar NOT NULL
	, SICDescription varchar NOT NULL
	, Level varchar
	, SICSection varchar NOT NULL
	, CONSTRAINT _pk_siccodes PRIMARY KEY ( SICCode )
)
TABLESPACE pg_default
;

CREATE INDEX idx_SICCodes_Level
	ON public.SICCodes USING btree
	( Level ASC NULLS LAST )
	TABLESPACE pg_default
;

CREATE INDEX idx_SICCodes_SICSection
	ON public.SICCodes USING btree
	( SICSection ASC NULLS LAST )
	TABLESPACE pg_default
;


--* ************************************************************************************************
--* SICSections
--* ************************************************************************************************
CREATE TABLE public.SICSections
(
	SICSection varchar NOT NULL
	, SectionDescription varchar NOT NULL
	, CONSTRAINT _pk_SICSections PRIMARY KEY ( SICSection )
)
TABLESPACE pg_default
;

--* ************************************************************************************************
--* SICDivisions
--* ************************************************************************************************
CREATE TABLE public.SICDivisions
(
	SICDivision varchar NOT NULL
	, DivisionDescription varchar NOT NULL
	, SICCode varchar NOT NULL
	, SICSection varchar NOT NULL
	, CONSTRAINT _pk_SICDivisions PRIMARY KEY ( SICDivision )
)
TABLESPACE pg_default
;

CREATE INDEX idx_SICDivisions_SICCode
	ON public.SICDivisions USING btree
	( SICCode ASC NULLS LAST )
	TABLESPACE pg_default
;

CREATE INDEX idx_SICDivisions_SICSection
	ON public.SICDivisions USING btree
	( SICSection ASC NULLS LAST )
	TABLESPACE pg_default
;

--* ************************************************************************************************
--* SICGroups
--* ************************************************************************************************
CREATE TABLE public.SICGroups
(
	SICGroup varchar NOT NULL
	, GroupDescription varchar NOT NULL
	, SICCode varchar NOT NULL
	, SICSection varchar NOT NULL
	, SICDivision varchar NOT NULL
	, CONSTRAINT _pk_SICGroups PRIMARY KEY ( SICGroup )
)
TABLESPACE pg_default
;

CREATE INDEX idx_SICGroups_SICCode
	ON public.SICGroups USING btree
	( SICCode ASC NULLS LAST )
	TABLESPACE pg_default
;

CREATE INDEX idx_SICGroups_SICSection
	ON public.SICGroups USING btree
	( SICSection ASC NULLS LAST )
	TABLESPACE pg_default
;

CREATE INDEX idx_SICGroups_SICDivision
	ON public.SICGroups USING btree
	( SICDivision ASC NULLS LAST )
	TABLESPACE pg_default
;

--* ************************************************************************************************
--* SICClasses
--* ************************************************************************************************
CREATE TABLE public.SICClasses
(
	SICClass varchar NOT NULL
	, ClassDescription varchar NOT NULL
	, SICCode varchar NOT NULL
	, SICSection varchar NOT NULL
	, SICDivision varchar NOT NULL
	, SICGroup varchar NOT NULL
	, CONSTRAINT _pk_SICClasses PRIMARY KEY ( SICClass )
)
TABLESPACE pg_default
;

CREATE INDEX idx_SICClasses_SICCode
	ON public.SICClasses USING btree
	( SICCode ASC NULLS LAST )
	TABLESPACE pg_default
;

CREATE INDEX idx_SICClasses_SICSection
	ON public.SICClasses USING btree
	( SICSection ASC NULLS LAST )
	TABLESPACE pg_default
;

CREATE INDEX idx_SICClasses_SICDivision
	ON public.SICClasses USING btree
	( SICDivision ASC NULLS LAST )
	TABLESPACE pg_default
;

CREATE INDEX idx_SICClasses_SICGroup
	ON public.SICClasses USING btree
	( SICGroup ASC NULLS LAST )
	TABLESPACE pg_default
;

--* ************************************************************************************************
--* SICSubclasses
--* ************************************************************************************************
CREATE TABLE public.SICSubclasses
(
	SICSubclass varchar NOT NULL
	, SubclassDescription varchar NOT NULL
	, SICCode varchar NOT NULL
	, SICSection varchar NOT NULL
	, SICDivision varchar NOT NULL
	, SICGroup varchar NOT NULL
	, SICClass varchar NOT NULL
	, CONSTRAINT _pk_SICSubclasses PRIMARY KEY ( SICSubclass )
)
TABLESPACE pg_default
;

CREATE INDEX idx_SICSubclasses_SICCode
	ON public.SICSubclasses USING btree
	( SICCode ASC NULLS LAST )
	TABLESPACE pg_default
;

CREATE INDEX idx_SICSubclasses_SICSection
	ON public.SICSubclasses USING btree
	( SICSection ASC NULLS LAST )
	TABLESPACE pg_default
;

CREATE INDEX idx_SICSubclasses_SICDivision
	ON public.SICSubclasses USING btree
	( SICDivision ASC NULLS LAST )
	TABLESPACE pg_default
;

CREATE INDEX idx_SICSubclasses_SICGroup
	ON public.SICSubclasses USING btree
	( SICGroup ASC NULLS LAST )
	TABLESPACE pg_default
;

CREATE INDEX idx_SICSubclasses_SICClass
	ON public.SICSubclasses USING btree
	( SICClass ASC NULLS LAST )
	TABLESPACE pg_default
;

--* ************************************************************************************************
--* SICActivities
--* ************************************************************************************************

--* This is required for the SICActivities table primary key
CREATE SEQUENCE IF NOT EXISTS 
			public._pk_sicactivities_sicactivityid_seq
	INCREMENT 1
	START 1
	MINVALUE 1
	MAXVALUE 2147483647
	CACHE 1
;

CREATE TABLE public.SICActivities
(
	SICActivityID integer NOT NULL 
		DEFAULT 
		nextval('_pk_sicactivities_sicactivityid_seq'::regclass)

	, SICCode varchar NOT NULL
	, SICActivity varchar NOT NULL
	, CONSTRAINT _pk_sicactivities PRIMARY KEY ( SICActivityID )
)
TABLESPACE pg_default
;

CREATE INDEX idx_SICActivities_SICCode
	ON public.SICActivities USING btree
	( SICCode ASC NULLS LAST )
	TABLESPACE pg_default
;
