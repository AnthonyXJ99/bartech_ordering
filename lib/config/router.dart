import 'package:bartech_ordering/presentation/screens/doing/doing_screen.dart';
import 'package:bartech_ordering/presentation/screens/done/done_screen.dart';
import 'package:bartech_ordering/presentation/screens/home/home_screen.dart';
import 'package:bartech_ordering/presentation/widgets/responsive_scaffold.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: "/home",
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        // Determina el índice seleccionado en el NavigationRail
        int selectedIndex = 0;
        final path = state.uri.path;
        if (path.startsWith('/doing')) selectedIndex = 1;
        if (path.startsWith('/done')) selectedIndex = 2;
        return ResponsiveScaffold(
          selectedIndex: selectedIndex,
          child: child, // <- Este es el contenido de la ruta hija
        );
      },
      routes: [
        GoRoute(path: "/home", builder: (context, state) => HomeScreen()),
        GoRoute(path: "/doing", builder: (context, state) => DoingScreen()),
        GoRoute(path: "/done", builder: (context, state) => DoneScreen()),
      ],
    ),
  ],
);
