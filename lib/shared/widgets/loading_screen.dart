import 'package:flutter/material.dart';

import 'loading_indicator.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: LoadingIndicator());
  }
}
