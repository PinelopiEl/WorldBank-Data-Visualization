/*|===================================================================|*/
/*|                        INITIALISATION							  |*/
/*|___________________________________________________________________|*/
/*| DROP indata TABLES(IF EXISTS) AND CREATE THEM AGAIN               |*/
/*|===================================================================|*/
DROP DATABASE IF EXISTS wdi_extract;
CREATE DATABASE wdi_extract;
USE `wdi_extract`;

CREATE TABLE `indata_countries` (
  `Code` varchar(10) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Region` varchar(255) DEFAULT NULL,
  `IncomeGroup` varchar(45) DEFAULT NULL,
  `SpecialNotes` varchar(512) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `indata_data` (
  `CountryName` varchar(255) DEFAULT NULL,
  `CountryCode` varchar(10) DEFAULT NULL,
  `IndicatorName` varchar(255) DEFAULT NULL,
  `IndicatorCode` varchar(255) DEFAULT NULL,
  `1960` double DEFAULT NULL,
  `1961` double DEFAULT NULL,
  `1962` double DEFAULT NULL,
  `1963` double DEFAULT NULL,
  `1964` double DEFAULT NULL,
  `1965` double DEFAULT NULL,
  `1966` double DEFAULT NULL,
  `1967` double DEFAULT NULL,
  `1968` double DEFAULT NULL,
  `1969` double DEFAULT NULL,
  `1970` double DEFAULT NULL,
  `1971` double DEFAULT NULL,
  `1972` double DEFAULT NULL,
  `1973` double DEFAULT NULL,
  `1974` double DEFAULT NULL,
  `1975` double DEFAULT NULL,
  `1976` double DEFAULT NULL,
  `1977` double DEFAULT NULL,
  `1978` double DEFAULT NULL,
  `1979` double DEFAULT NULL,
  `1980` double DEFAULT NULL,
  `1981` double DEFAULT NULL,
  `1982` double DEFAULT NULL,
  `1983` double DEFAULT NULL,
  `1984` double DEFAULT NULL,
  `1985` double DEFAULT NULL,
  `1986` double DEFAULT NULL,
  `1987` double DEFAULT NULL,
  `1988` double DEFAULT NULL,
  `1989` double DEFAULT NULL,
  `1990` double DEFAULT NULL,
  `1991` double DEFAULT NULL,
  `1992` double DEFAULT NULL,
  `1993` double DEFAULT NULL,
  `1994` double DEFAULT NULL,
  `1995` double DEFAULT NULL,
  `1996` double DEFAULT NULL,
  `1997` double DEFAULT NULL,
  `1998` double DEFAULT NULL,
  `1999` double DEFAULT NULL,
  `2000` double DEFAULT NULL,
  `2001` double DEFAULT NULL,
  `2002` double DEFAULT NULL,
  `2003` double DEFAULT NULL,
  `2004` double DEFAULT NULL,
  `2005` double DEFAULT NULL,
  `2006` double DEFAULT NULL,
  `2007` double DEFAULT NULL,
  `2008` double DEFAULT NULL,
  `2009` double DEFAULT NULL,
  `2010` double DEFAULT NULL,
  `2011` double DEFAULT NULL,
  `2012` double DEFAULT NULL,
  `2013` double DEFAULT NULL,
  `2014` double DEFAULT NULL,
  `2015` double DEFAULT NULL,
  `2016` double DEFAULT NULL,
  `2017` double DEFAULT NULL,
  `2018` double DEFAULT NULL,
  `2019` double DEFAULT NULL,
  `2020` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*|===================================================================|*/
/*|                      ETL TOOL - EXTRACT				  			  |*/
/*|___________________________________________________________________|*/
/*| EXTRACT DATA FROM ITS ORIGINAL SOURCE [TEXT(Tab Delimited) Files] |*/
/*|===================================================================|*/
/* 1. AUSTRIA */
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/AUT_Data.txt'
INTO TABLE indata_data
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 4 LINES
(`CountryName`,`CountryCode`,`IndicatorName`,`IndicatorCode`,`1960`,`1961`,`1962`,`1963`,`1964`,`1965`,`1966`,`1967`,`1968`,`1969`,`1970`,`1971`,`1972`,`1973`,`1974`,`1975`,`1976`,`1977`,`1978`,`1979`,`1980`,`1981`,`1982`,`1983`,`1984`,`1985`,`1986`,`1987`,`1988`,`1989`,`1990`,`1991`,`1992`,`1993`,`1994`,`1995`,`1996`,`1997`,`1998`,`1999`,`2000`,`2001`,`2002`,`2003`,`2004`,`2005`,`2006`,`2007`,`2008`,`2009`,`2010`,`2011`,`2012`,`2013`,`2014`,`2015`,`2016`,`2017`,`2018`,`2019`,`2020`);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/AUT_Country.txt' 
INTO TABLE indata_countries
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(`Code`,`Region`,`IncomeGroup`,`SpecialNotes`,`Name`);

/* 2. BELGIUM */
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/BEL_Data.txt' 
INTO TABLE indata_data
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 4 LINES
(`CountryName`,`CountryCode`,`IndicatorName`,`IndicatorCode`,`1960`,`1961`,`1962`,`1963`,`1964`,`1965`,`1966`,`1967`,`1968`,`1969`,`1970`,`1971`,`1972`,`1973`,`1974`,`1975`,`1976`,`1977`,`1978`,`1979`,`1980`,`1981`,`1982`,`1983`,`1984`,`1985`,`1986`,`1987`,`1988`,`1989`,`1990`,`1991`,`1992`,`1993`,`1994`,`1995`,`1996`,`1997`,`1998`,`1999`,`2000`,`2001`,`2002`,`2003`,`2004`,`2005`,`2006`,`2007`,`2008`,`2009`,`2010`,`2011`,`2012`,`2013`,`2014`,`2015`,`2016`,`2017`,`2018`,`2019`,`2020`);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/BEL_Country.txt' 
INTO TABLE indata_countries
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(`Code`,`Region`,`IncomeGroup`,`SpecialNotes`,`Name`);

/* 3. CYPRUS */
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CYP_Data.txt' 
INTO TABLE indata_data
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 4 LINES
(`CountryName`,`CountryCode`,`IndicatorName`,`IndicatorCode`,`1960`,`1961`,`1962`,`1963`,`1964`,`1965`,`1966`,`1967`,`1968`,`1969`,`1970`,`1971`,`1972`,`1973`,`1974`,`1975`,`1976`,`1977`,`1978`,`1979`,`1980`,`1981`,`1982`,`1983`,`1984`,`1985`,`1986`,`1987`,`1988`,`1989`,`1990`,`1991`,`1992`,`1993`,`1994`,`1995`,`1996`,`1997`,`1998`,`1999`,`2000`,`2001`,`2002`,`2003`,`2004`,`2005`,`2006`,`2007`,`2008`,`2009`,`2010`,`2011`,`2012`,`2013`,`2014`,`2015`,`2016`,`2017`,`2018`,`2019`,`2020`);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CYP_Country.txt' 
INTO TABLE indata_countries
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(`Code`,`Region`,`IncomeGroup`,`SpecialNotes`,`Name`);

/* 4. Germany */
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/DEU_Data.txt' 
INTO TABLE indata_data
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 4 LINES
(`CountryName`,`CountryCode`,`IndicatorName`,`IndicatorCode`,`1960`,`1961`,`1962`,`1963`,`1964`,`1965`,`1966`,`1967`,`1968`,`1969`,`1970`,`1971`,`1972`,`1973`,`1974`,`1975`,`1976`,`1977`,`1978`,`1979`,`1980`,`1981`,`1982`,`1983`,`1984`,`1985`,`1986`,`1987`,`1988`,`1989`,`1990`,`1991`,`1992`,`1993`,`1994`,`1995`,`1996`,`1997`,`1998`,`1999`,`2000`,`2001`,`2002`,`2003`,`2004`,`2005`,`2006`,`2007`,`2008`,`2009`,`2010`,`2011`,`2012`,`2013`,`2014`,`2015`,`2016`,`2017`,`2018`,`2019`,`2020`);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/DEU_Country.txt' 
INTO TABLE indata_countries
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(`Code`,`Region`,`IncomeGroup`,`SpecialNotes`,`Name`);

/* 5. DENMARK */
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/DNK_Data.txt' 
INTO TABLE indata_data
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 4 LINES
(`CountryName`,`CountryCode`,`IndicatorName`,`IndicatorCode`,`1960`,`1961`,`1962`,`1963`,`1964`,`1965`,`1966`,`1967`,`1968`,`1969`,`1970`,`1971`,`1972`,`1973`,`1974`,`1975`,`1976`,`1977`,`1978`,`1979`,`1980`,`1981`,`1982`,`1983`,`1984`,`1985`,`1986`,`1987`,`1988`,`1989`,`1990`,`1991`,`1992`,`1993`,`1994`,`1995`,`1996`,`1997`,`1998`,`1999`,`2000`,`2001`,`2002`,`2003`,`2004`,`2005`,`2006`,`2007`,`2008`,`2009`,`2010`,`2011`,`2012`,`2013`,`2014`,`2015`,`2016`,`2017`,`2018`,`2019`,`2020`);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/DNK_Country.txt' 
INTO TABLE indata_countries
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(`Code`,`Region`,`IncomeGroup`,`SpecialNotes`,`Name`);

/* 6. SPAIN */
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ESP_Data.txt' 
INTO TABLE indata_data
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 4 LINES
(`CountryName`,`CountryCode`,`IndicatorName`,`IndicatorCode`,`1960`,`1961`,`1962`,`1963`,`1964`,`1965`,`1966`,`1967`,`1968`,`1969`,`1970`,`1971`,`1972`,`1973`,`1974`,`1975`,`1976`,`1977`,`1978`,`1979`,`1980`,`1981`,`1982`,`1983`,`1984`,`1985`,`1986`,`1987`,`1988`,`1989`,`1990`,`1991`,`1992`,`1993`,`1994`,`1995`,`1996`,`1997`,`1998`,`1999`,`2000`,`2001`,`2002`,`2003`,`2004`,`2005`,`2006`,`2007`,`2008`,`2009`,`2010`,`2011`,`2012`,`2013`,`2014`,`2015`,`2016`,`2017`,`2018`,`2019`,`2020`);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ESP_Country.txt' 
INTO TABLE indata_countries
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(`Code`,`Region`,`IncomeGroup`,`SpecialNotes`,`Name`);

/* 7. FINLAND */
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/FIN_Data.txt' 
INTO TABLE indata_data
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 4 LINES
(`CountryName`,`CountryCode`,`IndicatorName`,`IndicatorCode`,`1960`,`1961`,`1962`,`1963`,`1964`,`1965`,`1966`,`1967`,`1968`,`1969`,`1970`,`1971`,`1972`,`1973`,`1974`,`1975`,`1976`,`1977`,`1978`,`1979`,`1980`,`1981`,`1982`,`1983`,`1984`,`1985`,`1986`,`1987`,`1988`,`1989`,`1990`,`1991`,`1992`,`1993`,`1994`,`1995`,`1996`,`1997`,`1998`,`1999`,`2000`,`2001`,`2002`,`2003`,`2004`,`2005`,`2006`,`2007`,`2008`,`2009`,`2010`,`2011`,`2012`,`2013`,`2014`,`2015`,`2016`,`2017`,`2018`,`2019`,`2020`);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/FIN_Country.txt' 
INTO TABLE indata_countries
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(`Code`,`Region`,`IncomeGroup`,`SpecialNotes`,`Name`);

/* 8. FRANCE */
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/FRA_Data.txt' 
INTO TABLE indata_data
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 4 LINES
(`CountryName`,`CountryCode`,`IndicatorName`,`IndicatorCode`,`1960`,`1961`,`1962`,`1963`,`1964`,`1965`,`1966`,`1967`,`1968`,`1969`,`1970`,`1971`,`1972`,`1973`,`1974`,`1975`,`1976`,`1977`,`1978`,`1979`,`1980`,`1981`,`1982`,`1983`,`1984`,`1985`,`1986`,`1987`,`1988`,`1989`,`1990`,`1991`,`1992`,`1993`,`1994`,`1995`,`1996`,`1997`,`1998`,`1999`,`2000`,`2001`,`2002`,`2003`,`2004`,`2005`,`2006`,`2007`,`2008`,`2009`,`2010`,`2011`,`2012`,`2013`,`2014`,`2015`,`2016`,`2017`,`2018`,`2019`,`2020`);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/FRA_Country.txt' 
INTO TABLE indata_countries
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(`Code`,`Region`,`IncomeGroup`,`SpecialNotes`,`Name`);

/* 9. GREECE */
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/GRC_Data.txt' 
INTO TABLE indata_data
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 4 LINES
(`CountryName`,`CountryCode`,`IndicatorName`,`IndicatorCode`,`1960`,`1961`,`1962`,`1963`,`1964`,`1965`,`1966`,`1967`,`1968`,`1969`,`1970`,`1971`,`1972`,`1973`,`1974`,`1975`,`1976`,`1977`,`1978`,`1979`,`1980`,`1981`,`1982`,`1983`,`1984`,`1985`,`1986`,`1987`,`1988`,`1989`,`1990`,`1991`,`1992`,`1993`,`1994`,`1995`,`1996`,`1997`,`1998`,`1999`,`2000`,`2001`,`2002`,`2003`,`2004`,`2005`,`2006`,`2007`,`2008`,`2009`,`2010`,`2011`,`2012`,`2013`,`2014`,`2015`,`2016`,`2017`,`2018`,`2019`,`2020`);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/GRC_Country.txt' 
INTO TABLE indata_countries
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(`Code`,`Region`,`IncomeGroup`,`SpecialNotes`,`Name`);

/* 10. HUNGARY */
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/HUN_Data.txt' 
INTO TABLE indata_data
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 4 LINES
(`CountryName`,`CountryCode`,`IndicatorName`,`IndicatorCode`,`1960`,`1961`,`1962`,`1963`,`1964`,`1965`,`1966`,`1967`,`1968`,`1969`,`1970`,`1971`,`1972`,`1973`,`1974`,`1975`,`1976`,`1977`,`1978`,`1979`,`1980`,`1981`,`1982`,`1983`,`1984`,`1985`,`1986`,`1987`,`1988`,`1989`,`1990`,`1991`,`1992`,`1993`,`1994`,`1995`,`1996`,`1997`,`1998`,`1999`,`2000`,`2001`,`2002`,`2003`,`2004`,`2005`,`2006`,`2007`,`2008`,`2009`,`2010`,`2011`,`2012`,`2013`,`2014`,`2015`,`2016`,`2017`,`2018`,`2019`,`2020`);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/HUN_Country.txt' 
INTO TABLE indata_countries
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(`Code`,`Region`,`IncomeGroup`,`SpecialNotes`,`Name`);

/* 11. ILRLAND */
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/IRL_Data.txt' 
INTO TABLE indata_data
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 4 LINES
(`CountryName`,`CountryCode`,`IndicatorName`,`IndicatorCode`,`1960`,`1961`,`1962`,`1963`,`1964`,`1965`,`1966`,`1967`,`1968`,`1969`,`1970`,`1971`,`1972`,`1973`,`1974`,`1975`,`1976`,`1977`,`1978`,`1979`,`1980`,`1981`,`1982`,`1983`,`1984`,`1985`,`1986`,`1987`,`1988`,`1989`,`1990`,`1991`,`1992`,`1993`,`1994`,`1995`,`1996`,`1997`,`1998`,`1999`,`2000`,`2001`,`2002`,`2003`,`2004`,`2005`,`2006`,`2007`,`2008`,`2009`,`2010`,`2011`,`2012`,`2013`,`2014`,`2015`,`2016`,`2017`,`2018`,`2019`,`2020`);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/IRL_Country.txt' 
INTO TABLE indata_countries
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(`Code`,`Region`,`IncomeGroup`,`SpecialNotes`,`Name`);

/* 12. ITALY */
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ITA_Data.txt' 
INTO TABLE indata_data
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 4 LINES
(`CountryName`,`CountryCode`,`IndicatorName`,`IndicatorCode`,`1960`,`1961`,`1962`,`1963`,`1964`,`1965`,`1966`,`1967`,`1968`,`1969`,`1970`,`1971`,`1972`,`1973`,`1974`,`1975`,`1976`,`1977`,`1978`,`1979`,`1980`,`1981`,`1982`,`1983`,`1984`,`1985`,`1986`,`1987`,`1988`,`1989`,`1990`,`1991`,`1992`,`1993`,`1994`,`1995`,`1996`,`1997`,`1998`,`1999`,`2000`,`2001`,`2002`,`2003`,`2004`,`2005`,`2006`,`2007`,`2008`,`2009`,`2010`,`2011`,`2012`,`2013`,`2014`,`2015`,`2016`,`2017`,`2018`,`2019`,`2020`);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ITA_Country.txt' 
INTO TABLE indata_countries
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(`Code`,`Region`,`IncomeGroup`,`SpecialNotes`,`Name`);

/* 13. LIECHTENSTEIN */
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/LIE_Data.txt' 
INTO TABLE indata_data
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 4 LINES
(`CountryName`,`CountryCode`,`IndicatorName`,`IndicatorCode`,`1960`,`1961`,`1962`,`1963`,`1964`,`1965`,`1966`,`1967`,`1968`,`1969`,`1970`,`1971`,`1972`,`1973`,`1974`,`1975`,`1976`,`1977`,`1978`,`1979`,`1980`,`1981`,`1982`,`1983`,`1984`,`1985`,`1986`,`1987`,`1988`,`1989`,`1990`,`1991`,`1992`,`1993`,`1994`,`1995`,`1996`,`1997`,`1998`,`1999`,`2000`,`2001`,`2002`,`2003`,`2004`,`2005`,`2006`,`2007`,`2008`,`2009`,`2010`,`2011`,`2012`,`2013`,`2014`,`2015`,`2016`,`2017`,`2018`,`2019`,`2020`);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/LIE_Country.txt' 
INTO TABLE indata_countries
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(`Code`,`Region`,`IncomeGroup`,`SpecialNotes`,`Name`);

/* 14. LUXEMBURG */
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/LUX_Data.txt' 
INTO TABLE indata_data
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 4 LINES
(`CountryName`,`CountryCode`,`IndicatorName`,`IndicatorCode`,`1960`,`1961`,`1962`,`1963`,`1964`,`1965`,`1966`,`1967`,`1968`,`1969`,`1970`,`1971`,`1972`,`1973`,`1974`,`1975`,`1976`,`1977`,`1978`,`1979`,`1980`,`1981`,`1982`,`1983`,`1984`,`1985`,`1986`,`1987`,`1988`,`1989`,`1990`,`1991`,`1992`,`1993`,`1994`,`1995`,`1996`,`1997`,`1998`,`1999`,`2000`,`2001`,`2002`,`2003`,`2004`,`2005`,`2006`,`2007`,`2008`,`2009`,`2010`,`2011`,`2012`,`2013`,`2014`,`2015`,`2016`,`2017`,`2018`,`2019`,`2020`);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/LUX_Country.txt' 
INTO TABLE indata_countries
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(`Code`,`Region`,`IncomeGroup`,`SpecialNotes`,`Name`);

/* 15. NETHERLAND */
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/NLD_Data.txt' 
INTO TABLE indata_data
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 4 LINES
(`CountryName`,`CountryCode`,`IndicatorName`,`IndicatorCode`,`1960`,`1961`,`1962`,`1963`,`1964`,`1965`,`1966`,`1967`,`1968`,`1969`,`1970`,`1971`,`1972`,`1973`,`1974`,`1975`,`1976`,`1977`,`1978`,`1979`,`1980`,`1981`,`1982`,`1983`,`1984`,`1985`,`1986`,`1987`,`1988`,`1989`,`1990`,`1991`,`1992`,`1993`,`1994`,`1995`,`1996`,`1997`,`1998`,`1999`,`2000`,`2001`,`2002`,`2003`,`2004`,`2005`,`2006`,`2007`,`2008`,`2009`,`2010`,`2011`,`2012`,`2013`,`2014`,`2015`,`2016`,`2017`,`2018`,`2019`,`2020`);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/NLD_Country.txt' 
INTO TABLE indata_countries
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(`Code`,`Region`,`IncomeGroup`,`SpecialNotes`,`Name`);

/* 16. NORWAY */
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/NOR_Data.txt' 
INTO TABLE indata_data
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 4 LINES
(`CountryName`,`CountryCode`,`IndicatorName`,`IndicatorCode`,`1960`,`1961`,`1962`,`1963`,`1964`,`1965`,`1966`,`1967`,`1968`,`1969`,`1970`,`1971`,`1972`,`1973`,`1974`,`1975`,`1976`,`1977`,`1978`,`1979`,`1980`,`1981`,`1982`,`1983`,`1984`,`1985`,`1986`,`1987`,`1988`,`1989`,`1990`,`1991`,`1992`,`1993`,`1994`,`1995`,`1996`,`1997`,`1998`,`1999`,`2000`,`2001`,`2002`,`2003`,`2004`,`2005`,`2006`,`2007`,`2008`,`2009`,`2010`,`2011`,`2012`,`2013`,`2014`,`2015`,`2016`,`2017`,`2018`,`2019`,`2020`);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/NOR_Country.txt' 
INTO TABLE indata_countries
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(`Code`,`Region`,`IncomeGroup`,`SpecialNotes`,`Name`);

/* 17. POLAND */
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/POL_Data.txt' 
INTO TABLE indata_data
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 4 LINES
(`CountryName`,`CountryCode`,`IndicatorName`,`IndicatorCode`,`1960`,`1961`,`1962`,`1963`,`1964`,`1965`,`1966`,`1967`,`1968`,`1969`,`1970`,`1971`,`1972`,`1973`,`1974`,`1975`,`1976`,`1977`,`1978`,`1979`,`1980`,`1981`,`1982`,`1983`,`1984`,`1985`,`1986`,`1987`,`1988`,`1989`,`1990`,`1991`,`1992`,`1993`,`1994`,`1995`,`1996`,`1997`,`1998`,`1999`,`2000`,`2001`,`2002`,`2003`,`2004`,`2005`,`2006`,`2007`,`2008`,`2009`,`2010`,`2011`,`2012`,`2013`,`2014`,`2015`,`2016`,`2017`,`2018`,`2019`,`2020`);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/POL_Country.txt' 
INTO TABLE indata_countries
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(`Code`,`Region`,`IncomeGroup`,`SpecialNotes`,`Name`);

/* 18. PORTUGAL */
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/PRT_Data.txt' 
INTO TABLE indata_data
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 4 LINES
(`CountryName`,`CountryCode`,`IndicatorName`,`IndicatorCode`,`1960`,`1961`,`1962`,`1963`,`1964`,`1965`,`1966`,`1967`,`1968`,`1969`,`1970`,`1971`,`1972`,`1973`,`1974`,`1975`,`1976`,`1977`,`1978`,`1979`,`1980`,`1981`,`1982`,`1983`,`1984`,`1985`,`1986`,`1987`,`1988`,`1989`,`1990`,`1991`,`1992`,`1993`,`1994`,`1995`,`1996`,`1997`,`1998`,`1999`,`2000`,`2001`,`2002`,`2003`,`2004`,`2005`,`2006`,`2007`,`2008`,`2009`,`2010`,`2011`,`2012`,`2013`,`2014`,`2015`,`2016`,`2017`,`2018`,`2019`,`2020`);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/PRT_Country.txt' 
INTO TABLE indata_countries
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(`Code`,`Region`,`IncomeGroup`,`SpecialNotes`,`Name`);

/* 19. ROMANIA */
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ROU_Data.txt' 
INTO TABLE indata_data
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 4 LINES
(`CountryName`,`CountryCode`,`IndicatorName`,`IndicatorCode`,`1960`,`1961`,`1962`,`1963`,`1964`,`1965`,`1966`,`1967`,`1968`,`1969`,`1970`,`1971`,`1972`,`1973`,`1974`,`1975`,`1976`,`1977`,`1978`,`1979`,`1980`,`1981`,`1982`,`1983`,`1984`,`1985`,`1986`,`1987`,`1988`,`1989`,`1990`,`1991`,`1992`,`1993`,`1994`,`1995`,`1996`,`1997`,`1998`,`1999`,`2000`,`2001`,`2002`,`2003`,`2004`,`2005`,`2006`,`2007`,`2008`,`2009`,`2010`,`2011`,`2012`,`2013`,`2014`,`2015`,`2016`,`2017`,`2018`,`2019`,`2020`);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ROU_Country.txt' 
INTO TABLE indata_countries
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(`Code`,`Region`,`IncomeGroup`,`SpecialNotes`,`Name`);

/* 20. SWEDEN */
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/SWE_Data.txt' 
INTO TABLE indata_data
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 4 LINES
(`CountryName`,`CountryCode`,`IndicatorName`,`IndicatorCode`,`1960`,`1961`,`1962`,`1963`,`1964`,`1965`,`1966`,`1967`,`1968`,`1969`,`1970`,`1971`,`1972`,`1973`,`1974`,`1975`,`1976`,`1977`,`1978`,`1979`,`1980`,`1981`,`1982`,`1983`,`1984`,`1985`,`1986`,`1987`,`1988`,`1989`,`1990`,`1991`,`1992`,`1993`,`1994`,`1995`,`1996`,`1997`,`1998`,`1999`,`2000`,`2001`,`2002`,`2003`,`2004`,`2005`,`2006`,`2007`,`2008`,`2009`,`2010`,`2011`,`2012`,`2013`,`2014`,`2015`,`2016`,`2017`,`2018`,`2019`,`2020`);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/SWE_Country.txt' 
INTO TABLE indata_countries
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(`Code`,`Region`,`IncomeGroup`,`SpecialNotes`,`Name`);
/*21. BELARUS*/
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/BLR_Data.txt' 
INTO TABLE indata_data
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 4 LINES
(`CountryName`,`CountryCode`,`IndicatorName`,`IndicatorCode`,`1960`,`1961`,`1962`,`1963`,`1964`,`1965`,`1966`,`1967`,`1968`,`1969`,`1970`,`1971`,`1972`,`1973`,`1974`,`1975`,`1976`,`1977`,`1978`,`1979`,`1980`,`1981`,`1982`,`1983`,`1984`,`1985`,`1986`,`1987`,`1988`,`1989`,`1990`,`1991`,`1992`,`1993`,`1994`,`1995`,`1996`,`1997`,`1998`,`1999`,`2000`,`2001`,`2002`,`2003`,`2004`,`2005`,`2006`,`2007`,`2008`,`2009`,`2010`,`2011`,`2012`,`2013`,`2014`,`2015`,`2016`,`2017`,`2018`,`2019`,`2020`);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/BLR_Country.txt' 
INTO TABLE indata_countries
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(`Code`,`Region`,`IncomeGroup`,`SpecialNotes`,`Name`);

/*22.BULGARIA*/
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/BGR_Data.txt'
INTO TABLE indata_data
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 4 LINES
(`CountryName`,`CountryCode`,`IndicatorName`,`IndicatorCode`,`1960`,`1961`,`1962`,`1963`,`1964`,`1965`,`1966`,`1967`,`1968`,`1969`,`1970`,`1971`,`1972`,`1973`,`1974`,`1975`,`1976`,`1977`,`1978`,`1979`,`1980`,`1981`,`1982`,`1983`,`1984`,`1985`,`1986`,`1987`,`1988`,`1989`,`1990`,`1991`,`1992`,`1993`,`1994`,`1995`,`1996`,`1997`,`1998`,`1999`,`2000`,`2001`,`2002`,`2003`,`2004`,`2005`,`2006`,`2007`,`2008`,`2009`,`2010`,`2011`,`2012`,`2013`,`2014`,`2015`,`2016`,`2017`,`2018`,`2019`,`2020`);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/BGR_Country.txt' 
INTO TABLE indata_countries
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(`Code`,`Region`,`IncomeGroup`,`SpecialNotes`,`Name`);

/*23.MONACO*/
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/MCO_Data.txt'
INTO TABLE indata_data
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 4 LINES
(`CountryName`,`CountryCode`,`IndicatorName`,`IndicatorCode`,`1960`,`1961`,`1962`,`1963`,`1964`,`1965`,`1966`,`1967`,`1968`,`1969`,`1970`,`1971`,`1972`,`1973`,`1974`,`1975`,`1976`,`1977`,`1978`,`1979`,`1980`,`1981`,`1982`,`1983`,`1984`,`1985`,`1986`,`1987`,`1988`,`1989`,`1990`,`1991`,`1992`,`1993`,`1994`,`1995`,`1996`,`1997`,`1998`,`1999`,`2000`,`2001`,`2002`,`2003`,`2004`,`2005`,`2006`,`2007`,`2008`,`2009`,`2010`,`2011`,`2012`,`2013`,`2014`,`2015`,`2016`,`2017`,`2018`,`2019`,`2020`);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/MCO_Country.txt' 
INTO TABLE indata_countries
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(`Code`,`Region`,`IncomeGroup`,`SpecialNotes`,`Name`);

/*24.MALTA*/
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/MLT_Data.txt'
INTO TABLE indata_data
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 4 LINES
(`CountryName`,`CountryCode`,`IndicatorName`,`IndicatorCode`,`1960`,`1961`,`1962`,`1963`,`1964`,`1965`,`1966`,`1967`,`1968`,`1969`,`1970`,`1971`,`1972`,`1973`,`1974`,`1975`,`1976`,`1977`,`1978`,`1979`,`1980`,`1981`,`1982`,`1983`,`1984`,`1985`,`1986`,`1987`,`1988`,`1989`,`1990`,`1991`,`1992`,`1993`,`1994`,`1995`,`1996`,`1997`,`1998`,`1999`,`2000`,`2001`,`2002`,`2003`,`2004`,`2005`,`2006`,`2007`,`2008`,`2009`,`2010`,`2011`,`2012`,`2013`,`2014`,`2015`,`2016`,`2017`,`2018`,`2019`,`2020`);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/MLT_Country.txt' 
INTO TABLE indata_countries
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(`Code`,`Region`,`IncomeGroup`,`SpecialNotes`,`Name`);

/*25.SERBIA*/
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/MNE_Data.txt'
INTO TABLE indata_data
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 4 LINES
(`CountryName`,`CountryCode`,`IndicatorName`,`IndicatorCode`,`1960`,`1961`,`1962`,`1963`,`1964`,`1965`,`1966`,`1967`,`1968`,`1969`,`1970`,`1971`,`1972`,`1973`,`1974`,`1975`,`1976`,`1977`,`1978`,`1979`,`1980`,`1981`,`1982`,`1983`,`1984`,`1985`,`1986`,`1987`,`1988`,`1989`,`1990`,`1991`,`1992`,`1993`,`1994`,`1995`,`1996`,`1997`,`1998`,`1999`,`2000`,`2001`,`2002`,`2003`,`2004`,`2005`,`2006`,`2007`,`2008`,`2009`,`2010`,`2011`,`2012`,`2013`,`2014`,`2015`,`2016`,`2017`,`2018`,`2019`,`2020`);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/MNE_Country.txt' 
INTO TABLE indata_countries
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(`Code`,`Region`,`IncomeGroup`,`SpecialNotes`,`Name`);
SELECT 'ETL_ExtractDataPhase Script has been completed successfully!' AS ' '