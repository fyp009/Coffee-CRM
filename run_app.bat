@echo off
REM Coffee Shop Management System Launcher
REM This script runs the JavaFX application with SQLite database support

echo Starting Coffee Shop Management System...

REM Set up classpath excluding conflicting JavaFX JARs
set CLASSPATH=bin;lib\mysql-connector-java-8.0.27.jar;lib\sqlite-jdbc-3.44.1.0.jar;lib\slf4j-api-1.7.36.jar;lib\slf4j-simple-1.7.36.jar

REM Run the application
java --module-path "C:\openjfx-25.0.1\javafx-sdk-25.0.1\lib" --add-modules javafx.controls,javafx.fxml -cp "%CLASSPATH%" Main

pause