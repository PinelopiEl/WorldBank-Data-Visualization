/*|=====================================================================|*/
/*|                        INITIALISATION							  	|*/
/*|_____________________________________________________________________|*/
/*|                              										|*/
/*|=====================================================================|*/
DROP DATABASE IF EXISTS `wdi_transform`;
CREATE DATABASE `wdi_transform`;
USE `wdi_transform`;

/*|===================================================================|*/
/*|                    ETL TOOL - TRANSFORM				  			  |*/
/*|___________________________________________________________________|*/
/*| TRANSFORM DATA  												  |*/
/*|===================================================================|*/
/* Creation and Population of table `incomegroups`*/
CREATE TABLE `incomegroups` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(225) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Income Groups Lookup table';
INSERT INTO `incomegroups`(`Name`) 
SELECT DISTINCT `IncomeGroup` FROM `wdi_extract`.`indata_countries`
ORDER BY `IncomeGroup` ASC;

/* Creation and Population of table `regions`*/
CREATE TABLE `regions` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Name_UNIQUE` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `regions`(`Name`) 
SELECT DISTINCT `Region` FROM `wdi_extract`.`indata_countries`
ORDER BY `Region` ASC;

/* Creation and Population of table `countries`*/
CREATE TABLE `countries` (
    `ID` INT NOT NULL AUTO_INCREMENT,
    `Code` VARCHAR(3) NOT NULL,
    `Name` VARCHAR(45) NOT NULL,
    `RegionID` INT DEFAULT NULL,
    `IncomeGroupID` INT DEFAULT NULL,
    `SpecialNotes` VARCHAR(512) DEFAULT NULL,
    PRIMARY KEY (`ID`),
    UNIQUE KEY `Code_UNIQUE` (`Code`),
    UNIQUE KEY `Name_UNIQUE` (`Name`),
    KEY `RegionID_idx` (`RegionID`),
    CONSTRAINT `RegionID` FOREIGN KEY (`RegionID`)
        REFERENCES `regions` (`ID`)
)  ENGINE=INNODB AUTO_INCREMENT=3 DEFAULT CHARSET=UTF8MB4 COLLATE = UTF8MB4_0900_AI_CI;
INSERT INTO `countries`(`Code`,`Name`,`RegionID`, `IncomeGroupID`, `SpecialNotes`) 
SELECT DISTINCT
    `wdi_extract`.`indata_countries`.`Code`,
    `wdi_extract`.`indata_countries`.`Name`,
    `regions`.`ID` AS `RegionsID`,
    `incomegroups`.`ID` AS `IncomeGroupID`,
    `SpecialNotes`
FROM
    (`wdi_extract`.`indata_countries`
	LEFT JOIN
    `wdi_transform`.`incomegroups`
	ON
    `wdi_extract`.`indata_countries`.`IncomeGroup` = `incomegroups`.`Name`)
	LEFT JOIN
    `wdi_transform`.`regions`
	ON
	`wdi_extract`.`indata_countries`.`Region` = `regions`.`Name`
ORDER BY `Name` ASC;

/* Creation and Population of table `indicatorcategories`*/
CREATE TABLE `indicatorcategories` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Name` char(2) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Name_UNIQUE` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `indicatorcategories`(`Name`) 
SELECT DISTINCT substring( IndicatorCode,1,2) As IC FROM `wdi_extract`.`indata_data` 
WHERE substring( IndicatorCode,1,2)="SP" OR substring( IndicatorCode,1,2)="TM" OR substring( IndicatorCode,1,2)="TX"
ORDER BY IC ASC;

/* Creation and Population of table `indicators`*/
CREATE TABLE `indicators` (
    `ID` INT NOT NULL AUTO_INCREMENT,
    `IndicatorCategoryID` INT NOT NULL,
    `Code` VARCHAR(45) NOT NULL,
    `Name` VARCHAR(255) DEFAULT NULL,
    PRIMARY KEY (`ID`),
    UNIQUE KEY `Code_UNIQUE` (`Code`)
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4 COLLATE = UTF8MB4_0900_AI_CI;
INSERT INTO `indicators`(`IndicatorCategoryID`,`Code`,`Name`) 
SELECT DISTINCT
    `indicatorcategories`.`ID`,
    `wdi_extract`.`indata_data`.`IndicatorCode`,
	`wdi_extract`.`indata_data`.`IndicatorName`
FROM
    (`wdi_transform`.`indicatorcategories`
	LEFT JOIN
    `wdi_extract`.`indata_data`
	ON
    `indicatorcategories`.`Name`=substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2) )
ORDER BY `wdi_extract`.`indata_data`.`IndicatorCode` ASC;

/* Creation and Population of table `years`*/
CREATE TABLE `years` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(4) NOT NULL,
  `Lustrum` INT NOT NULL,
  `Decade` INT NOT NULL,
  `Vicennial` INT NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `years`(`Name`,`Lustrum`,`Decade`,`Vicennial`)
VALUES
(1960, 1960, 1960, 1960),(1961, 1960, 1960, 1960),(1962, 1960, 1960, 1960),(1963, 1960, 1960, 1960),(1964, 1960, 1960, 1960),      
(1965, 1965, 1960, 1960),(1966, 1965, 1960, 1960),(1967, 1965, 1960, 1960),(1968, 1965, 1960, 1960),(1969, 1965, 1960, 1960),
(1970, 1970, 1970, 1960),(1971, 1970, 1970, 1960),(1972, 1970, 1970, 1960),(1973, 1960, 1960, 1960),(1974, 1970, 1970, 1960),      
(1975, 1975, 1970, 1960),(1976, 1975, 1970, 1960),(1977, 1975, 1970, 1960),(1978, 1975, 1970, 1960),(1979, 1975, 1970, 1960),
(1980, 1980, 1980, 1980),(1981, 1980, 1980, 1980),(1982, 1980, 1980, 1980),(1983, 1980, 1980, 1980),(1984, 1980, 1980, 1980),      
(1985, 1985, 1980, 1980),(1986, 1985, 1980, 1980),(1987, 1985, 1980, 1980),(1988, 1985, 1980, 1980),(1989, 1985, 1980, 1980),
(1990, 1990, 1990, 1980),(1991, 1990, 1990, 1980),(1992, 1990, 1990, 1980),(1993, 1990, 1990, 1980),(1994, 1990, 1990, 1980),      
(1995, 1995, 1990, 1980),(1996, 1995, 1990, 1980),(1997, 1995, 1990, 1980),(1998, 1995, 1990, 1980),(1999, 1995, 1990, 1980),
(2000, 2000, 2000, 2000),(2001, 2000, 2000, 2000),(2002, 2000, 2000, 2000),(2003, 2000, 2000, 2000),(2004, 2000, 2000, 2000),      
(2005, 2005, 2000, 2000),(2006, 2005, 2000, 2000),(2007, 2005, 2000, 2000),(2008, 2005, 2000, 2000),(2009, 2005, 2000, 2000),
(2010, 2010, 2010, 2000),(2011, 2010, 2010, 2000),(2012, 2010, 2010, 2000),(2013, 2010, 2010, 2000),(2014, 2010, 2010, 2000),      
(2015, 2015, 2010, 2000),(2016, 2015, 2010, 2000),(2017, 2015, 2010, 2000),(2018, 2015, 2010, 2000),(2019, 2015, 2010, 2000),
(2020, 2020, 2020, 2020);

/* Country-Indicator-Year non-normilized table*/
CREATE TABLE `ciy_nn` (
  `CountryCode` varchar(10) NOT NULL,
  `IndicatorCode` varchar(45) NOT NULL,
  `YearNo` varchar(4) NOT NULL,
  `IndicatorValue` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1960" AS YearNo, `1960` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1960` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" ); 
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1961" AS YearNo, `1961` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1961` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1962" AS YearNo, `1962` AS IndicatorValue FROM `wdi_extract`.`indata_data`  
WHERE `1962` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1963" AS YearNo, `1963` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1963` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1964" AS YearNo, `1964` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1964` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1965" AS YearNo, `1965` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1965` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1966" AS YearNo, `1966` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1966` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1967" AS YearNo, `1967` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1967` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1968" AS YearNo, `1968` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1968` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1969" AS YearNo, `1969` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1969` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1970" AS YearNo, `1970` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1970` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1971" AS YearNo, `1971` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1971` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1972" AS YearNo, `1972` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1972` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1973" AS YearNo, `1973` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1973` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1974" AS YearNo, `1974` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1974` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1975" AS YearNo, `1975` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1975` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1976" AS YearNo, `1976` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1976` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1977" AS YearNo, `1977` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1977` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1978" AS YearNo, `1978` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1978` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1979" AS YearNo, `1979` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1979` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1980" AS YearNo, `1980` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1980` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1981" AS YearNo, `1981` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1981` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1982" AS YearNo, `1982` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1982` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1983" AS YearNo, `1983` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1983` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1984" AS YearNo, `1984` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1984` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1985" AS YearNo, `1985` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1985` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1986" AS YearNo, `1986` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1986` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1987" AS YearNo, `1987` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1987` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1988" AS YearNo, `1988` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1988` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1989" AS YearNo, `1989` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1989` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1990" AS YearNo, `1990` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1990` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1991" AS YearNo, `1991` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1991` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1992" AS YearNo, `1992` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1992` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1993" AS YearNo, `1993` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1993` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1994" AS YearNo, `1994` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1994` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1995" AS YearNo, `1995` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1995` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1996" AS YearNo, `1996` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1996` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1997" AS YearNo, `1997` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1997` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1998" AS YearNo, `1998` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1998` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "1999" AS YearNo, `1999` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `1999` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "2000" AS YearNo, `2000` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `2000` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "2001" AS YearNo, `2001` AS IndicatorValue FROM `wdi_extract`.`indata_data`
WHERE `2001` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "2002" AS YearNo, `2002` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `2002` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "2003" AS YearNo, `2003` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `2003` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "2004" AS YearNo, `2004` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `2004` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "2005" AS YearNo, `2005` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `2005` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "2006" AS YearNo, `2006` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `2006` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "2007" AS YearNo, `2007` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `2007` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "2008" AS YearNo, `2008` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `2008` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "2009" AS YearNo, `2009` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `2009` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "2010" AS YearNo, `2010` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `2010` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "2011" AS YearNo, `2011` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `2011` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "2012" AS YearNo, `2012` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `2012` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "2013" AS YearNo, `2013` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `2013` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "2014" AS YearNo, `2014` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `2014` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "2015" AS YearNo, `2015` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `2015` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "2016" AS YearNo, `2016` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `2016` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "2017" AS YearNo, `2017` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `2017` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "2018" AS YearNo, `2018` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `2018` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "2019" AS YearNo, `2019` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `2019` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );
INSERT INTO `ciy_nn`(`CountryCode`,`IndicatorCode`,`YearNo`,`IndicatorValue`) 
SELECT `CountryCode`, `IndicatorCode`, "2020" AS YearNo, `2020` AS IndicatorValue FROM `wdi_extract`.`indata_data` 
WHERE `2020` IS NOT NULL AND (substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="SP" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TM" OR substring(`wdi_extract`.`indata_data`.`IndicatorCode`,1,2)="TX" );

  /* Country-Indicator-Year table*/
CREATE TABLE `ciy` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `CountryID` int NOT NULL,
  `IndicatorID` int NOT NULL,
  `YearID` int NOT NULL,
  `Value` double DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `CIY_INDEX` (`CountryID`,`IndicatorID`,`YearID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `ciy`(`CountryID`, `IndicatorID`, `YearID`, `Value`) 
SELECT 
    `countries`.`ID` ,
    `indicators`.`ID` ,
    `years`.`ID` ,
    `ciy_nn`.`IndicatorValue`
FROM
    ((`ciy_nn`
	LEFT JOIN
    `countries`
	ON
	`ciy_nn`.`CountryCode`= `countries`.`Code`)
	LEFT JOIN
    `indicators`
	ON
	`ciy_nn`.`IndicatorCode` = `indicators`.`Code`)
    LEFT JOIN
    `years`
	ON
	`ciy_nn`.`YearNo` = `years`.`Name`;
    

    
    SELECT 'ETL_TransformDataPhase Script has been completed successfully!' AS ' '