package application;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

public class TheModel {
	//Private members
	ResultSet resultSet;
	String region; 				long regionID;
	String incomeGroup;			long incomeGroupID;
	String country;				long countryID;
	String indicatorCategory;	long indicatorCategoryID;
	String indicator1;			long indicatorID1;
	String indicator2;			long indicatorID2;
	String fromYear;			long fromYearID;
	String toYear;				long toYearID;
	TimeInterval   groupByInterval;	
	DomainFunction groupByFunction;
	ChartType      chartType;
	String 		   chartTitle;
	String 		   seriesTitle;
	
	//Getters and Setters
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		if(region == "*") {
			this.region = "%";
			this.regionID = 0;
		}else {
			this.region = region;
			this.regionID=getRegionID(region);
		}
	}
	public long getRegionID() {
		return regionID;
	}
	public void setRegionID(long regionID) {
		this.regionID = regionID;
	}

	public String getIncomeGroup() {
		return incomeGroup;
	}
	public void setIncomeGroup(String incomeGroup) {
		if(incomeGroup == "*") {
			this.incomeGroup = "%";
			this.incomeGroupID = 0;
		}else {
			this.incomeGroup = incomeGroup;
			this.incomeGroupID = getIncomeGroupID(incomeGroup);
		}
	}
	public long getIncomeGroupID() {
		return incomeGroupID;
	}
	public void setIncomeGroupID(long incomeGroupID) {
		this.incomeGroupID = incomeGroupID;
	}

	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		if(country == "*") {
			this.country = "%";
			this.setCountryID(0);
		}else {
			this.country = country;
			this.countryID = getCountryID(country) ;
		}
	}
	public long getCountryID() {
		return countryID;
	}
	public void setCountryID(long countryID) {
		this.countryID = countryID;
	}

	public String getIndicatorCategory() {
		return indicatorCategory;
	}
	public void setIndicatorCategory(String indicatorCategory) {
		this.indicatorCategory = indicatorCategory;
		if(indicatorCategory == "*") {
			this.indicatorCategory = "%";
			this.setIndicatorCategoryID(0);
		}else {
			this.indicatorCategory = indicatorCategory;
			this.indicatorCategoryID = getIndicatorCategoryID(indicatorCategory);
		}
	}
	public long getIndicatorCategoryID() {
		return indicatorCategoryID;
	}
	public void setIndicatorCategoryID(long indicatorCategoryID) {
		this.indicatorCategoryID = indicatorCategoryID;
	}
	public String getIndicator1() {
		return indicator1;
	}
	public void setIndicator1(String indicator1) {
		if(indicator1 == "*") {
			this.indicator1 = "%";
			this.setIndicatorID1(0);
		}else {
			this.indicator1 = indicator1;
			this.indicatorID1 = getIndicatorID(indicator1);
		}
	}
	public long getIndicatorID1() {
		return indicatorID1;
	}
	public void setIndicatorID1(long indicatorID1) {
		this.indicatorID1 = indicatorID1;
	}
	public String getIndicator2() {
		return indicator2;
	}
	public void setIndicator2(String indicator2) {
		if(indicator2 == "*") {
			this.indicator2 = "%";
			this.indicatorID2 = 0;
		}else {
			this.indicator2 = indicator2;
			this.indicatorID2 = getIndicatorID(indicator2);
		}
	}
	public long getIndicatorID2() {
		return indicatorID2;
	}
	public void setIndicatorID2(long indicatorID2) {
		this.indicatorID2 = indicatorID2;
	}
	
	public String getFromYear() {
		return fromYear;
	}
	public void setFromYear(String fromYear) {
		this.fromYear = fromYear;
		this.fromYearID = getYearID(fromYear);
	}
	public long getFromYearID() {
		return fromYearID;
	}
	public void setFromYearID(long fromYearID) {
		this.fromYearID = fromYearID;
	}

	public String getToYear() {
		return toYear;
	}
	public void setToYear(String toYear) {
		this.toYear = toYear;
		this.toYearID = getYearID(toYear);
	}
	public long getToYearID() {
		return toYearID;
	}
	public void setToYearID(long toYearID) {
		this.toYearID = toYearID;
	}

	public TimeInterval getGroupByInterval() {
		return groupByInterval;
	}
	public void setGroupByInterval(TimeInterval groupByInterval) {
		this.groupByInterval = groupByInterval;
	}
	
	public DomainFunction getGroupByFunction() {
		return groupByFunction;
	}
	public void setGroupByFunction(DomainFunction groupByFunction) {
		this.groupByFunction = groupByFunction;
	}
	
	public ChartType getChartType() {
		return chartType;
	}
	public void setChartType(ChartType chartType) {
		this.chartType =chartType;
	}
	
	public String getChartTitle() {
		return chartTitle;
	}
	public void setChartTitle(String chartTitle) {
		this.chartTitle = chartTitle;
	}
	
	public String getSeriesTitle() {
		return seriesTitle;
	}
	public void setSeriesTitle(String seriesTitle) {
		this.seriesTitle = seriesTitle;
	}

	
	//Constructor and public functions
	public TheModel() {
		//connect2Database();
	}
	public ResultSet getRegions() { 
		return getData("SELECT Name FROM regions;");	        
	}
	public ResultSet getIncomeGroups() { 
		return getData("SELECT Name FROM incomegroups;");    
	}
	public ResultSet getCountries(){ 
		String s1 = (regionID!=0 || incomeGroupID!=0) ? " WHERE "              				: "";
		String s2 = (regionID!=0)                     ? " RegionID=" + regionID 			: "";
		String s3 = (regionID!=0 && incomeGroupID!=0) ? " AND "                				: "" ;
		String s4 = (incomeGroupID!=0)                ? " IncomeGroupID=" + incomeGroupID 	: "";
		String sqlStatement = "SELECT Name FROM countries" + s1 + s2 + s3 + s4 + ";";
		return getData(sqlStatement);
	}
	public ResultSet getIndicatorCategories() { 
		return getData("SELECT Name FROM indicatorcategories;"); 
	}
	public ResultSet getIndicators() { 
		if(indicatorCategoryID==0){
			return getData("SELECT Name FROM indicators;"); 
		}else {
			return getData("SELECT Name FROM indicators WHERE IndicatorCategoryID=" + indicatorCategoryID + ";"); 
		}
	}
	public ResultSet getYears() { 
		return getData("SELECT Name FROM years;");           
	}	
	
	public long getRegionID(String region) { 
		try {
			ResultSet rst =getData("SELECT ID FROM regions WHERE Name='" + region + "';");
			rst.next();
			return  rst.getLong("ID");
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}       
	}
	public long getIncomeGroupID(String incomegroup) { 
		try {
			ResultSet rst =getData("SELECT ID FROM incomegroups WHERE Name='" + incomegroup + "';");
			rst.next();
			return  rst.getLong("ID");
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}          
	}
	public long getCountryID(String counrty) { 
		try {
			ResultSet rst =getData("SELECT ID FROM countries WHERE Name='" + country + "';");
			rst.next();
			return  rst.getLong("ID");
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}          
	}
	public long getIndicatorCategoryID(String indicatorCategory) { 
		try {
			ResultSet rst =getData("SELECT ID FROM indicatorcategories WHERE Name='" + indicatorCategory + "';");
			rst.next();
			return  rst.getLong("ID");
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}          
	}
	public long getIndicatorID(String indicator) { 
		try {
			ResultSet rst =getData("SELECT ID FROM indicators WHERE Name='" + indicator + "';");
			rst.next();
			return  rst.getLong("ID");
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}          
	}
	public long getYearID(String year) { 
		try {			
			ResultSet rst = getData("SELECT ID FROM years WHERE Name='" + year + "';");
			rst.next();
			return  rst.getLong("ID");
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}          
	}
		
	public ResultSet getData(String sqlStatement) {
		Connection cnx = connect2Database();
		try {
			resultSet =cnx.prepareStatement(sqlStatement).executeQuery();
			return resultSet;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	public ResultSet getCIYData() {
		String selectClause = "SELECT "
									+ " countries.RegionID 	AS RegionID		,"
									+ " regions.Name 		AS RegionName	,"  
									+ " ciy.CountryID 		AS CountryID	,"
									+ " countries.Code 		AS CountryCode	,"
									+ " countries.Name 		AS CountryName	,"
									+ " ciy.IndicatorID 	AS IndicatorID	,"
									+ " indicators.Code 	AS IndicatorCode,"
									+ " indicators.Name 	AS IndicatorName,"
									+ " ciy.YearID 			AS YearID		,"
									+ " years.Name 			AS YearName		,"
									+ " years.Lustrum 		AS Lustrum		,"
									+ " years.Decade 		AS Decade		,"
									+ " years.Vicennial 	AS Vicennial	,";
									//+ " ciy.Value 			AS Value		 ";
		String fromClause =		"FROM "
									+ " ((((countries"
									+ " LEFT JOIN regions ON ((regions.ID = countries.RegionID)))"
									+ " LEFT JOIN ciy ON ((countries.ID = ciy.CountryID)))"
									+ " LEFT JOIN indicators ON ((indicators.ID = ciy.IndicatorID)))"
									+ " LEFT JOIN years ON ((years.ID = ciy.YearID)))";
				
		String whereClause = "WHERE " 
							+ "CountryID = " 	+ getCountryID()		+ " AND "
							+ "IndicatorID = " 	+ getIndicatorID1()		+ " AND "
							+ "YearID >= " 		+ getFromYearID()		+ " AND "
							+ "YearID <= " 		+ getToYearID() 		 ; 
		String orderbyClause = "ORDER BY countries.Code, indicators.Code, years.Name";
		
		//Complete 'SELECT' clause and build 'GROUP BY' clause
		String groupbyClause = "";
		switch(getGroupByInterval()) {
		case YEAR:
			selectClause = selectClause + " ciy.Value AS Value";
			groupbyClause= "";
            break;
        case LUSTRUM:
        	switch(getGroupByFunction()) {
        	case VALUE:
        		selectClause = selectClause + " ciy.Value AS Value";
        		break;
        	case AVG:
        		selectClause = selectClause + " AVG(ciy.Value) AS Value";
        		break;
        	case SUM:
        		selectClause = selectClause + " SUM(ciy.Value) AS Value";
        		break;
        	default:
        		break;
        	}
        	groupbyClause="GROUP BY Lustrum";
            break;
        case DECADE:
          	switch(getGroupByFunction()) {
        	case VALUE:
        		selectClause = selectClause + " ciy.Value AS Value";
        		break;
        	case AVG:
        		selectClause = selectClause + " AVG(ciy.Value) AS Value";
        		break;
        	case SUM:
        		selectClause = selectClause + " SUM(ciy.Value) AS Value";
        		break;
        	default:
        		break;
        	}
        	groupbyClause="GROUP BY Decade";
            break;
        case VICENNIAL:
        	switch(getGroupByFunction()) {
        	case VALUE:
        		selectClause = selectClause + " ciy.Value AS Value";
        		break;
        	case AVG:
        		selectClause = selectClause + " AVG(ciy.Value) AS Value";
        		break;
        	case SUM:
        		selectClause = selectClause + " SUM(ciy.Value) AS Value";
        		break;
        	default:
        		break;
        	}
        	groupbyClause="GROUP BY Vicennial";
            break;
        default:
        	break;
		}
		String sqlStatement = selectClause + " " + fromClause + " " + whereClause + " " + groupbyClause + " " + orderbyClause + ";";
		System.out.println("GetCIYData>" + sqlStatement);
		try {
			Connection cnx = connect2Database();
			resultSet = cnx.prepareStatement(sqlStatement).executeQuery();
			return resultSet;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	public ResultSet getCIYCorrelationData() {
		String selectClause = "SELECT "
								+ " q1.YearID       AS YearID,"
								+ " years.Name      AS YearName,"
								+ " years.Lustrum   AS Lustrum,"
					            + " years.Decade    AS Decade,"
					            + " years.Vicennial AS Vicennial";
		String fromClause =		"FROM ("
			    				+ " (SELECT ciy.YearID AS YearID,ciy.Value AS Value FROM ciy"
			    				+ " WHERE ("
			    				+ " (ciy.CountryID = "   + getCountryID() + ")    AND "
			    				+ " (ciy.IndicatorID = " + getIndicatorID1() + ") AND "
			    				+ " (ciy.YearID >= "     + getFromYearID() + ")   AND "
			    				+ " (ciy.YearID <= "     + getToYearID() + ")))        q1"
			    				+ " JOIN "
			    				+ " (SELECT ciy.YearID AS YearID,ciy.Value AS Value FROM ciy"
			    				+ " WHERE ("
			    				+ " (ciy.CountryID = "   + getCountryID() + ")    AND "
			    				+ " (ciy.IndicatorID = " + getIndicatorID2() + ") AND "
			    				+ " (ciy.YearID >= "     + getFromYearID() + ")   AND "
			    				+ " (ciy.YearID <= "     + getToYearID() + ")))        q2"
			    				+ " ON (q1.YearID = q2.YearID)"
			    				+ " LEFT JOIN  years ON (years.ID = q1.YearID))";
				
		String whereClause = 	""; 
		String orderbyClause = 	"ORDER BY Value1 ASC";
		
		//Complete 'SELECT' clause and build 'GROUP BY' clause
		String groupbyClause = "";
		switch(getGroupByInterval()) {
		case YEAR:
			selectClause = selectClause + ", q1.Value AS Value1, q2.Value AS Value2";
			groupbyClause= "";
            break;
        case LUSTRUM:
        	switch(getGroupByFunction()) {
        	case VALUE:
        		selectClause = selectClause + " q1.Value AS Value1, q2.Value AS Value2";
        		break;
        	case AVG:
        		selectClause = selectClause + " AVG(q1.Value) AS Value1, AVG(q2.Value) AS Value2";
        		break;
        	case SUM:
        		selectClause = selectClause + " SUM(q1.Value) AS Value1, SUM(q2.Value) AS Value2";
        		break;
        	default:
        		break;
        	}
        	groupbyClause="GROUP BY Lustrum";
            break;
        case DECADE:
          	switch(getGroupByFunction()) {
          	case VALUE:
        		selectClause = selectClause + " q1.Value AS Value1, q2.Value AS Value2";
        		break;
        	case AVG:
        		selectClause = selectClause + " AVG(q1.Value) AS Value1, AVG(q2.Value) AS Value2";
        		break;
        	case SUM:
        		selectClause = selectClause + " SUM(q1.Value) AS Value1, SUM(q2.Value) AS Value2";
        		break;
        	default:
        		break;
        	}
        	groupbyClause="GROUP BY Decade";
            break;
        case VICENNIAL:
        	switch(getGroupByFunction()) {
        	case VALUE:
        		selectClause = selectClause + " q1.Value AS Value1, q2.Value AS Value2";
        		break;
        	case AVG:
        		selectClause = selectClause + " AVG(q1.Value) AS Value1, AVG(q2.Value) AS Value2";
        		break;
        	case SUM:
        		selectClause = selectClause + " SUM(q1.Value) AS Value1, SUM(q2.Value) AS Value2";
        		break;
        	default:
        		break;
        	}
        	groupbyClause="GROUP BY Vicennial";
            break;
        default:
        	break;
		}
		String sqlStatement = selectClause + " " + fromClause + " " + whereClause + " " + groupbyClause + " " + orderbyClause + ";";
		System.out.println("getCIYCorrelationData>" + sqlStatement);
		try {
			Connection cnx = connect2Database();
			ResultSet resultSet = cnx.prepareStatement(sqlStatement).executeQuery();
			return resultSet;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	//Utility Functions
	private Connection connect2Database() {
		try {
			Connection cnx = DriverManager.getConnection("jdbc:mysql://localhost:3306/wdi", "root", "8991199856912156El");
			System.out.println("Connected with the database successfully");
			return cnx;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
}

