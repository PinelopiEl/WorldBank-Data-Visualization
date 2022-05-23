package application;

import java.net.URL;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ResourceBundle;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.geometry.Side;
import javafx.scene.chart.AreaChart;
import javafx.scene.chart.BarChart;
import javafx.scene.chart.BubbleChart;
import javafx.scene.chart.CategoryAxis;
import javafx.scene.chart.NumberAxis;
import javafx.scene.chart.PieChart;
import javafx.scene.chart.ScatterChart;
import javafx.scene.chart.StackedAreaChart;
import javafx.scene.chart.StackedBarChart;
import javafx.scene.chart.XYChart;
import javafx.scene.chart.LineChart;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.RadioButton;
import javafx.scene.control.TextArea;
import javafx.scene.control.ToggleGroup;
import javafx.scene.layout.BorderPane;
import javafx.beans.value.ChangeListener;
import javafx.beans.value.ObservableValue;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.stage.Stage;

public class TheController implements Initializable{
	@FXML public BorderPane border;
	@FXML public ComboBox<String> cboRegion;
	@FXML public ComboBox<String> cboIncomeGroup;
	@FXML public ComboBox<String> cboCountry;
	@FXML public ComboBox<String> cboIndicatorCategory;
	@FXML public ComboBox<String> cboIndicator1;
	@FXML public ComboBox<String> cboIndicator2;
	@FXML public ComboBox<String> cboFromYear;
	@FXML public ComboBox<String> cboToYear;
	@FXML public ComboBox<ChartType> cboChartType;
	@FXML public TextArea txtChartTitle;
	@FXML public TextArea txtSeriesTitle;
	@FXML public Button btnAddSeries;
	@FXML public Button btnClearSeries;
	@FXML public Button btnClose;
	@FXML public ToggleGroup rbgIntervals;
	@FXML public RadioButton rboYear;
	@FXML public RadioButton rboLustrum;
	@FXML public RadioButton rboDecade;
	@FXML public RadioButton rboVicennial;
	@FXML public ToggleGroup rbgFunctions;
	@FXML public RadioButton rboValue;
	@FXML public RadioButton rboSum;
	@FXML public RadioButton rboAverage;
	@FXML public LineChart<String,Number> chart;
	TheModel model;
	
	@Override
	public void initialize(URL arg0, ResourceBundle arg1) {
		//Initialization of Model Object
		model = new TheModel();
		
		//Population and Initialization of Controls. Definition of Listeners for TextField Controls
		populateComboBox(cboRegion, model.getRegions(), "Name" , true);
		model.setRegion("*");	
		System.out.println("Region Ini> " + model.getRegion());
		
		populateComboBox(cboIncomeGroup, model.getIncomeGroups(), "Name", true);
		model.setIncomeGroup("*");
		System.out.println("Income Group Ini> " + model.getIncomeGroup());
		
		populateComboBox(cboCountry, model.getCountries(), "Name", true);
		model.setCountry("*");
		System.out.println("Country Ini> " + model.getCountry());
		
		populateComboBox(cboIndicatorCategory, model.getIndicatorCategories(), "Name", true);
		model.setIndicatorCategory("*");
		System.out.println("Indicator Category Ini> " + model.getIndicatorCategory());
		
		populateComboBox(cboIndicator1, model.getIndicators(), "Name", true);
		model.setIndicator1("*");
		System.out.println("Indicator1 Ini> " + model.getIndicator1());

		populateComboBox(cboIndicator2, model.getIndicators(), "Name", true);
		model.setIndicator2("*");
		System.out.println("Indicator2 Ini> " + model.getIndicator2());
		
		populateComboBox(cboFromYear, model.getYears(), "Name", false);
		String firstItem = cboFromYear.getItems().get(0);
		model.setFromYear(firstItem); 
		System.out.println("From Year Ini> " + model.getFromYear());
		
		populateComboBox(cboToYear, model.getYears(), "Name", false);
		String lastItem =cboToYear.getItems().get(cboToYear.getItems().size()-1);
		model.setToYear(lastItem); 
		cboToYear.setValue(lastItem);
		System.out.println("To Year Ini> " + model.getToYear());
		
		rboYear.setSelected(true); 
		model.setGroupByInterval(TimeInterval.YEAR);
		System.out.println("Group By Time Interval Ini> " + model.getGroupByInterval());
		
		rboValue.setSelected(true); 
		model.setGroupByFunction(DomainFunction.VALUE);	
		System.out.println("Group By Function Interval Ini> " + model.getGroupByFunction());
		
		for (ChartType ct : ChartType.values()) {cboChartType.getItems().add(ct);}
		model.setChartType(ChartType.LineChart);
		cboChartType.setValue(ChartType.LineChart);
		System.out.println("Chart Type Ini> " + model.getChartType());
		
		// Listeners for txtChartTitle, txtSeriesTitle value changes
		txtChartTitle.textProperty().addListener(new ChangeListener<String>() {
			@Override
			public void changed(ObservableValue<? extends String> observable, String oldValue, String newValue) {
				model.setChartTitle(newValue);
				System.out.println("Chart title changed> " + model.getChartTitle());
			}
		});
		txtSeriesTitle.textProperty().addListener(new ChangeListener<String>() {
			@Override
			public void changed(ObservableValue<? extends String> observable, String oldValue, String newValue) {
				model.setSeriesTitle(newValue);
				System.out.println("Series title changed> " + model.getSeriesTitle());
			}
		});
	}
	
