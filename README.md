# HireHub

![Build Status](https://github.com/popatnandan2136/simbiotiktask/actions/workflows/flutter_ci.yml/badge.svg)

HireHub is an enterprise-grade job discovery and management mobile application built using Flutter and GetX state management. It connects directly with the live Arbeitnow job board API, parsing job vacancies, and enabling persistent local bookmarking and navigation transitions.

---

## Architecture & State Isolation

The project is structured under **Clean Architecture** patterns separated by feature layers:

- **State Management**: Fully reactive state isolation using **GetX**. Direct layout mutations or `setState` are strictly avoided.
- **Dependency Injection**: Injected business logic controllers decoupled from UI views.
- **Local Persistence**: Bookmark states are persistently synchronized across launches using **SharedPreferences**.
- **Exception Interception**: The network service layer intercepts exceptions (`SocketException`, `TimeoutException`, `FormatException`) to render fallback reload elements instead of causing engine layout crashes.

---

## Directory Architecture

```
lib/
├── core/
│   ├── constants/  # App colors and configuration tokens
│   ├── theme/      # Custom branding ThemeData using Poppins Font
│   └── routes/     # Routing table & transition mappings
├── models/         # Strictly-typed JobModel serializers
├── services/       # Resilient HTTP ApiService network interface
├── controllers/    # Business logic GetxControllers
├── views/          # Views separated by module folders
│   ├── splash/
│   ├── dashboard/
│   └── detail/
├── widgets/        # Decoupled reusable widgets (Shimmer, error states)
└── main.dart       # Main app bootstrapper
```

---

## CI/CD Automation

This project incorporates automated integration and delivery pipelines powered by **GitHub Actions**:

### 1. Continuous Integration (`flutter_ci.yml`)
Runs on every **push** or **pull request** targeting the `main` branch:
1. Checks out repository files.
2. Installs Java 17 Zulu JDK.
3. Sets up the latest stable Flutter SDK.
4. Restores package dependencies (`flutter pub get`).
5. Checks code quality (`flutter analyze`).
6. Executes automated unit and widget test cases (`flutter test`).
7. Compiles the release binary (`flutter build apk --release`).
8. Uploads the built `app-release.apk` as a secure GitHub Artifact (retained for 30 days).

### 2. Continuous Delivery & Releases (`release.yml`)
Runs automatically when a **GitHub Release** is created:
1. Compiles the optimized production release APK.
2. Automatically uploads and attaches the `hirehub-release.apk` binary directly to the created GitHub Release asset list for direct deployment.

---

## Branch Strategy

The project development follows a structured branching workflow:

- `main`: Production-ready release branch.
- `develop`: Pre-production staging and integration branch.
- `feature/*`: Atomic feature scopes (e.g., `feature/search`, `feature/bookmarks`, `feature/ui`). All feature branches must submit PRs to merge, running the CI pipeline verification beforehand.

---

## How to Download APK Artifacts

### From GitHub Actions (CI Builds)
1. Navigate to the [GitHub Actions tab](https://github.com/popatnandan2136/simbiotiktask/actions).
2. Click on the most recent successful run of the **Flutter CI** workflow.
3. Scroll down to the **Artifacts** section at the bottom of the summary page.
4. Click on **`hirehub-release-apk`** to download the compiled ZIP containing the APK.

### From GitHub Releases (Production Builds)
1. Go to the [Releases page](https://github.com/popatnandan2136/simbiotiktask/releases).
2. Look at the latest version tag.
3. Under the **Assets** dropdown, click **`hirehub-release.apk`** to install it directly on your Android device.
