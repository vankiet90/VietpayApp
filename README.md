# Vietpay Currency Converter

A production-ready Flutter application built for the Vietpay Mobile Technical Assessment.

The application demonstrates an **Offline-First Architecture**, allowing users to continue viewing the latest cached exchange rates when the network is unavailable.

---

# Features

- Fetch real-time exchange rates from CurrencyFreaks API
- Offline-first architecture using Drift (SQLite) with insert-or-replace cache strategy
- Automatic fallback to cached data when offline
- Currency converter with live calculation
- Saved Currency dashboard (JPY → USD)
- Last Updated timestamp
- Material 3 UI
- Dark Mode & Light Mode support
- MVVM + Repository + BLoC architecture
- Dependency Injection with GetIt
- Unit Test, Bloc Test and Widget Test

---

# Architecture

```
lib
├── app
│
├── core
│   ├── api
│   ├── config
│   ├── database
│   ├── di
│   └── theme
│
└── features
    └── currency
        ├── bloc
        ├── datasource
        │   ├── local
        │   └── remote
        ├── mapper
        ├── models
        ├── pages
        ├── repository
        └── widgets
```

---

# Dependency Flow

```
UI
 |
BLoC
 |
Repository
 |
+----------------+
|                |
Remote       Local
DataSource   DataSource
 |
Dio          Drift
```

---


# Tech Stack

| Technology | Usage |
|------------|-------|
| Flutter 3.32 | UI Framework |
| Dart 3.8 | Programming Language |
| flutter_bloc | State Management |
| Dio | Networking |
| Drift (SQLite) | Local Database |
| GetIt | Dependency Injection |
| Logger | Logging |
| flutter_dotenv | Environment Configuration |
| mocktail | Unit Testing |
| bloc_test | Bloc Testing |
| flutter_test | Widget Testing |

---

# Offline-First Flow

```
Application Launch
        │
        ▼
Load Local Cache
        │
        ▼
Display Cached Data
        │
        ▼
Fetch Latest Rates
        │
 ┌──────┴──────┐
 │             │
 ▼             ▼
Success      Failed
 │             │
 ▼             ▼
Update Cache  Keep Existing Cache
 │
 ▼
Refresh UI
```

When the device is offline:

- The application loads the latest cached exchange rates from Drift.
- A **Using Cached Data** banner is displayed.
- The **Last Updated** timestamp shows when the cache was saved.

---

# Testing

The project includes:

- Repository unit tests
- BLoC state tests
- Widget interaction tests

Run all tests:

```bash
flutter test
```

---

# Getting Started

### Clone the repository

```bash
git clone <repository-url>
```

### Install dependencies

```bash
flutter pub get
```

### Generate Drift files

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Run the application

```bash
flutter run
```

---

# Environment

Create a `.env` file in the project root.

```text
API_KEY=YOUR_API_KEY
BASE_URL=https://api.currencyfreaks.com/v2.0
```

---

# Development History

Major milestones:

- Initial Flutter project setup
- Configure project architecture
- Integrate CurrencyFreaks API
- Implement Drift local database
- Add Offline-First repository
- Implement MVVM + BLoC
- Build Currency Converter UI
- Support Material 3 & Dynamic Theme
- Add Repository Tests
- Add Bloc Tests
- Add Widget Tests

---

# License

This project was created for the **Vietpay Mobile Technical Assessment** and is intended for demonstration purposes.