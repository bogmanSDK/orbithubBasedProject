#!/bin/bash

# Flutter Project Verification Script
# This script verifies the Flutter project setup and runs tests

set -e

echo "======================================"
echo "Flutter Project Verification"
echo "======================================"
echo ""

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed"
    echo "Please install Flutter SDK from https://flutter.dev/docs/get-started/install"
    exit 1
fi

echo "✅ Flutter is installed"
flutter --version
echo ""

# Get dependencies
echo "📦 Installing dependencies..."
flutter pub get
echo ""

# Run static analysis
echo "🔍 Running static analysis..."
flutter analyze
if [ $? -eq 0 ]; then
    echo "✅ Static analysis passed"
else
    echo "❌ Static analysis failed"
    exit 1
fi
echo ""

# Run tests
echo "🧪 Running tests..."
flutter test
if [ $? -eq 0 ]; then
    echo "✅ All tests passed"
else
    echo "❌ Some tests failed"
    exit 1
fi
echo ""

# Run tests with coverage
echo "📊 Running tests with coverage..."
flutter test --coverage
if [ $? -eq 0 ]; then
    echo "✅ Test coverage generated"
    echo "Coverage report available in coverage/lcov.info"
else
    echo "⚠️  Coverage generation failed"
fi
echo ""

echo "======================================"
echo "✅ Verification Complete"
echo "======================================"
