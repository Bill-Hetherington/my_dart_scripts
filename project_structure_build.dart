import 'dart:io';
import 'dart:core';

///Usage: just call this script in the destination you want the folder structure made 
///e.g dart run ../my_dart_scripts/project_structure_build.dart
void main() {
  final rootDir = Directory.current.path; // Gets the directory where the script was called
  print('Running in: $rootDir');

  // Root directories
  final directories = [
    '$rootDir/lib/data',
    '$rootDir/lib/domain',
    '$rootDir/lib/routing',
    '$rootDir/lib/ui',
    '$rootDir/lib/ui/core',
    '$rootDir/lib/ui/core/shared_widgets',
    '$rootDir/lib/ui/core/theme',
    '$rootDir/lib/ui/pages',
    '$rootDir/lib/ui/pages/home',
    '$rootDir/lib/ui/pages/home/view_model',
    '$rootDir/lib/ui/pages/home/widgets',
  ];

// Files to create
  final files = {
    '$rootDir/lib/routing/route_generator.dart': _routeGeneratorContent,
    '$rootDir/lib/routing/route_names.dart': _routeNamesContent,
    '$rootDir/lib/ui/core/shared_widgets/route_error_screen.dart': _routeErrorScreenContent,
    '$rootDir/lib/ui/core/theme/default_theme.dart': _defaultThemeFile,
    '$rootDir/lib/ui/pages/home/home_page.dart': _homePageContent,
    '$rootDir/lib/ui/pages/home/view_model/home_page_view_model.dart': _homePageViewModelContent,
    '$rootDir/lib/main.dart': _mainDartFile,
    '$rootDir/lib/main_staging.dart': _mainStagingDartFile,
  };

  print('Creating project structure...');

  // Create directories
  for (final dir in directories) {
    Directory(dir).createSync(recursive: true);
    print('Created directory: $dir');
  }

  // Create files
  files.forEach((path, content) {
    File(path).writeAsStringSync(content);
    print('Created file: $path');
  });

  print('\nProject structure generated successfully!');
}

const String _routeNamesContent = '''
class RouteNames {
  static const String homePage = 'home_page';
}
''';

const String _routeGeneratorContent = '''
import 'package:flutter/material.dart';

import '../ui/core/shared_widgets/route_error_screen.dart';
import '../ui/pages/home/home_page.dart';
import 'route_names.dart';

class RouteGenerator {
  static final RouteObserver<ModalRoute<void>> routeObserver =
      RouteObserver<ModalRoute<void>>();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.homePage:
        return MaterialPageRoute(builder: (_) => HomePage());
      default:
        return MaterialPageRoute(builder: (_) => RouteErrorScreen());
    }
  }
}

''';

const String _routeErrorScreenContent = '''
import 'package:flutter/material.dart';

class RouteErrorScreen extends StatelessWidget {
  const RouteErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
        child: Center(
          child: Text(
            "Incorrect Route please restart App",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
''';

const String _defaultThemeFile = '''
import 'package:flutter/material.dart';

ThemeData defaultTheme() {
  return ThemeData(  
  );
}
''';

const String _homePageContent = '''
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      body: Placeholder(),
    );
  }
}
''';

const String _homePageViewModelContent = '''
import 'package:flutter/material.dart';

class HomePageViewModel extends ChangeNotifier {
  
}
''';

const String _mainDartFile='''
import 'package:flutter/material.dart';

import 'routing/route_generator.dart';
import 'routing/route_names.dart';
import 'ui/core/theme/default_theme.dart';

void main() {
  runApp(
   const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: <NavigatorObserver>[RouteGenerator.routeObserver],
      title: 'Add Title',
      theme: defaultTheme(),
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: RouteNames.homePage,
    );
  }
}

''';

const String _mainStagingDartFile='''
import 'package:flutter/material.dart';
import 'routing/route_generator.dart';
import 'routing/route_names.dart';
import 'ui/core/theme/default_theme.dart';

void main() {
  runApp(
   const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: <NavigatorObserver>[RouteGenerator.routeObserver],
      title: 'Add Title',
      theme: defaultTheme(),
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: RouteNames.homePage,
    );
  }
}
''';