import 'package:bloc_rx_dart/views/download_db.dart';
import 'package:bloc_rx_dart/views/list_message_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: GoRouter(initialLocation: "/download_db", routes: [
          GoRoute(
              path: "/new_feed",
              builder: (BuildContext context, GoRouterState state) {
                return const Scaffold(body: ListMessageView());
              }),
          GoRoute(
              path: "/download_db",
              builder: (BuildContext context, GoRouterState state) {
                return const Scaffold(body: DownloadDB());
              })
        ]));
  }
}
