import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_planning/presentation/bloc/auth/auth_bloc.dart';
import 'package:running_planning/presentation/screen/login_screen.dart';
import 'package:running_planning/presentation/screen/planning_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'domain/repositories/auth_repository.dart';
import 'domain/use_cases/auth/auth_use_case.dart';
import 'injection_container.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Training App',
        debugShowCheckedModeBanner: false,
        initialRoute: '/auth',
        routes: {
            '/auth': (context) => const LoginScreen(),
            '/home': (context) => const HomeScreen(),
        },
        themeMode: ThemeMode.system,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
          appBarTheme: const AppBarTheme(centerTitle: true),
        ),
        //home: const HomeScreen()
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const Center(child: Text('Planning')),
    const Center(child: Text('Profil')),
    const Center(child: Text('Entrainement')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Planning')),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/dumbbell.svg',
              width: 24,
              height: 24,
            ),
            label: 'Entrainement',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/calendar.svg',
              width: 24,
              height: 24,
            ),
            label: 'Planning',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/profile.svg',
              width: 24,
              height: 24,
            ),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

