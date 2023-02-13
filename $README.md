# SQL
The following files were added as part of a project to setup a PostgreSQL Server to perform analysis of the UK Gender Pay Gap filings. 

CSV files from https://gender-pay-gap.service.gov.uk/viewing/download:
UK Gender Pay Gap Data - 2017 to 2018.csv
UK Gender Pay Gap Data - 2018 to 2019.csv
UK Gender Pay Gap Data - 2019 to 2020.csv
UK Gender Pay Gap Data - 2020 to 2021.csv
UK Gender Pay Gap Data - 2021 to 2022.csv
UK Gender Pay Gap Data - 2022 to 2023.csv (as of Feb 4, 2023)

CSV files created from data found at the UK Office for National Statistics:
https://www.ons.gov.uk/methodology/classificationsandstandards/ukstandardindustrialclassificationofeconomicactivities/uksic2007
SICCodes.csv
SICSections.csv
SICDivisions.csv
SICGroups.csv
SICClasses.csv
SICSubclasses.csv
SICActivities.csv

These SQL files created the tables to contain the above data:
CREATE TABLE for gender_pay_gap.sql
CREATE TABLES for SIC.sql

This view (SQL) extracts SIC codes from the gender_pay_gap table, permitting proper joins to the SIC tables.
CREATE VIEW vw_gpg_sic_codes.sql

A simple lookup table, seven records, allowing sorting of employers by employersize:
CREATE TABLE for employersizes.sql
