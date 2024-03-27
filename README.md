# Masr Club App

Masr Club is a Flutter application that allows users to explore events happening in Egypt and view them on a map.

## Table of Contents
1. [Introduction](#introduction)
2. [Features](#features)
3. [Architecture](#architecture)
4. [Technologies Used](#technologies-used)
5. [Setup](#setup)
6. [Usage](#usage)
7. [Contributing](#contributing)
8. [License](#license)

## Introduction
Masr Club aims to provide users with an easy way to discover events in Egypt and visualize them on a map. Users can view event details such as name, category, location, date, time, and description. They can also navigate to the event location using Google Maps integration.

## Features
- View a list of events.
- View event details including name, category, location, date, time, and description.
- View events on a map.
- Navigate to the event location using Google Maps.

## Architecture
Masr Club follows the Clean Architecture pattern to maintain separation of concerns and facilitate scalability. The app is divided into the following components:
- **Entities**: Define core business objects like events.
- **Use Cases**: Contain application-specific business rules.
- **Repositories**: Provide an interface for accessing data.
- **Data Sources**: Implement data sources such as local database or remote server.
- **Models**: Define data models used throughout the app.
- **Repository Implementations**: Concrete implementations of repositories.
- **Controller with BLoC (Business Logic Component)**: Manage the application's state and business logic using the BLoC pattern.

## Technologies Used
- **Flutter**: Framework for building cross-platform mobile applications.
- **Google Maps Flutter**: Plugin for integrating Google Maps into Flutter apps.
- **Dio**: HTTP client for making network requests.
- **Dependency Injection (DI)**: Used for managing dependencies and facilitating testability and scalability.
- **Google Maps API Key**: You'll need to obtain a Google Maps API key and add it to your Flutter project. Follow the [Google Maps API documentation](https://developers.google.com/maps/gmp-get-started) to get your API key, and then add it to your Flutter project's `AndroidManifest.xml` and `Info.plist` files as per the instructions provided. Make sure to keep your API key secure and avoid committing it to version control systems.

## Setup
To run the app locally, follow these steps:
1. Ensure you have Flutter installed. If not, follow the [Flutter installation instructions](https://flutter.dev/docs/get-started/install).
2. Clone this repository.
3. Obtain a Google Maps API key by following the [Google Maps Platform documentation](https://developers.google.com/maps/gmp-get-started).
4. Add your Google Maps API key to the Flutter project:
   - For Android:
     - Open the `android/app/src/main/AndroidManifest.xml` file.
     - Add the following meta-data tag inside the `<application>` element, replacing `"YOUR_API_KEY"` with your actual API key:
       ```xml
       <meta-data
           android:name="com.google.android.geo.API_KEY"
           android:value="YOUR_API_KEY"/>
       ```
   - For iOS:
     - Open the `ios/Runner/AppDelegate.swift` file.
     - Add the following import statement:
       ```swift
       import GoogleMaps
       ```
     - Inside the `application(_:didFinishLaunchingWithOptions:)` method, add the following line, replacing `"YOUR_API_KEY"` with your actual API key:
       ```swift
       GMSServices.provideAPIKey("YOUR_API_KEY")
       ```
5. Run `flutter pub get` to install dependencies.
6. Run the app using `flutter run`.

Make sure to replace `"YOUR_API_KEY"` with your actual Google Maps API key in the provided code snippets.

This ensures that your Flutter app is properly configured to use the Google Maps API for displaying maps and related functionalities.

## Usage
Once the app is running, you can:
- View the list of events on the Events screen.
- Tap on an event to view its details.
- Tap "View on Map" to see the event location on the Map screen.
- Use the bottom navigation bar to switch between the Events and Map screens.

## Contributing
Contributions to Masr Club are welcome! If you'd like to contribute, please follow these steps:
- Fork the repository.
- Make your changes.
- Submit a pull request, describing the changes you've made.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
