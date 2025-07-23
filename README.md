# ⌚ WhatToWatch – Recomendador diario para Apple Watch

WhatToWatch es una app desarrollada para watchOS que te sugiere **una película o serie diferente cada día**, basada en los datos de [The Movie Database (TMDb)](https://www.themoviedb.org/). Diseñada para ser rápida, intuitiva y útil directamente desde tu muñeca.

## ✨ Características principales

- 📺 Elige entre series o películas al abrir la app.
- 🔄 Obtén una recomendación aleatoria y popular desde TMDb.
- 📝 Lee la sinopsis, puntuación, fecha de estreno y géneros.
- ⭐ Guarda tus títulos favoritos con un toque (¡y animación de estrella incluida!).
- 🧑‍🤝‍🧑 Consulta el reparto principal con fotos.
- ⏱️ Complicación para ver la recomendación diaria directamente en la carátula del reloj.
- 📚 Historial de recomendaciones recientes.

## 🧠 Tecnologías utilizadas

- `SwiftUI`
- `WidgetKit` para la complicación
- `URLSession` y `Codable` para llamadas a la API
- `UserDefaults` para almacenamiento persistente
- API pública de TMDb

## 📦 Estructura

- `ContentView.swift`: Vista principal con selector de tipo y recomendación aleatoria.
- `DetailView.swift`: Sinopsis completa y reparto con fotos.
- `FavoritesView.swift`: Sección de favoritos guardados.
- `WhatToWatchApp.swift`: Punto de entrada y configuración de entornos.
- `WhatToWatchComplication.swift`: Implementación de la complicación de watchOS.
- `TMDbService.swift`: Encapsula las llamadas a la API de TMDb.
- `FavoritesManager.swift`: Gestión de favoritos.
- `RecommendationHistoryManager.swift`: Historial local.
- `TMDbItem.swift`: Modelo de datos compatible con TMDb.

## 🚀 Próximas funciones

- 🎥 Vista previa del tráiler usando `AVKit`.
- 🔍 Búsqueda manual y filtrado por género o plataforma.
- 📱 Sincronización con iPhone (versión futura).

## 🔐 API

Esta app utiliza la API de TMDb. Es necesario registrar una cuenta gratuita y generar una API key desde:
[https://www.themoviedb.org/settings/api](https://www.themoviedb.org/settings/api)

---

# ⌚ WhatToWatch – Daily Recommendation for Apple Watch

**WhatToWatch** is a watchOS app that gives you **a new movie or TV show recommendation every day**, powered by [The Movie Database (TMDb)](https://www.themoviedb.org/). Designed to be quick, elegant, and useful directly on your wrist.

## ✨ Features

- 📺 Choose between TV shows or movies.
- 🔄 Get a popular random suggestion via TMDb.
- 📝 View synopsis, rating, release date, and genre.
- ⭐ Tap to add/remove favorites (with animated star!).
- 🧑‍🤝‍🧑 See main cast with actor photos.
- ⏱️ Complication support: see daily pick on your watch face.
- 📚 Local history of recent picks.

## 🧠 Tech Stack

- `SwiftUI`
- `WidgetKit` for the complication
- `URLSession` + `Codable` for API calls
- `UserDefaults` for persistence
- TMDb's free API

## 📦 App Structure

- `ContentView.swift`: Main entry with type selector and random pick.
- `DetailView.swift`: Synopsis and cast view.
- `FavoritesView.swift`: Saved favorites.
- `WhatToWatchApp.swift`: App setup and environment injection.
- `WhatToWatchComplication.swift`: Widget implementation.
- `TMDbService.swift`: Network layer.
- `FavoritesManager.swift`: Favorite state management.
- `RecommendationHistoryManager.swift`: History tracking.
- `TMDbItem.swift`: Unified model for TMDb content.

## 🚀 Upcoming

- 🎥 Trailer previews using `AVKit`.
- 🔍 Manual search and filtering by genre/platform.
- 📱 iPhone support and sync (future version).

## 🔐 API

This app uses the TMDb API. You need a free account and API key from:
[https://www.themoviedb.org/settings/api](https://www.themoviedb.org/settings/api)

---

© 2025 Dorjee
