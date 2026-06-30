import 'package:flutter/material.dart';

import '../../../../shared/widgets/empty_state.dart';

class CalendarPlaceholderScreen extends StatelessWidget {
  const CalendarPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calendario')),
      body: const EmptyState(
        title: 'Calendario no implementado',
        message: 'Esta ruta queda preparada para Sprint 2.',
      ),
    );
  }
}
