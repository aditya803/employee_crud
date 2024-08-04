# Employee CRUD Application

This is a Flutter application for managing employee data, allowing users to perform CRUD (Create, Read, Update, Delete) operations. It uses the Cosmocloud API for data management.

## Features

- Add new employees
- View employee details
- Update employee information
- Delete employees
- Responsive UI for both web and mobile platforms

## Prerequisites

Ensure you have the following installed:

- [Flutter](https://flutter.dev/docs/get-started/install) (latest stable version)
- [Dart](https://dart.dev/get-dart) (comes with Flutter)

## Getting Started

Follow these steps to set up and run the project locally:

### Clone the Repository

```bash
git clone https://github.com/aditya803/employee_crud.git
cd employee_crud
```

### Install Dependencies

Run the following command to install the required packages:

```bash
flutter pub get
```

### Configure the API

Make sure to configure the API endpoints in `lib/services/api_service.dart` to match your Cosmocloud API settings.

### Run the Application

To run the application on an emulator or connected device, use:

```bash
flutter run
```

To run the web version, use:

```bash
flutter run -d chrome
```

### Running Tests

To run tests for the application, use:

```bash
flutter test
```

## Folder Structure

- `lib/screens/` - Contains the UI screens for the application.
- `lib/models/` - Contains data models for employees and contacts.
- `lib/services/` - Contains the API service for data handling.
- `lib/widgets/` - Contains reusable widgets.


---
