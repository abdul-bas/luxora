# LUXORA

LUXORA is a Flutter-based shopping application built as part of a Flutter development assessment.

The app allows users to browse products, explore categories and brands, search for products, view product details, and load more products while scrolling.

## Features

- 🛍️ Product browsing
- 🔍 Product search
- 🏷️ Category filtering
- 🏢 Brand display
- 📦 Product details
- ⭐ Product ratings
- 💰 Discounted and original prices
- 🖼️ Product images
- ♾️ Infinite scrolling
- 📱 Responsive product grid
- 🎨 Clean and simple UI
- 🧭 Named route navigation
- 📡 REST API integration
- 🔄 Dynamic product loading

## Screens

- Splash Screen
- Login Screen
- Home Screen
- Categories Screen
- Search Screen
- Product Details Screen

## Tech Stack

- Flutter
- Dart
- Provider
- REST API
- HTTP
- SharedPreferences
- Firebase
- Material Design

## Project Structure

The project is organized using an MVVM-style structure to keep the UI, business logic, data models, and API handling separate.

```text
lib/
│
├── core/
│   ├── constants/
│   ├── routing/
│   ├── theme/
│   └── utils/
│
├── models/
│   ├── product_model.dart
│   ├── category_model.dart
│   └── brand_model.dart
│
├── services/
│   └── api_service.dart
│
├── viewmodels/
│   ├── auth_viewmodel.dart
│   ├── home_view_model.dart
│   └── product_details_model.dart
│
├── views/
│   ├── auth/
│   ├── categories_view/
│   ├── home/
│   ├── search_view/
│   └── splash_view/
│
├── firebase_options.dart
└── main.dart
