# Flutter Article App

A Flutter app that fetches and displays a list of articles from a public
API.

## Features

- List of articles
- Search functionality
- Detail view
- Responsive UI

## Setup Instructions

1. Clone the repo:
   git clone <https://github.com/KTAN675/bharatnxt_article_app>
   cd flutter_article_app
2. Install dependencies:
   flutter pub get
3. Run the app:
   flutter run

## Tech Stack

- Flutter SDK: [Version]
- State Management: [Provider.]
- HTTP Client: [http]
- Persistence: [shared_preferences]

## State Management Explanation

[The app uses the `Provider` package for state management due to its simplicity and efficiency in
managing widget rebuilds. The `ArticleProvider` class handles fetching articles from the API,
filtering them based on search input, managing favorite items, and updating UI through
`notifyListeners()`. This makes the app reactive and modular, separating logic from UI.
]

## Known Issues / Limitations

[- No pagination: All articles are fetched at once, which may not scale well with large datasets.
- Uses static API (`jsonplaceholder.typicode.com`) that doesn’t update or support dynamic content.
- UI design is basic and can be improved with animations or better responsive handling on tablets.
]

