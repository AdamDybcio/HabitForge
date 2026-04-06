#!/bin/bash

echo "📦 Installing dependencies..."
flutter pub get || exit 1

echo "🔍 Running analyzer..."
flutter analyze || exit 1

echo "🧹 Checking formatting..."
dart format . --set-exit-if-changed || exit 1

echo "🧠 Running custom lint..."
if grep -q custom_lint pubspec.yaml; then
  dart run custom_lint || exit 1
fi

echo "🧪 Running tests..."
flutter test || exit 1

echo "✅ CI passed!"