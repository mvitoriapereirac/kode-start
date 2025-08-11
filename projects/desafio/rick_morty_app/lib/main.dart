import 'package:flutter/material.dart';
import 'package:rick_morty_app/dependencies.dart';
import 'package:rick_morty_app/routing/router.dart';
import 'package:provider/provider.dart';


void main() {
  injectDependencies();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: router(context.read(), context.read()));
  }
}
