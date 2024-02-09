module org.example.login {
    requires javafx.controls;
    requires javafx.fxml;


    opens org.example.login to javafx.fxml;
    exports org.example.login;
}