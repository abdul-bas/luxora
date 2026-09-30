# Luxora

Luxora is a shopping app I built in Flutter for a development assessment. You can browse products, filter by category, search, open a product to see its details, and keep scrolling to load more items.

I wanted to keep the code easy to follow, so I kept the structure simple and used Provider for state management.

## What it does

- Browse products in a grid that adapts to the screen size
- Search products by name
- Filter by category and see the brand on each product
- Open a product to see its images, price, discount, rating and stock
- Load more products as you scroll instead of loading everything at once
- Log in with Firebase
- Move between screens with named routes

## Screens

- Splash
- Login
- Home
- Categories
- Search
- Product details

## Built with

- Flutter and Dart
- Provider for state management
- http for API calls
- SharedPreferences for saving small bits of local data
- Firebase for authentication

## How the code is organised

I used a simple MVVM-style layout so the UI, logic and data don't get mixed together.

```text
lib/
├── core/
│   ├── constants/
│   ├── routing/
│   ├── theme/
│   └── utils/
├── models/
│   ├── product_model.dart
│   ├── category_model.dart
│   └── brand_model.dart
├── services/
│   └── api_service.dart
├── viewmodels/
│   ├── auth_viewmodel.dart
│   ├── home_view_model.dart
│   └── product_details_model.dart
├── views/
│   ├── auth/
│   ├── categories_view/
│   ├── home/
│   ├── search_view/
│   └── splash_view/
├── firebase_options.dart
└── main.dart
```

Views only show things and pass user actions to the view models. The view models hold the state and talk to `api_service.dart`, which is the only place that makes network requests.

## API

Product data comes from the free [DummyJSON](https://dummyjson.com/products) API. Each product includes a title, description, category, brand, price, discount, rating, stock and images.

## Infinite scrolling

The app loads products in small batches using the `limit` and `skip` parameters:

```text
https://dummyjson.com/products?limit=10&skip=0    -> products 1-10
https://dummyjson.com/products?limit=10&skip=10   -> products 11-20
https://dummyjson.com/products?limit=10&skip=20   -> products 21-30
```

When you scroll close to the bottom, the next batch is fetched and added to the list.

## Routes

```text
/splash
/login
/home
/categories
/search
/product-details
```

## Running it

You'll need the Flutter SDK and either an emulator or a physical Android device. Run `flutter doctor` first if you aren't sure your setup is fine.

```bash
git clone https://github.com/abdul-bas/luxora.git
cd luxora
flutter pub get
flutter run
```

The Firebase config in `firebase_options.dart` is tied to my project. To use your own, run `flutterfire configure` and it will generate a new one.

## Why I built it

This project was a chance to practice the things I use most in Flutter: building UI, managing state, calling an API, searching and filtering, pagination, and navigation.

## Author

Abdul Basith, Flutter developer

- GitHub: [abdul-bas](https://github.com/abdul-bas)
- LinkedIn: [abdul-basith](https://www.linkedin.com/in/abdul-basith-chempan-b17b09324/)
