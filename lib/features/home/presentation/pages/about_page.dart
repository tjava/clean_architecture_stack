import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage<dynamic>()
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: const Center(child: Text('Hello from about')),
    );
  }
}
  