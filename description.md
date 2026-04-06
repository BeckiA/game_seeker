# Game Seeker: Architecture & Patterns

This document explains the architecture and design patterns used in the **Game Seeker** Flutter project. The primary goal is to ensure the app is scalable, testable, and maintainable by separating concerns through **Clean Architecture** and the **BLoC** pattern.

---

## 1. Layers of Protection (Architecture)

Think of your app like an onion. The core (center) is the most important part, and each layer outwards depends on the one inside it, while inner layers remain independent of the outer ones.

### 🏛️ Domain Layer (The Heart)
*   **Purpose**: This is where your **Business Logic** lives. It describes *what* your app does, but not *how*. It contains only pure Dart code with no dependencies on APIs or UI.
*   **Key Components**:
    *   **Entities (`game.dart`, `genre.dart`)**: Simple data classes representing core concepts (e.g., a "Game" or a "Genre").
    *   **Repositories (Interfaces) (`i_gaming_repository.dart`)**: Contracts that define what data is needed without specifying where it comes from.
    *   **Use Cases (`get_games.dart`)**: Encapsulate specific business rules or tasks (e.g., "Get games for a specific category").

### 🏗️ Infrastructure Layer (The Workers)
*   **Purpose**: This layer handles the **External World** (APIs, Databases). It implements the contracts defined in the Domain layer.
*   **Key Components**:
    *   **Models (`game_model.dart`)**: Data Transfer Objects (DTOs) that extend Entities and handle JSON serialization (`fromJson`).
    *   **Data Sources (`gaming_remote_data_source.dart`)**: Raw network logic using packages like `Dio`.
    *   **Repository Implementations (`gaming_repository_impl.dart`)**: Adapters that coordinate data flow between data sources and the domain layer.

### 🧠 Application Layer (The Brains - BLoC)
*   **Purpose**: The bridge between the UI and logic. It manages the **Application State**.
*   **Key Concept (BLoC)**: 
    *   **Events**: Inputs (e.g., "User clicked Load").
    *   **States**: Outputs (e.g., "Loading," "Error," or "Loaded").
    *   **Bloc**: The logic engine that converts Events into States.
*   **Key Files**: `AllGamesBloc`, `CategoryBloc`, `CategoryGamesBloc`.

### 🎨 Presentation Layer (The Face)
*   **Purpose**: Pure **Flutter Widgets**. This layer only cares about how things look.
*   **Key Components**:
    *   **Pages**: Main screens (e.g., `GamingHomePage`).
    *   **Widgets**: Reusable UI components (e.g., `GameCard`, `HeaderWidget`).

---

## 2. Technical Flow of Data

When a user interacts with the app, the data flows through the layers in a specific order:

1.  **UI**: The user triggers an `Event` (e.g., `LoadAllGames`).
2.  **BLoC**: Receives the event, emits a `LoadingState`, and calls a **Use Case**.
3.  **Use Case**: Calls the **Repository Interface**.
4.  **Repository**: The implementation fetches data from a **Data Source**.
5.  **Data Source**: Makes an HTTP request and gets JSON.
6.  **Return Path**:
    *   JSON → **Model** → **Entity**.
    *   The Repository returns an `Either<Failure, Success>`.
    *   The BLoC receives the result and emits the corresponding `State`.
    *   **UI**: Rebuilds automatically to show the data.

---

## 3. Core Tools & Patterns

### 🛠️ Dependency Injection (`get_it`)
We use `get_it` (configured in `lib/injection_container.dart`) to manage object creation. Instead of creating instances manually, we "ask" the container for them. This makes the code decoupled and much easier to test.

### 🛡️ Functional Error Handling (`dartz`)
Instead of risky `try/catch` blocks, we use the `Either` type. This forces us to explicitly handle both the **Failure** and **Success** cases, preventing unexpected crashes.

### 🌊 Environment Management
Sensitive data like API keys and URLs are stored in a `.env` file (managed by `flutter_dotenv`) and are never hardcoded into the source code.

---

## Summary: Why this architecture?
Although it involves more files than a simple project, the benefits are:
*   **Separation of Concerns**: Changing the UI doesn't break the logic. 
*   **Scalability**: New features can be added without affecting existing ones.
*   **Testability**: Every layer can be tested in isolation.