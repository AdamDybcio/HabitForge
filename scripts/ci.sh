#!/bin/bash
# Simulate GitHub Actions Flutter CI locally
# Stops on first failure (like GH Actions)

set -e  # exit on any error
echo "Starting local Flutter CI simulation..."

# Check if we are in a Flutter project
if [ ! -f "pubspec.yaml" ]; then
  echo "❌ pubspec.yaml not found! Are you in a Flutter project root?"
  exit 1
fi

echo "✅ pubspec.yaml found"

# --- Get dependencies ---
echo "📦 Getting dependencies..."
flutter pub get

# --- Run static code analysis ---
echo "🔍 Running Dart analyzer..."
flutter analyze

# --- Run custom lint ---
if command -v dart &> /dev/null; then
  echo "📝 Running custom_lint..."
  dart run custom_lint
else
  echo "⚠️ Dart not found, skipping custom_lint"
fi

# --- Check formatting ---
echo "🎨 Checking code formatting..."
dart format . --set-exit-if-changed

# --- Run tests ---
if [ -d "test" ]; then
  echo "🧪 Running tests..."
  flutter test -r expanded
else
  echo "⚠️ No test folder found, skipping tests"
fi

echo "✅ Local Flutter CI simulation passed!"