	//Event Handlers
	@FXML
	private void handleRegionComboBoxAction() {
		//Update model for control status
		model.setRegion(cboRegion.getSelectionModel().getSelectedItem());
		//Re-populate connected controls
		populateComboBox(cboCountry, model.getCountries(),"Name", true);
		System.out.println("Region EventHandler> " + model.getRegion());
	}
	@FXML
	private void handleIncomeGroupComboBoxAction() {
		//Update model for control status
		model.setIncomeGroup(cboIncomeGroup.getSelectionModel().getSelectedItem());
		//Re-populate connected controls
		populateComboBox(cboCountry, model.getCountries(),"Name", true);
		System.out.println("Income Group EventHandler> " + model.getIncomeGroup());
	}
	@FXML
	private void handleCountryComboBoxAction() {
		//Update model for control status
		if(cboCountry.getSelectionModel().getSelectedItem()!=null)
			model.setCountry(cboCountry.getSelectionModel().getSelectedItem());
		else
			model.setCountry("*");
		//Update Series Title TextField Control
		if(model.getCountry()!="%")
			txtSeriesTitle.setText(model.getCountry());
		System.out.println("Country EventHandler> " + model.getCountry());
	}
	@FXML
	private void handleIndicatorCategoryComboBoxAction() {
		//Update model for control status
		model.setIndicatorCategory(cboIndicatorCategory.getSelectionModel().getSelectedItem());
		//Re-populate connected controls
		if(model.getIndicatorID1()==0) {
			populateComboBox(cboIndicator1, model.getIndicators(), "Name", true);
		}
		if(model.getIndicatorID2()==0) {
			populateComboBox(cboIndicator2, model.getIndicators(), "Name", true);
		}
		System.out.println("Indicator Category EventHandler> " + model.getIndicatorCategory());
	}
	@FXML
	private void handleIndicator1ComboBoxAction() {
		//Update model for control status
		if(cboIndicator1.getSelectionModel().getSelectedItem()!=null)
			model.setIndicator1(cboIndicator1.getSelectionModel().getSelectedItem());
		else
			model.setIndicator1("*");
		//Update Chart Title TextField Control
		if(model.getIndicator1()!="%")
			txtChartTitle.setText(model.getIndicator1());
		System.out.println("Indicator1 EventHandler> " + model.getIndicator1());
	}
	@FXML
	private void handleIndicator2ComboBoxAction() {
		//Update model for control status
		if(cboIndicator2.getSelectionModel().getSelectedItem()!=null)
			model.setIndicator2(cboIndicator2.getSelectionModel().getSelectedItem());
		else
			model.setIndicator2("*");
		//Update Scatter Chart Title TextField Control
		txtChartTitle.setText("Correlation of [" + model.getIndicator1() + "] and [" + model.getIndicator2() + "]");
		System.out.println("Indicator2 EventHandler> " + model.getIndicator2());
	}
	@FXML
	private void handleFromYearComboBoxAction() {
		//Update model for control status
		model.setFromYear(cboFromYear.getSelectionModel().getSelectedItem());
		System.out.println("From Year EventHandler> " + model.getFromYear());
	}
	@FXML
	private void handleToYearComboBoxAction() {
		//Update model for control status
		model.setToYear(cboToYear.getSelectionModel().getSelectedItem());
		System.out.println("To Year EventHandler> " + model.getToYear());
	}
	@FXML
	private void handleRadioButtonsAction(ActionEvent e) {
		//Update model for control status
		if(rboYear.isSelected()) 			model.setGroupByInterval(TimeInterval.YEAR);
		else if(rboLustrum.isSelected())	model.setGroupByInterval(TimeInterval.LUSTRUM);
		else if(rboDecade.isSelected())		model.setGroupByInterval(TimeInterval.DECADE);
		else if(rboVicennial.isSelected())	model.setGroupByInterval(TimeInterval.VICENNIAL);
		System.out.println("Intervals EventHandler> " + model.getGroupByInterval().toString());
		if(rboValue.isSelected())			model.setGroupByFunction(DomainFunction.VALUE);
		else if(rboSum.isSelected())		model.setGroupByFunction(DomainFunction.SUM);
		else if(rboAverage.isSelected())	model.setGroupByFunction(DomainFunction.AVG);
		System.out.println("Domain Functions EventHandler> " + model.getGroupByFunction().toString());
	}
	@FXML
	private void handleChartTypeComboBoxAction() {
		//Update model for control status and append the Chart Control
		ChartType selectedChartType = cboChartType.getSelectionModel().getSelectedItem();
		if(model.getChartType()!=selectedChartType) {
	        final CategoryAxis xAxis = new CategoryAxis();
	        final NumberAxis yAxis = new NumberAxis();
	        xAxis.setLabel("Time");  
	        xAxis.setSide(Side.BOTTOM);
	        xAxis.setAnimated(false);
	        yAxis.setLabel("Value");
	        yAxis.setAnimated(false);
			switch(selectedChartType){
	        case AreaChart:
	        	AreaChart<String,Number> areaChart =new AreaChart<String,Number>(xAxis,yAxis);
	        	areaChart.setCreateSymbols(true);
	            border.setCenter(areaChart);
	            System.out.println("handleChartTypeComboBoxAction> Chart changed to AreaChart");
	            break;
	        case BarChart:
	        	BarChart<String,Number> barChart =new BarChart<String,Number>(xAxis,yAxis);
	            border.setCenter(barChart);
	            System.out.println("handleChartTypeComboBoxAction> Chart changed to BarChart");
	            break;    
	        case BubbleChart:
	        	NumberAxis xAxis1 = new NumberAxis();
	        	NumberAxis yAxis1 = new NumberAxis();
	        	BubbleChart<Number,Number> bubbleChart = new BubbleChart<Number,Number>(xAxis1,yAxis1);
	            border.setCenter(bubbleChart);
	            System.out.println("handleChartTypeComboBoxAction> Chart changed to BubbleChart");
	            break;
	        case LineChart:
	        	LineChart<String,Number> lineChart =new LineChart<String,Number>(xAxis,yAxis);
	        	lineChart.setCreateSymbols(true);
	            border.setCenter(lineChart);
	            System.out.println("handleChartTypeComboBoxAction> Chart changed to LineChart");
	            break;
	        case PieChart:
	        	PieChart pieChart =new PieChart();
	            border.setCenter(pieChart);
	            System.out.println("handleChartTypeComboBoxAction> Chart changed to PieChart");
	            break;
	        case ScatterChart:
	        	NumberAxis xAxis2 = new NumberAxis();
	        	NumberAxis yAxis2 = new NumberAxis();
	        	ScatterChart<Number,Number> ScatterChart = new ScatterChart<Number,Number>(xAxis2,yAxis2);
	            border.setCenter(ScatterChart);
	            System.out.println("handleChartTypeComboBoxAction> Chart changed to BubbleChart");
	            break;
	        case StackedAreaChart:
	        	StackedAreaChart<String,Number> stackedAreaChart =new StackedAreaChart<String,Number>(xAxis,yAxis);
	        	stackedAreaChart.setCreateSymbols(true);
	            border.setCenter(stackedAreaChart);
	            System.out.println("handleChartTypeComboBoxAction> Chart changed to StackedAreaChart");
	            break;
	        case StackedBarChart:
	        	StackedBarChart<String,Number> stackedBarChart =new StackedBarChart<String,Number>(xAxis,yAxis);
	            border.setCenter(stackedBarChart);
	            System.out.println("handleChartTypeComboBoxAction> Chart changed to StackedBarChart");
	            break; 
	        default:
	        	showAlertBox(AlertType.ERROR,"Error","Unknown Chart Type", "The type of the chart is unknown.");
	            System.out.println("Unknown Chart Type.");
	            break;
	        }
		}
		model.setChartType(selectedChartType);
		System.out.println("Chart Type EventHandler> " + model.getChartType());
	}
	@FXML
	private void handleAddSeriesButton(ActionEvent event) { 
		if(model.getCountryID() ==0 || model.getIndicatorID1()==0) { 
			showAlertBox(AlertType.INFORMATION, "Missing Info", "Not all selections have been done!", 
						 "A selection, other than *, for country and first indicator required.");
			return;
		}
		ResultSet rst;
		switch(model.getChartType()){
        case AreaChart:
        	//Collect Data
        	rst = model.getCIYData();        	
        	System.out.println("handleAddSeriesButton> Data retrieved");
            //Define and populate series
            XYChart.Series<String,Number> areaChartSeries = new XYChart.Series<String,Number>();
            areaChartSeries.setName(model.getSeriesTitle());
            try {
    			while(rst.next()) {
    				areaChartSeries.getData().add(new XYChart.Data<String,Number>(rst.getString("YearName"), rst.getDouble("Value")));
    			}
    		} catch (SQLException e) {
    			e.printStackTrace();
    		}
            //Populate chart with series, title
            @SuppressWarnings("unchecked") 
            AreaChart<String, Number> areaChart = (AreaChart<String, Number>) border.getCenter();
        	areaChart.setTitle(model.getChartTitle());
            areaChart.getData().add(areaChartSeries);
        	System.out.println("handleAddSeriesButton> AreaChart");
            break;
        case BarChart:
        	//Collect Data
        	rst = model.getCIYData();        	
        	System.out.println("handleAddSeriesButton> Data retrieved");
            //Defining a series
            XYChart.Series<String,Number> barChartSeries = new XYChart.Series<String,Number>();
            barChartSeries.setName(model.getSeriesTitle());
            //Define and populate series
            try {
    			while(rst.next()) {
    				barChartSeries.getData().add(new XYChart.Data<String,Number>(rst.getString("YearName"), rst.getDouble("Value")));
    			}
    		} catch (SQLException e) {
    			e.printStackTrace();
    		}
            //Populate chart with series, title
            @SuppressWarnings("unchecked") 
            BarChart<String, Number> barChart = (BarChart<String, Number>) border.getCenter();
        	barChart.setTitle(model.getChartTitle());
            barChart.getData().add(barChartSeries);
        	System.out.println("handleAddSeriesButton> AreaChart");
            break; 
        case BubbleChart:
        	showAlertBox(AlertType.INFORMATION,"Information","Bubble charts are not supported.", "Bubble charts are not supported.");
            System.out.println("handleAddSeriesButton>");
            break;
        case LineChart:
        	//Collect Data
        	rst = model.getCIYData();
        	System.out.println("RunQuery> Data retrieved");
        	//Define and populate series
            XYChart.Series<String,Number> lineChartSeries = new XYChart.Series<String,Number>();
            lineChartSeries.setName(model.getSeriesTitle());
            try {
    			while(rst.next()) {
    				lineChartSeries.getData().add(new XYChart.Data<String,Number>(rst.getString("YearName"), rst.getDouble("Value")));
    			}
    		} catch (SQLException e) {
    			e.printStackTrace();
    		}
            //Populate chart with series, title
            @SuppressWarnings("unchecked") 
            LineChart<String, Number> lineChart = (LineChart<String, Number>) border.getCenter();
        	lineChart.setTitle(model.getChartTitle());
            lineChart.getData().add(lineChartSeries);
        	System.out.println("handleAddSeriesButton> LineChart");
            break;
        case ScatterChart:
        	//Collect Data
        	rst = model.getCIYCorrelationData();     	
        	System.out.println("handleAddSeriesButton> Data retrieved");
        	//Define and populate series
            XYChart.Series<Number,Number> scaterChartSeries = new XYChart.Series<Number,Number>();
            scaterChartSeries.setName(model.getSeriesTitle());
             try {
    			while(rst.next()) {
    				scaterChartSeries.getData().add(new XYChart.Data<Number,Number>(rst.getDouble("Value1"), rst.getDouble("Value2")));
    			}
    		} catch (SQLException e) {
    			e.printStackTrace();
    		}
            //Populate chart with series, title
            @SuppressWarnings("unchecked") 
        	ScatterChart<Number,Number> scatterChart = (ScatterChart<Number, Number>) border.getCenter();
        	scatterChart.getXAxis().setLabel(model.getIndicator1());
        	scatterChart.getYAxis().setLabel(model.getIndicator2());
        	scatterChart.setTitle(model.getChartTitle());
        	scatterChart.getData().add(scaterChartSeries);
            System.out.println("handleAddSeriesButton> ScatterChart");
            break;
        case StackedAreaChart:
        	//Collect Data
        	rst = model.getCIYData();        	
        	System.out.println("handleAddSeriesButton> Data retrieved");
        	//Define and populate series
            XYChart.Series<String,Number> stackedAreaChartSeries = new XYChart.Series<String,Number>();
            stackedAreaChartSeries.setName(model.getSeriesTitle());
            try {
    			while(rst.next()) {
    				stackedAreaChartSeries.getData().add(new XYChart.Data<String,Number>(rst.getString("YearName"), rst.getDouble("Value")));
    			}
    		} catch (SQLException e) {
    			e.printStackTrace();
    		}
            //Populate chart with series, title
            @SuppressWarnings("unchecked") 
            StackedAreaChart<String, Number> stackedAreaChart = (StackedAreaChart<String, Number>) border.getCenter();
            stackedAreaChart.setTitle(model.getChartTitle());
            stackedAreaChart.getData().add(stackedAreaChartSeries);
        	System.out.println("handleAddSeriesButton> StackedAreaChart");
            break;
        case StackedBarChart:
        	//Collect Data
        	rst = model.getCIYData();        	
        	System.out.println("handleAddSeriesButton> Data retrieved");
        	//Define and populate series
            XYChart.Series<String,Number> stachedBarChartSeries = new XYChart.Series<String,Number>();
            stachedBarChartSeries.setName(model.getSeriesTitle());
            try {
    			while(rst.next()) {
    				stachedBarChartSeries.getData().add(new XYChart.Data<String,Number>(rst.getString("YearName"), rst.getDouble("Value")));
    			}
    		} catch (SQLException e) {
    			e.printStackTrace();
    		}
            //Populate chart with series, title
            @SuppressWarnings("unchecked") 
            StackedBarChart<String, Number> stachedBarChart = (StackedBarChart<String, Number>) border.getCenter();
            stachedBarChart.setTitle(model.getChartTitle());
            stachedBarChart.getData().add(stachedBarChartSeries);
        	System.out.println("handleAddSeriesButton> AreaChart");
            break;  
        case PieChart:
        	//Collect Data
        	rst = model.getCIYData();
        	System.out.println("RunQuery> Data retrieved");

        	//Define and populate series
        	ObservableList<PieChart.Data> data = FXCollections.observableArrayList();
            try {
    			while(rst.next()) {
    				data.add(new PieChart.Data(rst.getString("YearName"), rst.getDouble("Value")));
    			}
    		} catch (SQLException e) {
    			e.printStackTrace();
    		}
          //Populate chart with series, title
            PieChart pieChart = (PieChart) border.getCenter();
            pieChart.setTitle(model.getChartTitle() + "-" + model.getSeriesTitle());
            pieChart.getData().addAll(data);
            System.out.println("handleAddSeriesButton> PieChart");
            break;
        default:
        	showAlertBox(AlertType.ERROR,"Error","Unknown Chart Type", "The type of the chart is unknown.");
            System.out.println("Unknown Chart Type.");
            break;
        }
	
	}
	@SuppressWarnings("unchecked")
	@FXML
	private void handleClearSeriesButton(ActionEvent event) {
		if(model.getChartType()==ChartType.PieChart) {
			((PieChart) border.getCenter()).getData().clear();
		}else {
			((XYChart<String, Number>) border.getCenter()).getData().clear();
		}
		System.out.println("handleClearSeriesButton> Chart cleared.");
	}
	@FXML
	private void handleCloseButton(ActionEvent event) {
		Stage window = (Stage)cboRegion.getScene().getWindow();
		window.close();
		System.out.println("App closed");
	}
	
	
	//Utility Functions
	private void populateComboBox(ComboBox<String> cbo, ResultSet rst, String fieldName, Boolean addAll) {
		try {
			//Clear previous population of control
			cbo.getItems().clear() ;
			if (addAll) cbo.getItems().add("*");
			while (rst.next()) {
				cbo.getItems().add(rst.getString(fieldName));
			}
			//Set initial value to first value
			cbo.setValue(cbo.getItems().get(0));
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	private void showAlertBox(AlertType alertType, String title, String header, String contentText) {
		Alert alert = new Alert(alertType);
		alert.setTitle(title);
		alert.setHeaderText(header);
		alert.setContentText(contentText);
		alert.showAndWait();
	}
}
