import 'package:flutter/material.dart';

final Color kanbanYellow = const Color(0xFFFFB300); // Amarillo fuerte, moderno
final Color kanbanCream = const Color(0xFFFFF8ED); // Fondo blanco cálido
final Color kanbanSidebar = const Color(0xFF262626); // Gris oscuro/nearly black
final Color kanbanGreen = const Color(0xFF2ECC40); // Verde acción
final Color kanbanRed = const Color(0xFFFF5252); // Rojo acción

final ThemeData kanbanTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: kanbanYellow,
    primary: kanbanYellow,
    secondary: kanbanGreen,

    surface: Colors.white,
    brightness: Brightness.light,
    error: kanbanRed,
  ),
  scaffoldBackgroundColor: kanbanCream,
  // AppBar/header principal
  appBarTheme: AppBarTheme(
    backgroundColor: kanbanYellow,
    foregroundColor: Colors.black,
    centerTitle: true,
    elevation: 0,
    titleTextStyle: const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
      letterSpacing: 1,
    ),
    iconTheme: const IconThemeData(color: Colors.black),
  ),
  // Sidebar/Menu lateral
  drawerTheme: DrawerThemeData(
    backgroundColor: kanbanSidebar,
    scrimColor: Colors.black26,
  ),
  navigationRailTheme: NavigationRailThemeData(
    backgroundColor: kanbanSidebar,
    selectedIconTheme: IconThemeData(color: kanbanYellow, size: 28),
    unselectedIconTheme: const IconThemeData(color: Colors.white70, size: 24),
    selectedLabelTextStyle: TextStyle(
      color: kanbanYellow,
      fontWeight: FontWeight.bold,
    ),
    unselectedLabelTextStyle: const TextStyle(color: Colors.white54),
  ),
  cardTheme: CardThemeData(
    color: Colors.white,
    elevation: 6,
    shadowColor: Colors.black.withAlpha(18),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: kanbanYellow,
    unselectedItemColor: Colors.black45,
    backgroundColor: Colors.white,
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: true,
    selectedIconTheme: IconThemeData(color: kanbanYellow),
  ),
  chipTheme: ChipThemeData(
    backgroundColor: kanbanYellow.withAlpha(33),
    selectedColor: kanbanGreen.withAlpha(43),
    secondarySelectedColor: kanbanRed.withAlpha(33),
    labelStyle: const TextStyle(color: Colors.black87),
    secondaryLabelStyle: const TextStyle(color: Colors.white),
    padding: const EdgeInsets.symmetric(horizontal: 10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: kanbanYellow,
    foregroundColor: Colors.black,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white.withAlpha(229),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide.none,
    ),
    hintStyle: TextStyle(color: Colors.grey.shade500),
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: 28,
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black87,
      fontSize: 18,
    ),
    bodyLarge: TextStyle(color: Colors.black87),
    labelLarge: TextStyle(color: Colors.black54),
  ),
);
