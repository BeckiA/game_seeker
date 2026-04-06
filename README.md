# 🎮 Game Seeker

A production-ready Flutter application for exploring games, built with **Clean Architecture** and the **BLoC** state management pattern. This project demonstrates best practices in structure, scalability, and maintainability.

---

## 🏗️ Architecture & Design Patterns

This project follows **Domain-Driven Design (DDD)** and **Clean Architecture** principles to separate concerns into four distinct layers:

### 🏛️ Domain Layer (Core Business)
The heart of the application, containing only pure Dart code:
*   **Entities**: Core data models like `Game` and `Genre`.
*   **Repositories (Interfaces)**: Logical contracts for data access.
*   **Use Cases**: Encapsulated business logic (e.g., `GetGames`, `GetGenres`).

### 🏗️ Infrastructure Layer (External World)
Handles everything external to the application:
*   **Data Sources**: Remote API calls using `Dio`.
*   **Models**: DTOs extending domain entities for JSON serialization.
*   **Repositories (Implementations)**: Adapters linking the API logic to the domain.

### 🧠 Application Layer (State Management)
The brain of the app, using the **BLoC** pattern:
*   **Events**: User inputs or triggers.
*   **States**: Current UI state (Loading, Success, Failure).
*   **Bloc**: Logic engine converting events into states.

### 🎨 Presentation Layer (UI)
The visual representation, built with Flutter widgets, separated into **Pages** and **Widgets**.

---

## 🚀 Getting Started

To get a local copy up and running, follow these steps:

### Prerequisites
*   [Flutter SDK](https://docs.flutter.dev/get-started/install) 
*   A RAWG API key (Get one at [rawg.io](https://rawg.io/apidocs))

### Installation

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/your-username/game_seeker.git
    cd game_seeker
    ```

2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Environment Setup**:
    Create a `.env` file in the root directory:
    ```env
    RAWG_API_KEY=your_api_key_here
    RAWG_BASE_URL=https://api.rawg.io/api
    ```

4.  **Run the application**:
    ```bash
    flutter run
    ```

---

## 🛠️ Built With

*   **Flutter & Dart**: UI development.
*   **flutter_bloc**: State management.
*   **get_it**: Dependency injection.
*   **dio**: Robust HTTP client for API requests.
*   **dartz**: Functional programming for error handling.
*   **flutter_dotenv**: Secure environment configuration.

---

## 📂 Project Structure

```bash
lib/
├── core/               # Shared utilities, errors, and base classes
├── features/           # Independent feature modules
│   └── gaming/         # Main gaming feature
│       ├── application/   # BLoCs
│       ├── domain/        # Entities, Interfaces, UseCases
│       ├── infrastructure/ # Models, Repositories, DataSources
│       └── presentation/  # Pages and Widgets
└── main.dart           # App entry point & initialization
```

---

## 📝 License

Distributed under the MIT License. See `LICENSE` for more information.
