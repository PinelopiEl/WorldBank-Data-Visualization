/*|=====================================================================|*/
/*|                        INITIALISATION							  	|*/
/*|_____________________________________________________________________|*/
/*|                              										|*/
/*|=====================================================================|*/
DROP DATABASE IF EXISTS wdi;
CREATE DATABASE wdi;
USE wdi;

/*|===================================================================|*/
/*|                    ETL TOOL - LOAD				  			  |*/
/*|___________________________________________________________________|*/
/*|   LOAD THE ALREADY TRANSFORMED DATA TO THE DESTINATION DATABASE	  |*/
/*|===================================================================|*/
/* Creation and Population of table `incomegroups`*/
CREATE TABLE `incomegroups` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(225) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Name_UNIQUE` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Income Groups Lookup table';
INSERT INTO `incomegroups`(`Name`) 
SELECT `Name` FROM `wdi_transform`.`incomegroups`;

/* Creation and Population of table `regions`*/
CREATE TABLE `regions` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Name_UNIQUE` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `regions`(`Name`) 
SELECT `Name` FROM `wdi_transform`.`regions`;

/* Creation and Population of table `countries`*/
CREATE TABLE `countries` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Code` varchar(3) NOT NULL,
  `Name` varchar(45) NOT NULL,
  `RegionID` int DEFAULT NULL ,
  `IncomeGroupID` int DEFAULT NULL,
  `SpecialNotes` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Code_UNIQUE` (`Code`),
  UNIQUE KEY `Name_UNIQUE` (`Name`),
  KEY `RegionID_idx` (`RegionID`),
  CONSTRAINT `RegionID` FOREIGN KEY (`RegionID`) REFERENCES `regions` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `countries`(`Code`,`Name`,`RegionID`, `IncomeGroupID`, `SpecialNotes`) 
SELECT `Code`,`Name`,`RegionID`, `IncomeGroupID`, `SpecialNotes` FROM `wdi_transform`.`countries`;

/* Creation and Population of table `indicatorcategories`*/
CREATE TABLE `indicatorcategories` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Name` char(2) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Name_UNIQUE` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `indicatorcategories`(`Name`) 
SELECT `Name` FROM `wdi_transform`.`indicatorcategories`;

/* Creation and Population of table `indicators`*/
CREATE TABLE `indicators` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `IndicatorCategoryID` int NOT NULL,
  `Code` varchar(45) NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Code_UNIQUE` (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `indicators`(`IndicatorCategoryID`,`Code`,`Name`) 
SELECT  `IndicatorCategoryID`,`Code`,`Name` FROM `wdi_transform`.`indicators`;

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
SELECT `Name`,`Lustrum`,`Decade`,`Vicennial` FROM `wdi_transform`.`years`;

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
INSERT INTO `ciy`(`CountryID`,`IndicatorID`,`YearID`,`Value`) 
SELECT `CountryID`,`IndicatorID`,`YearID`,`Value` FROM `wdi_transform`.`ciy`;


SELECT 'Database created and data loaded successfully.';