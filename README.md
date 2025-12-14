# OrbitHub Based Project

A Flutter application with a placeholder page for Option A section.

## Project Structure

```
lib/
├── main.dart                    # Main application entry point
└── pages/
    └── option_a_page.dart      # Option A placeholder page

test/
├── main_test.dart              # Integration tests for navigation
└── pages/
    └── option_a_page_test.dart # Unit tests for Option A page
```

## Features

- **Option A Page**: A placeholder page that displays centered text "Here is the start page"
- **Navigation**: Home page with section selection (Option A, B, C)
- **Section Isolation**: Option A page is only visible when navigating to Option A section

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)

### Installation

1. Install dependencies:
```bash
flutter pub get
```

2. Run the app:
```bash
flutter run
```

### Testing

Run all tests:
```bash
flutter test
```

Run with coverage:
```bash
flutter test --coverage
```

### Code Analysis

Run static analysis:
```bash
flutter analyze
```

## Implementation Details

### Option A Page

The `OptionAPage` widget implements the placeholder page with:
- Centered text displaying "Here is the start page"
- AppBar with "Option A" title
- Material Design styling with font size 24 and medium font weight
- Proper text alignment (TextAlign.center)

### Navigation

The main app provides:
- Home page with section selection buttons
- Route registration for Option A (`/option-a`)
- Error handling for unavailable sections (Option B, C)

### Test Coverage

The test suite includes:
1. **Widget Tests** (`option_a_page_test.dart`):
   - Text content verification
   - Layout structure validation
   - Styling verification
   - Widget composition tests

2. **Integration Tests** (`main_test.dart`):
   - Navigation flow testing
   - Section visibility validation
   - Route registration verification
   - Multi-section isolation tests

## Acceptance Criteria Coverage

✅ **Scenario 1**: Placeholder page successfully created with centered text  
✅ **Scenario 2**: Page visible in Option A section  
✅ **Scenario 3**: Page not visible in other sections  
✅ **Scenario 4**: Layout matches Option A specifications  
✅ **Scenario 5**: Error handling for wrong section creation

## License

See LICENSE file for details.
