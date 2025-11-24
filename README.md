# Stylistic - Fashion E-commerce Flutter App

A modern, feature-rich Flutter e-commerce application for fashion shopping with a beautiful UI and smooth user experience.

## Features

###  Core Functionality
- **Onboarding Experience**: Beautiful gradient-based onboarding screens with image carousel
- **User Authentication**: Sign in and registration with form validation
- **Product Catalog**: Browse products by categories (Men, Women, Kids, Shoes, Accessories, Beauty, Bags)
- **Product Details**: Detailed product pages with size/color selection and quantity picker
- **Shopping Cart**: Add to cart, manage quantities, and view total
- **Checkout Process**: Complete checkout flow with payment options (Credit Card, COD)
- **Order Confirmation**: Order success page with confirmation details
- **User Profile**: Profile management with order history and settings

###  UI/UX Features
- **Modern Design**: Dark theme with gradient backgrounds and glassmorphism effects
- **Responsive Layout**: Optimized for different screen sizes
- **Smooth Animations**: Page transitions and interactive elements
- **Bottom Navigation**: Easy navigation between Home, Shop, Wishlist, Cart, and Profile
- **Image Carousel**: Product image sliders and promotional banners
- **Search Functionality**: Product search with intuitive interface

### Shopping Features
- **Category Browsing**: 7 main categories with dedicated product listings
- **Product Filtering**: Size and color selection for products
- **Cart Management**: Add, remove, and update cart items
- **Multiple Payment Options**: Credit card and Cash on Delivery
- **Order Tracking**: Order history and status tracking

## Project Structure

```
lib/
├── main.dart              # App entry point and onboarding
├── signin_screen.dart     # User authentication (Sign In)
├── register_screen.dart   # User registration
└── shop_screen.dart       # Main shopping interface and all related screens

assets/
└── images/               # Product images and UI assets
    ├── fashion1.png      # Onboarding images
    ├── fashion2.png
    ├── fashion3.png
    ├── b1.jpeg - b3.jpeg # Banner images
    ├── m1.jpg - m8.jpg   # Men's products
    ├── w1.jpeg - w8.jpeg # Women's products
    ├── k1.jpeg - k8.jpeg # Kids' products
    ├── s1.jpeg - s8.jpeg # Shoes
    ├── a1.jpeg - a8.jpeg # Accessories
    ├── Bags1.jpg - Bags8.jpg # Bags
    └── 1.jpeg - 8.jpeg   # Beauty products
```

## Getting Started

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code
- Android SDK for Android development
- Chrome for web development

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd Stylisticss
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   # For Android
   flutter run
   
   # For Web
   flutter run -d chrome
   
   # For iOS (macOS only)
   flutter run -d ios
   ```

##  Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  get: ^4.7.2                # State management and navigation
  carousel_slider: ^5.0.0    # Image carousels and sliders

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0     # Code linting
```

## App Flow

1. **Onboarding** → User sees 3 introduction screens
2. **Authentication** → Sign in or register
3. **Home/Shop** → Browse categories and featured products
4. **Product Details** → View product info, select options
5. **Cart** → Review selected items
6. **Checkout** → Enter shipping and payment details
7. **Confirmation** → Order success and return to shopping

## Configuration

### Assets Configuration
All images are configured in `pubspec.yaml`:
```yaml
flutter:
  assets:
    - assets/images/fashion1.png
    - assets/images/fashion2.png
    - assets/images/fashion3.png
    # ... (all product images)
```

### Theme Configuration
The app uses a consistent dark theme with:
- Primary colors: Deep blue gradients (#0F0C29, #302B63, #24243E)
- Accent color: Amber (#FFC107)
- Background: Dark gradients
- Text: White and white70 for secondary text

## Development

### Adding New Products
1. Add product images to `assets/images/`
2. Update `pubspec.yaml` to include new assets
3. Add product data to the respective category in `CategoryPage.products`

### Adding New Categories
1. Add category to the `categories` list in `HomeScreenContent`
2. Create product data in `CategoryPage.products`
3. Add corresponding images to assets

### Customizing UI
- Colors: Modify gradient colors in each screen
- Fonts: Update `fontFamily` in `ThemeData`
- Layouts: Adjust padding, margins, and sizing in widget files

## Testing

Run tests using:
```bash
flutter test
```

##  Platform Support

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows (with additional setup)

##  Troubleshooting

### Common Issues

1. **Asset Loading Errors**
   - Ensure all images exist in `assets/images/`
   - Check `pubspec.yaml` asset declarations
   - Run `flutter clean` and `flutter pub get`

2. **Build Errors**
   - Update Flutter: `flutter upgrade`
   - Clean project: `flutter clean`
   - Get dependencies: `flutter pub get`

3. **Performance Issues**
   - Use `flutter run --release` for production builds
   - Optimize images for smaller file sizes

## Deployment

### Android
```bash
flutter build apk --release
# or
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

##  License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

##  Authors

- **Developer** - Initial work and development

##  Acknowledgments

- Flutter team for the amazing framework
- Material Design for UI guidelines
- Community packages used in this project

##  Support

For support and questions:
- Create an issue in the repository
- Contact the development team
- Check Flutter documentation: https://docs.flutter.dev/

---

**Happy Shopping with Stylistic!**
