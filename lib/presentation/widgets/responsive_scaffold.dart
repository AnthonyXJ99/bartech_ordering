import 'package:bartech_ordering/presentation/screens/doing/doing_screen.dart';
import 'package:bartech_ordering/presentation/screens/done/done_screen.dart';
import 'package:bartech_ordering/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResponsiveScaffold extends StatelessWidget {
  final Widget child;
  final int selectedIndex;

  const ResponsiveScaffold({
    super.key,
    required this.child,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 800) {
          // Móvil: BottomNavigationBar y una sola pantalla
          return Scaffold(
            body: child,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (index) {
                switch (index) {
                  case 0:
                    context.go('/home');
                    break;
                  case 1:
                    context.go('/doing');
                    break;
                  case 2:
                    context.go('/done');
                    break;
                }
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.transit_enterexit),
                  label: 'Nuevo',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.open_in_new_rounded),
                  label: 'En Proceso',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.done_all),
                  label: 'Terminado',
                ),
              ],
            ),
          );
        } else if (constraints.maxWidth < 1200) {
          // Tablet: NavigationRail y dos pantallas
          return _buildScaffold(context, 2);
        } else {
          // Desktop: NavigationRail y tres pantallas
          return _buildScaffold(context, 3);
        }
      },
    );
  }

  Widget _buildScaffold(BuildContext context, int columns) {
    final destinations = [
      NavigationRailDestination(
        icon: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: const Icon(Icons.transit_enterexit),
        ),
        label: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: const Text('Nuevo'),
        ),
      ),
      NavigationRailDestination(
        icon: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: const Icon(Icons.open_in_new_rounded),
        ),
        label: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: const Text('En Proceso'),
        ),
      ),
      NavigationRailDestination(
        icon: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: const Icon(Icons.done_all),
        ),
        label: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: const Text('Terminado'),
        ),
      ),
    ];

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            labelType: NavigationRailLabelType.all,
            minExtendedWidth: 72, // o 80, 96, prueba valores

            leading: const SizedBox(height: 24), // espacio arriba
            trailing: const SizedBox(height: 24), // espacio abajo
            onDestinationSelected: (index) {
              switch (index) {
                case 0:
                  context.go('/home');
                  break;
                case 1:
                  context.go('/doing');
                  break;
                case 2:
                  context.go('/done');
                  break;
              }
            },
            destinations: destinations,
          ),
          const VerticalDivider(width: 1),
          Expanded(child: _columnContent(context, columns)),
        ],
      ),
    );
  }

  Widget _columnContent(BuildContext context, int columns) {
    // Toma la ruta actual
    final router = GoRouter.of(context);
    final path = router.routeInformationProvider.value.uri.path;

    final List<Widget> screens = [HomeScreen(), DoingScreen(), DoneScreen()];

    int mainIndex = 0;
    if (path.startsWith('/doing')) mainIndex = 1;
    if (path.startsWith('/done')) mainIndex = 2;

    if (columns == 2) {
      final secondIndex = (mainIndex + 1) % 3;
      return Row(
        children: [
          Expanded(child: screens[mainIndex]),
          const VerticalDivider(width: 1),
          Expanded(child: screens[secondIndex]),
        ],
      );
    } else if (columns == 3) {
      return Row(
        children: [
          Expanded(child: screens[0]),
          const VerticalDivider(width: 1),
          Expanded(child: screens[1]),
          const VerticalDivider(width: 1),
          Expanded(child: screens[2]),
        ],
      );
    } else {
      return child;
    }
  }
}
