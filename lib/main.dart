import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_planning/presentation/bloc/auth/auth_bloc.dart';
import 'package:running_planning/presentation/bloc/planning/planning_bloc.dart';
import 'package:running_planning/presentation/bloc/prepa_detail/prepa_detail_bloc.dart';
import 'package:running_planning/presentation/bloc/prepa_list/prepa_list_bloc.dart';
import 'package:running_planning/presentation/bloc/user_race/user_race_bloc.dart';
import 'package:running_planning/presentation/screen/login_screen.dart';
import 'package:running_planning/presentation/screen/planning_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:running_planning/presentation/screen/prepa_detail_screen.dart';
import 'package:running_planning/presentation/screen/prepa_list_screen.dart';
import 'package:running_planning/presentation/screen/race_screen.dart';
import 'core/nav_enum.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/use_cases/auth/auth_use_case.dart';
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr_FR', null);
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AuthBloc>()),
        BlocProvider(
          create: (context) =>
              sl<PlanningBloc>()..add(LoadCalendar(date: DateTime.now())),
        ),
        BlocProvider(create: (context) => sl<UserRaceBloc>()..add(LoadUserRaces(isActiveRaces: true))),
        BlocProvider(
          create: (context) => sl<PrepaListBloc>()..add(LoadPrepaList()),
        ),
      ],
      child: MaterialApp(
        title: 'Training App',
        debugShowCheckedModeBanner: false,
        initialRoute: '/auth',
        routes: {
          '/auth': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
          '/PrepaDetail': (context) {
            final prepaId = ModalRoute.of(context)?.settings.arguments as String;
            return BlocProvider(
              create: (_) => sl<PrepaDetailBloc>()..add(LoadPrepaDetail(prepaId: prepaId)),
              child: PrepaDetailScreen(prepaId: prepaId),
            );
          },
        },
        themeMode: ThemeMode.system,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF607D8B),
            primary: const Color(0xFF546E7A),
            onPrimary: Colors.white,
            primaryContainer: const Color(0xFFCFD8DC),
            onPrimaryContainer: const Color(0xFF37474F),
            secondary: const Color(0xFF78909C),
            onSecondary: Colors.white,
            secondaryContainer: const Color(0xFFECEFF1),
            onSecondaryContainer: const Color(0xFF455A64),
            tertiary: const Color(0xFF90A4AE),
            onTertiary: Colors.white,
            tertiaryContainer: const Color(0xFFE0E0E0),
            onTertiaryContainer: const Color(0xFF424242),
          ),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            scrolledUnderElevation: 4,
            shadowColor: Colors.black26,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
          ),
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
  int _currentIndex = 1;

  final List<NavEnum> _navItem = [
    NavEnum.training,
    NavEnum.planning,
    NavEnum.races,
  ];

  final List<Widget> _pages = [
    PrepaListScreen(),
    PlanningScreen(),
    RacesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_navItem[_currentIndex].label)),
      body: SafeArea(child: _pages[_currentIndex]),
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
            label: 'Prepas',
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
              'assets/icons/cup.svg',
              width: 24,
              height: 24,
            ),
            label: 'Courses',
          ),
        ],
      ),
    );
  }
}
