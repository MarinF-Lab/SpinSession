import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/router/app_routes.dart';

enum AppTab { calendario, estudio, registro, ajustes }

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key, required this.current});

  final AppTab current;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: current.index,
      onDestinationSelected: (index) => _navigate(context, AppTab.values[index]),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.calendar_today_outlined),
          selectedIcon: Icon(Icons.calendar_today),
          label: 'Calendario',
        ),
        NavigationDestination(
          icon: Icon(Icons.videocam_outlined),
          selectedIcon: Icon(Icons.videocam),
          label: 'Estudio',
        ),
        NavigationDestination(
          icon: Icon(Icons.group_outlined),
          selectedIcon: Icon(Icons.group),
          label: 'Registro',
        ),
        NavigationDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
          label: 'Ajustes',
        ),
      ],
    );
  }

  void _navigate(BuildContext context, AppTab tab) {
    if (tab == current) return;
    final route = switch (tab) {
      AppTab.calendario => AppRoutes.calendar,
      AppTab.estudio => AppRoutes.estudioTab,
      AppTab.registro => AppRoutes.registroTab,
      AppTab.ajustes => AppRoutes.settings,
    };
    context.go(route);
  }
}
