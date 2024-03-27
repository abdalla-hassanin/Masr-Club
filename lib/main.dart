import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:masr_club/app/presentation/manager/event_bloc.dart';
import 'package:masr_club/app/presentation/pages/event_screen.dart';
import 'package:masr_club/app/presentation/pages/home_screen.dart';
import 'package:masr_club/dependency_injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencyInjection();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => GetIt.I<EventBloc>()..add(FetchEvents()),
        child: const HomeScreen(),
      ),
    );
  }
}
