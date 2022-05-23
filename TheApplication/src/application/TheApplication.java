package application;
	
import javafx.application.Application;
import javafx.stage.Stage;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.fxml.FXMLLoader;


public class TheApplication extends Application {
	Stage window;
	@Override
	public void start(Stage primaryStage) {
		window = primaryStage;
		try {
			Parent root = FXMLLoader.load(getClass().getResource("TheView.fxml"));
			Scene scene = new Scene(root);
			scene.getStylesheets().add(getClass().getResource("application.css").toExternalForm());
			window.setScene(scene);
			window.setTitle("The Application");
			window.getIcons().add(new Image(getClass().getResourceAsStream("TheAppIcon.png")));
			window.setOnCloseRequest(e->closeApplication());
			window.show();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	public void closeApplication() {
		window.close();
	}

	public static void main(String[] args) { 
		Application.launch(args);
	}
}
