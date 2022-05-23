module TheApplication {
	requires java.sql;	
	requires javafx.base;
	requires javafx.fxml;	
	requires javafx.controls;
	requires javafx.graphics;
	
	opens application to javafx.graphics, javafx.fxml;
}
