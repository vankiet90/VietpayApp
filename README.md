# VietpayApp Currency Converter

A production-ready Flutter application demonstrating an Offline-First architecture.

## Features

- Fetch latest exchange rates from CurrencyFreaks API
- Offline-first using Drift Database
- Currency Converter
- Saved Currency Dashboard
- Material 3
- Dark / Light Theme
- MVVM + Repository + BLoC
- Dependency Injection using GetIt

---

## Architecture

```
lib

app/

core/
    api/
    database/
    di/
    theme/

features/
    currency/
        bloc/
        datasource/
            remote/
            local/
        mapper/
        models/
        repository/
        pages/
        widgets/
```

---

## Tech Stack

- Flutter 3.32
- Dart 3.8
- flutter_bloc
- Dio
- Drift
- SQLite
- GetIt
- Logger
- flutter_dotenv

---

## Offline First

Application flow

```
Launch App

↓

API

↓

Success

↓

Save Drift

↓

Show UI

↓

Offline

↓

Load Drift

↓

Show Cached Data
```

---

## Theme

Supports

- Material 3
- Dark Mode
- Light Mode

---

## Run

Clone

```
git clone ...
```

Install

```
flutter pub get
```

Generate Drift

```
dart run build_runner build
```

Run

```
flutter run
```

---

## Environment

Create

```
.env
```

```
API_KEY=YOUR_API_KEY
BASE_URL=https://api.currencyfreaks.com/v2.0
```

---

## Git History

```
Initial Flutter project

Setup application foundation

Implement remote API layer

Implement offline cache with Drift

Integrate BLoC state management

Build currency converter dashboard

Implement currency conversion feature

Add Material 3 theme support
```
