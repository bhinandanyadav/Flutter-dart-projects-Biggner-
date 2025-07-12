# 🌤️ Weather App - Flutter

A beautiful and modern weather application built with Flutter that provides real-time weather information for cities around the world.

## 📱 Features

- **Real-time Weather Data**: Get current weather conditions using OpenWeatherMap API
- **Beautiful UI**: Modern Material Design 3 with glassmorphism effects
- **Dynamic Backgrounds**: Background images change based on weather conditions
- **City Search**: Search for any city worldwide
- **Weather Details**: Comprehensive weather information including:
  - Temperature (current and feels like)
  - Humidity percentage
  - Wind speed
  - Atmospheric pressure
  - Visibility
- **Responsive Design**: Works on multiple screen sizes
- **Smooth Animations**: Engaging user experience with animations
- **Dark/Light Theme**: Automatic theme switching based on system preference

## 🛠️ Technologies Used

- **Flutter**: Cross-platform UI framework
- **Dart**: Programming language
- **OpenWeatherMap API**: Weather data provider
- **HTTP Package**: For API calls
- **Material Design 3**: Modern UI components

## 📋 Prerequisites

Before running this project, make sure you have:

- **Flutter SDK** (version 3.8.1 or higher)
- **Dart SDK**
- **Android Studio** or **VS Code** with Flutter extensions
- **Git** for version control
- **OpenWeatherMap API Key** (free tier available)

## 🚀 Installation & Setup

### 1. Clone the Repository
```bash
git clone https://github.com/bhinandanyadav/Flutter-dart-projects-Biggner-.git
cd weatherapp
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Get API Key
1. Visit [OpenWeatherMap](https://openweathermap.org/)
2. Sign up for a free account
3. Get your API key from the dashboard
4. Replace the API key in `lib/main.dart`:
   ```dart
   final String _apiKey = 'YOUR_API_KEY_HERE';
   ```

### 4. Run the Application
```bash
# For Linux
flutter run -d linux

# For Android
flutter run -d android

# For iOS
flutter run -d ios

# For Web
flutter run -d chrome
```

## 📁 Project Structure

```
weatherapp/
├── lib/
│   ├── main.dart              # Main application file
│   └── assets/
│       └── images/            # Weather background images
│           ├── clear.jpg
│           ├── cloudy.jpg
│           ├── default.jpg
│           ├── foggy.jpg
│           ├── rainy.jpg
│           ├── snow.jpg
│           └── stromy.jpg
├── android/                   # Android-specific files
├── ios/                      # iOS-specific files
├── linux/                    # Linux-specific files
├── web/                      # Web-specific files
├── windows/                  # Windows-specific files
├── macos/                    # macOS-specific files
├── test/                     # Test files
├── pubspec.yaml              # Dependencies and assets
└── README.md                 # This file
```

## 🔧 How It Works

### 1. **API Integration**
- The app uses OpenWeatherMap API to fetch weather data
- HTTP requests are made to: `https://api.openweathermap.org/data/2.5/weather`
- Weather data includes temperature, humidity, wind speed, pressure, and visibility

### 2. **UI Components**
- **AppBar**: Contains the app title and search button
- **Search Dialog**: Modal dialog for city search with Hindi text
- **Weather Display**: Shows current weather with animations
- **Weather Details Card**: Glassmorphism card with weather metrics
- **Background Images**: Dynamic backgrounds based on weather conditions

### 3. **State Management**
- Uses Flutter's built-in `StatefulWidget` for state management
- Manages loading states, error handling, and weather data

### 4. **Responsive Design**
- `SingleChildScrollView` prevents overflow issues
- Responsive layout that adapts to different screen sizes
- Proper padding and spacing for optimal viewing

## 🎨 UI Features

### Weather Icons
- Dynamic weather icons based on conditions:
  - ☀️ Clear weather
  - ☁️ Cloudy weather
  - 🌧️ Rainy weather
  - ⚡ Thunderstorm
  - ❄️ Snow
  - 🌫️ Fog/Mist

### Background Images
- Background changes based on weather conditions
- Glassmorphism effect with backdrop blur
- Gradient overlay for better text readability

### Animations
- Temperature counter animation
- Fade-in animations for weather data
- Smooth transitions between states

## 🔑 API Configuration

The app uses the OpenWeatherMap API with the following parameters:
- **Base URL**: `https://api.openweathermap.org/data/2.5/weather`
- **Units**: Metric (Celsius)
- **Language**: English
- **Required Parameters**: 
  - `q`: City name
  - `appid`: Your API key
  - `units`: metric

## 🐛 Troubleshooting

### Common Issues

1. **API Key Error**
   - Ensure your OpenWeatherMap API key is valid
   - Check if you've exceeded the free tier limits

2. **Asset Loading Error**
   - Verify that all images are in `lib/assets/images/`
   - Check `pubspec.yaml` for correct asset paths

3. **Build Errors**
   - Run `flutter clean` and `flutter pub get`
   - Ensure Flutter SDK is up to date

4. **Platform-specific Issues**
   - For Linux: Install required dependencies
   - For Android: Set up Android SDK
   - For iOS: Use macOS with Xcode

## 📱 Screenshots

<div align="center">

### Main Weather Display
<img width="1366" height="768" alt="screen1" src="https://github.com/user-attachments/assets/6b70e719-d302-4c69-b309-f35b2c44ca2f" />
<img src="lib/screenshot/screen1.png" alt="Weather App Main Screen" width="300"/>

### City Search Feature
<img width="1366" height="768" alt="placename" src="https://github.com/user-attachments/assets/ba9d5bd5-20fc-4341-b0a8-228daa83cd7f" />
<img src="lib/screenshot/placename.png" alt="City Search Dialog" width="300"/>

### Weather Details View
<img width="1366" height="768" alt="screen2" src="https://github.com/user-attachments/assets/d58355c5-8612-45bf-a556-a2304db1fab1" />
<img src="lib/screenshot/screen2.png" alt="Weather Details Screen" width="300"/>

</div>

The app features:
- Clean, modern interface with glassmorphism effects
- Dynamic weather backgrounds that change based on conditions
- Comprehensive weather information including temperature, humidity, wind speed
- Smooth animations and transitions for better user experience
- City search functionality with intuitive UI
- Responsive design that works across different screen sizes

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 👨‍💻 Author

**Abhinandan Yadav**
- GitHub: [@bhinandanyadav](https://github.com/bhinandanyadav)

## 🙏 Acknowledgments

- [OpenWeatherMap](https://openweathermap.org/) for providing weather data API
- [Flutter](https://flutter.dev/) team for the amazing framework
- [Material Design](https://material.io/) for design guidelines

## 📞 Support

If you encounter any issues or have questions:
1. Check the troubleshooting section above
2. Open an issue on GitHub
3. Contact the author

---

⭐ **Star this repository if you found it helpful!**
